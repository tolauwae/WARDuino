#ifndef ARDUINO
#include "proxy_server.h"
/* #include <asm-generic/errno-base.h> */  // Might be needed
#include <netdb.h>
#include <netinet/in.h>
#include <sys/socket.h>
#include <unistd.h>

#include <cerrno>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <nlohmann/json.hpp>

#include "../Utils/macros.h"
#include "../Utils/sockets.h"
#include "../Utils/util.h"

// TODO exception msg
const char SUCCESS[] = "";  // Empty denotes success
const char NO_HOST_ERR[] = "No host and port set";
const char CREATE_SOCK_ERR[] = "Could not create Socket";
const char INVALID_HOST[] = "Invalid host";
const char CONNECT_ERR[] = "Socket failed to connect";
const char WRITE_ERR[] = "ERROR writing to socket";
const char READ_ERR[] = "ERROR reading from socket";

struct Address {
    struct sockaddr_in aserv_addr;
    struct hostent *aServer;
};

struct Socket {
    int port;
    int fileDescriptor;
    struct sockaddr_in adress;
    pthread_mutex_t *mutex;
};

bool is_success(const char *msg) {
    return (msg != nullptr) && (msg[0] == '\0');  // check if string is empty
}

const char *createConnection(int socketfd, char *host, int port,
                             struct Address *address) {
    struct hostent *server = gethostbyname(host);
    if (server == nullptr) {
        return INVALID_HOST;
    }

    address->aServer = server;
    struct sockaddr_in *server_address = &address->aserv_addr;
    bzero((char *)server_address, sizeof(*server_address));
    server_address->sin_family = AF_INET;
    bcopy((char *)server->h_addr, (char *)&server_address->sin_addr.s_addr,
          server->h_length);
    server_address->sin_port = htons(port);
    if (connect(socketfd, (struct sockaddr *)server_address,
                sizeof(*server_address)) < 0) {
        return CONNECT_ERR;
    }

    return SUCCESS;
}

bool continuing(pthread_mutex_t *mutex) {
    switch (pthread_mutex_trylock(mutex)) {
        case 0: /* if we got the lock, unlock and return true */
            pthread_mutex_unlock(mutex);
            return false;
        case EBUSY: /* return false if the mutex was locked */
            return true;
        default:
            return true;
    }
}

void *readSocket(void *input) {
    // Print value received as argument:
    dbg_info("\n=== LISTENING TO SOCKET (in separate thread) ===\n");
    ProxyServer::startPushDebuggerSocket((struct Socket *)input);
    pthread_exit(nullptr);
}

Event *parseJSON(char *buff) {
    // TODO duplicate code in Debugger::handlePushedEvent
    nlohmann::basic_json<> parsed = nlohmann::json::parse(buff);
    printf("parseJSON: %s\n", parsed.dump().c_str());
    std::string payload = *parsed.find("payload");
    return new Event(*parsed.find("topic"), payload.c_str());
}

ProxyServer *ProxyServer::proxyServer = nullptr;

ProxyServer *ProxyServer::getServer() {
    if (proxyServer == nullptr) proxyServer = new ProxyServer();
    return proxyServer;
}

bool ProxyServer::registerMCUHost(uint8_t **data) {
    int pull = (int)read_B32(data);
    int push = pull + 1;
    pull = 8080;
    push = 8081;

    auto hostsize = (uint8_t)(*data)[0];
    char *hostname = new char[hostsize + 1];
    memcpy((void *)hostname, ++(*data), hostsize);
    hostname[hostsize] = '\0';
    return ProxyServer::getServer()->registerAddresses(hostname, pull, push);
}

bool ProxyServer::registerAddresses(char *_host, int _pull_port,
                                    int _push_port) {
    if (this->host != nullptr) {
        if (this->pull_port == _pull_port && strcmp(_host, this->host) == 0) {
            return false;
        }
        this->closeConnections();
        free(this->host);
    }
    printf("Registering Proxy Host: %s PULL_PORT=%d PUSH_PORT=%d\n", _host,
           _pull_port, _push_port);
    this->host = _host;
    this->pull_port = _pull_port;
    this->push_port = _push_port;
    return true;
}

void ProxyServer::updateExcpMsg(const char *msg) {
    if (this->exceptionMsg != nullptr) delete[] this->exceptionMsg;
    auto msg_len = strlen(msg);
    this->exceptionMsg = new char[(msg_len + 1) / sizeof(char)];
    this->exceptionMsg[msg_len] = '\0';
    memcpy(this->exceptionMsg, msg, msg_len);
}

