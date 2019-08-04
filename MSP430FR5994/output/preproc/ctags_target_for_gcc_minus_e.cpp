# 1 "e:\\ryush\\Documents\\Git_Local_Repository\\C\\NUEDC_2019\\MSP430FR5994\\ADF4351\\ADF4351_UI.ino"
# 1 "e:\\ryush\\Documents\\Git_Local_Repository\\C\\NUEDC_2019\\MSP430FR5994\\ADF4351\\ADF4351_UI.ino"
# 2 "e:\\ryush\\Documents\\Git_Local_Repository\\C\\NUEDC_2019\\MSP430FR5994\\ADF4351\\ADF4351_UI.ino" 2
// #include <HardwareSerial.h>
# 4 "e:\\ryush\\Documents\\Git_Local_Repository\\C\\NUEDC_2019\\MSP430FR5994\\ADF4351\\ADF4351_UI.ino" 2
# 5 "e:\\ryush\\Documents\\Git_Local_Repository\\C\\NUEDC_2019\\MSP430FR5994\\ADF4351\\ADF4351_UI.ino" 2
# 6 "e:\\ryush\\Documents\\Git_Local_Repository\\C\\NUEDC_2019\\MSP430FR5994\\ADF4351\\ADF4351_UI.ino" 2

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
#define DELAYTRIGGERTIME 500 /* ms*/




SPIClass * hspi = 
# 26 "e:\\ryush\\Documents\\Git_Local_Repository\\C\\NUEDC_2019\\MSP430FR5994\\ADF4351\\ADF4351_UI.ino" 3 4
                 __null
# 26 "e:\\ryush\\Documents\\Git_Local_Repository\\C\\NUEDC_2019\\MSP430FR5994\\ADF4351\\ADF4351_UI.ino"
                     ;
ADF4351 * PLL = 
# 27 "e:\\ryush\\Documents\\Git_Local_Repository\\C\\NUEDC_2019\\MSP430FR5994\\ADF4351\\ADF4351_UI.ino" 3 4
               __null
# 27 "e:\\ryush\\Documents\\Git_Local_Repository\\C\\NUEDC_2019\\MSP430FR5994\\ADF4351\\ADF4351_UI.ino"
                   ;



double freq = 90.7;




void setup(){

    hspi = new SPIClass(2 /*SPI bus normally mapped to pins 12 - 15, but can be matrixed to any pins*/);
    PLL = new ADF4351(1, 3);

    Serial.begin(115200);
    delay(500);
    hspi->begin();
    PLL->initialize(freq, 100); // initialize the PLL to output 400 Mhz, using an
}

void loop(){
}
