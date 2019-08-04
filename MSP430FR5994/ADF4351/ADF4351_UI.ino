#include <Arduino.h>
// #include <HardwareSerial.h>
#include <SPI.h>
#include "src/ADF4351/ADF4351.h"
#include "esp_log.h"

static const char* TAG = "UI"; // ESP32_log

#define CLOCKSPEED 1000000
#define CS 17
#define MOSI 23
#define CLK 18
#define MISO 19
#define CE 16

#define INITFREQ 90.7

// HardwareSerial SerialTest(2);
#define DELAYTRIGGERTIME 500 // ms


ADF4351 * PLL = NULL;
double freq = INITFREQ;




void setup(){

    PLL = new ADF4351(CS, CE);
    Serial.begin(115200);
    delay(500);
    SPI.begin();
    PLL->initialize(freq, 100); // initialize the PLL to output 400 Mhz, using an
}

void loop(){
}