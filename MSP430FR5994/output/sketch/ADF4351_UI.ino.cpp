#line 1 "e:\\ryush\\Documents\\Git_Local_Repository\\C\\NUEDC_2019\\MSP430FR5994\\ADF4351\\ADF4351_UI.ino"
#line 1 "e:\\ryush\\Documents\\Git_Local_Repository\\C\\NUEDC_2019\\MSP430FR5994\\ADF4351\\ADF4351_UI.ino"
#include <Arduino.h>
// #include <HardwareSerial.h>
#include <SPI.h>
#include "src/ADF4351/ADF4351.h"
#include "esp_log.h"

static const char* TAG = "UI"; // ESP32_log

#define CLOCKSPEED 1000000
#define CS 1
#define MOSI 23
#define CLK 18
#define MISO 19
#define CE 3

#define INITFREQ 90.7

#define ADC_PIN 36
#define DA_OUT 25
// HardwareSerial SerialTest(2);
#define DELAYTRIGGERTIME 500 // ms




SPIClass * hspi = NULL;
ADF4351 * PLL = NULL;



double freq = INITFREQ;




#line 36 "e:\\ryush\\Documents\\Git_Local_Repository\\C\\NUEDC_2019\\MSP430FR5994\\ADF4351\\ADF4351_UI.ino"
void setup();
#line 47 "e:\\ryush\\Documents\\Git_Local_Repository\\C\\NUEDC_2019\\MSP430FR5994\\ADF4351\\ADF4351_UI.ino"
void loop();
#line 36 "e:\\ryush\\Documents\\Git_Local_Repository\\C\\NUEDC_2019\\MSP430FR5994\\ADF4351\\ADF4351_UI.ino"
void setup(){

    hspi = new SPIClass(HSPI);
    PLL = new ADF4351(CS, CE);

    Serial.begin(115200);
    delay(500);
    hspi->begin();
    PLL->initialize(freq, 100); // initialize the PLL to output 400 Mhz, using an
}

void loop(){
}