ProxyServer::ProxyServer() {
    host = exceptionMsg = nullptr;
    pull_port = 0;
    push_port = 0;
    pull_socket = -1;
    push_socket = -1;
    address = (struct Address *)malloc(sizeof(struct Address));
    addressPush = (struct Address *)malloc(sizeof(struct Address));
}

void ProxyServer::startPushDebuggerSocket(struct Socket *arg) {
    int socket = arg->fileDescriptor;

    char _char;
    uint32_t buf_idx = 0;
    const uint32_t start_size = 1024;
    uint32_t current_size = start_size;
    char *buffer = (char *)malloc(start_size);

    while (continuing(arg->mutex)) {
        if (read(socket, &_char, 1) != -1) {
            // increase buffer size if needed
            if (current_size <= (buf_idx + 1)) {
                char *new_buff = (char *)malloc(current_size + start_size);
                memcpy((void *)new_buff, (void *)buffer, current_size);
                free(buffer);
                buffer = new_buff;
                current_size += start_size;
                printf("increasing PushClient's buffer size to %d\n",
                       current_size);
            }
            buffer[buf_idx++] = _char;
            // manual nulltermination is needed because parseJSON does not use
            // first len argument
            buffer[buf_idx] = '\0';
            try {
                Event *event = parseJSON(buffer);
                CallbackHandler::push_event(event);
                WARDuino::instance()->debugger->notifyPushedEvent();
                buf_idx = 0;
            } catch (const nlohmann::detail::parse_error &e) {
            }
        }
    }
}

pthread_t ProxyServer::openConnections(pthread_mutex_t *mutex) {
    if (this->host == nullptr) {
        this->updateExcpMsg(NO_HOST_ERR);
        FATAL("problem opening socket to MCU: %s\n", this->exceptionMsg);
    }

    // Create sockets
    this->pull_socket = socket(AF_INET, SOCK_STREAM, 0);
    this->push_socket = socket(AF_INET, SOCK_STREAM, 0);
    if (this->pull_socket < 0 || this->push_socket < 0) {
        this->updateExcpMsg(CREATE_SOCK_ERR);
        FATAL("problem opening socket to MCU: %s\n", this->exceptionMsg);
    }

    // Connect to pull socket
    const char *msg = createConnection(pull_socket, this->host, this->pull_port,
                                       this->address);
    if (!is_success(msg)) {
        this->updateExcpMsg(msg);
        FATAL("problem opening socket to MCU: %s\n", this->exceptionMsg);
    }

    // Connect to push socket
    msg = createConnection(push_socket, this->host, this->push_port,
                           this->addressPush);
    if (!is_success(msg)) {
        this->updateExcpMsg(msg);  // TODO differentiate between ports
        FATAL("problem opening socket to MCU: %s\n", this->exceptionMsg);
    }

    // Listen to push socket on new thread
    pthread_t id;
    auto *args = (struct Socket *)malloc(sizeof(struct Socket));
    args->port = this->push_port;
    args->fileDescriptor = this->push_socket;
    args->mutex = mutex;
    args->adress = this->addressPush->aserv_addr;

    pthread_create(&id, nullptr, readSocket, args);

    return id;
}

void ProxyServer::closeConnections() {
    if (this->pull_socket != -1) {
        if (close(this->pull_socket) == -1) {
            if (errno == EINTR) close(this->pull_socket);
        }
        this->pull_socket = -1;
    }
}

bool ProxyServer::send(void *buffer, int size) {
    int n = write(this->pull_socket, buffer, size);
    if (n == size) return true;

    if (n < 0 && errno == EINTR)  // write interrupted, thus retry
        return this->send(buffer, size);
    else if (n < 0) {
        this->updateExcpMsg(WRITE_ERR);
        return false;
    }
    // send remaining bytes
    char *buf = (char *)buffer + n;
    return this->send((void *)buf, size - n);
}

char *ProxyServer::readReply(short int amount) {
    char *buffer = new char[amount + 1];
    bzero(buffer, amount + 1);
    int n = read(this->pull_socket, buffer, amount);
    if (n > 0) return buffer;

    delete[] buffer;
    if (errno == EINTR)  // read interrupted, thus retry
        return this->readReply(amount);

    this->updateExcpMsg(READ_ERR);
    return nullptr;
}
#endif
