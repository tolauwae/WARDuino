# Blink in WAT

This example implements the traditional "blinking LED" example for microcontrollers in WebAssembly Text Format (WAT).

To compile and flash to an ESP32 with the ESP-IDF toolchain simply run the build script:

```bash
bash ./build.sh blink
```

The script takes the name of a wat file from the main folder as argument (without extension).
