#include <SPI.h>
#include "./src/ADF4351.h"

#define CLOCKSPEED 100000
#define CS P3_0
#define MOSI P5_0
#define SCLK P5_2
#define CE P3_1

//SPIClass * vspi = NULL;
ADF4351 * PLL = NULL; // declares object PLL of type ADF4351. Will initialize it below.
// mesh.setDebugMsgTypes(ERROR | DEBUG | CONNECTION); // set before init() so that you can see startup messages
void setup(){
    PLL = new ADF4351(CS, CE);
    Serial.begin(115200);
    delay(500); // give it a sec to warm up
    SPI.begin();          // for communicating with DDS/PLLs

    PLL->initialize(37.8, 100); // initialize the PLL to output 400 Mhz, using an
    delay(5000);
                            // onboard reference of 10Mhz
}

void loop(){
   PLL->setFreq(40.7);
}
