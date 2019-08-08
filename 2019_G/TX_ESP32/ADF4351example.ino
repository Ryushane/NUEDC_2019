#include "ADF4351.h"

#include <Arduino.h>
#include <HardwareSerial.h>
#include "src/UIX/UIX.h"
#include <String.h>
#include <SPI.h>
#include <driver/adc.h>
#include <driver/dac.h>
#include <esp_log.h>
static const char* TAG = "My_ESP32";


#define clock 14
#define data 13
#define LE 33
#define LE2 25
#define CE 32

# define CLOCKSPEED 1000000
# define uchar unsigned char

//SCLK = 14, MISO = 12, MOSI = 13, SS = 15
# define cs 26
# define miso 12                                     
# define mosi 13
# define sclk 14

SPIClass * hspi = NULL;
UIX uix;

bool fc_shift_en;

char sendstr[100]="";
char recvstr[100]="";

void btnsendclick0(int tag,UIXButton* obj);
void btnsendclick1(int tag,UIXButton* obj);
void btnsendclick2(int tag,UIXButton* obj);

unsigned long last_time;

UIXInputBox inptsend0(20,120,20,50,COLVSBLUE,COLCYAN,sendstr);   //input box
UIXButton btnsend0(130,180,20,50,COLVSBLUE,COLCYAN,"Set",btnsendclick0);
UIXButton btnsend1(10,160,60,90,COLVSBLUE,COLCYAN,"Enable fc Shift",btnsendclick1);
UIXButton btnsend2(10,160,100,130,COLVSBLUE,COLVSORANGE,"Disable fc Shift",btnsendclick2);

int16_t adc_read(){
    signed long adc_sum = 0;
    int16_t adc_result = 0;
    int16_t adc_temp = 0;
    for (int i = 0; i<1600;i++){
        adc_temp = adc1_get_raw(ADC1_CHANNEL_6);
        adc_sum = adc_sum + adc_temp;
        // Serial.println(adc_sum);
    }
    adc_result = adc_sum/100;
    return adc_result;
}


void btnsendclick0(int tag,UIXButton* obj){
    // int val = adc_read();
    // Serial.println(val);
    int calib;
    // sscanf(sendstr,"%d",calib);
    calib = atoi(sendstr);
    
    (hspi)->beginTransaction(SPISettings(CLOCKSPEED, MSBFIRST, SPI_MODE0)); 
    digitalWrite(cs , LOW);

    Serial.print(" ");
    Serial.print((calib & 0xFF00)>>8,HEX);
    Serial.print(" ");
    Serial.println((calib & 0x00FF),HEX);
    (hspi)->transfer((calib & 0XFF00) >> 8);
    (hspi)->transfer((calib & 0X00FF));
    // Serial.println(temp_read);
    digitalWrite(cs , HIGH);
    (hspi)->endTransaction();
    // ESP_LOGI(TAG,"Button Pressed");

};

void btnsendclick1(int tag,UIXButton* obj){
    fc_shift_en = true;
}

void btnsendclick2(int tag,UIXButton* obj){
    fc_shift_en = false;

    (hspi)->beginTransaction(SPISettings(CLOCKSPEED, MSBFIRST, SPI_MODE0)); 
    digitalWrite(cs , LOW);
    // uchar temp = atoi(sendstr);
    (hspi)->transfer(0XFF);
    (hspi)->transfer(0XFF);
    // Serial.println(temp_read);
    digitalWrite(cs , HIGH);
    (hspi)->endTransaction();
}


ADF4351 adf4351(clock,data,LE,CE); // declares object PLL of type ADF4351
ADF4351 adf4351_2(clock,data,LE2,CE); // declares object PLL of type ADF4351
void setup() {
  Serial.begin(115200);
  adf4351.begin();
  adf4351_2.begin();

  // // ref = 100M RFout = 200M
  // adf4351.WriteRegister(0x00580005); // default value LD working mode
  // adf4351.WriteRegister(0xCC803C); // output divider = 16 // band select clock divider
  // adf4351.WriteRegister(0x000004B3); // default Antibacklash pulse width
  // adf4351.WriteRegister(0x00010E42); // noise mode, R=4
  // adf4351.WriteRegister(0x0008011); // prescaler=4/5、 MOD=25
  // adf4351.WriteRegister(0x400000); // int = 128 frac = 0

  // // ref = 1M RFout = 48.5M
  // adf4351.WriteRegister(0x00580005); // default value LD working mode
  // adf4351.WriteRegister(0xC0803C); // output divider = 16 // band select clock divider
  // adf4351.WriteRegister(0x000004B3); // default Antibacklash pulse width
  // adf4351.WriteRegister(0x4E42); // noise mode, R=4
  // adf4351.WriteRegister(0x8008011); // prescaler=4/5、 MOD=25
  // adf4351.WriteRegister(0x4B00000); // int = 128 frac = 0

//   // ref = 100M RFout = 42.5M
//   adf4351.WriteRegister(0x00580005); // default value LD working mode
//   adf4351.WriteRegister(0xEC803C); // output divider = 16 // band select clock divider
//   adf4351.WriteRegister(0x000004B3); // default Antibacklash pulse width
//   adf4351.WriteRegister(0x10E42); // noise mode, R=4
//   adf4351.WriteRegister(0x80080C9); // prescaler=4/5、 MOD=25
//   adf4351.WriteRegister(0x3D00B0); // int = 128 frac = 0


//   // ref = 100M RFout = 38M
//   adf4351_2.WriteRegister(0x00580005); // default value LD working mode
//   adf4351_2.WriteRegister(0xEC803C); // output divider = 16 // band select clock divider
//   adf4351_2.WriteRegister(0x000004B3); // default Antibacklash pulse width
//   adf4351_2.WriteRegister(0x10E42); // noise mode, R=4
//   adf4351_2.WriteRegister(0x80080C9); // prescaler=4/5、 MOD=25
//   adf4351_2.WriteRegister(0x308038); // int = 128 frac = 0

// 100M test
  // ref = 100M RFout = 150M
  adf4351.WriteRegister(0x00580005); // default value LD working mode
  adf4351.WriteRegister(0xCC803C); // output divider = 16 // band select clock divider
  adf4351.WriteRegister(0x000004B3); // default Antibacklash pulse width
  adf4351.WriteRegister(0x10E42); // noise mode, R=4
  adf4351.WriteRegister(0x8008011); // prescaler=4/5、 MOD=25
  adf4351.WriteRegister(0x300000); // int = 128 frac = 0


  // ref = 100M RFout = 101.5M
  adf4351_2.WriteRegister(0x00580005); // default value LD working mode
  adf4351_2.WriteRegister(0xDC803C); // output divider = 16 // band select clock divider
  adf4351_2.WriteRegister(0x000004B3); // default Antibacklash pulse width
  adf4351_2.WriteRegister(0x10E42); // noise mode, R=4
  adf4351_2.WriteRegister(0x80080C9); // prescaler=4/5、 MOD=25
  adf4351_2.WriteRegister(0x4080B8); // int = 128 frac = 0

  Serial.println("All registers have benn written!");

  // commu
  pinMode(cs,OUTPUT);
  Serial.begin(115200);

  adc1_config_width(ADC_WIDTH_BIT_12);
  adc1_config_channel_atten(ADC1_CHANNEL_6, ADC_ATTEN_DB_6);  // 6dB: Dynamic Range 2.2V

  hspi = new SPIClass(HSPI);
  if(hspi==NULL)
      Serial.print("SPI INITIALIZATION FAILED.");
  //SCLK = 14, MISO = 12, MOSI = 13, SS = 15
  hspi->begin();

  uixuserpanelnum=1;  //no more than 46
  uixpanels[0].label="2019 G";
  uixpanels[0].uixobjects+=inptsend0;
  uixpanels[0].uixobjects+=btnsend0;
  uixpanels[0].uixobjects+=btnsend1;
  uixpanels[0].uixobjects+=btnsend2;
  uix.begin();

  bool fc_shift_en = true;

}


signed short last_val = 0;
signed short temp_val;

void loop() {
  // put your main code here, to run repeatedly: 
    uix.tick();

    if (fc_shift_en){
        unsigned long temp_millis = millis();
        if (temp_millis - last_time > 10){
            last_time = temp_millis;
            signed short val = adc_read();
            val = val - 0x8000;
            // Serial.print(val);
            // Serial.print(" ");

            if (val>last_val+25){
                temp_val = val;
                last_val = val;
            }
            else if(val<last_val-25){
                temp_val = val;
                last_val = val;
            }
            else{
                temp_val = last_val;
            }

            // Serial.println(temp_val);

            (hspi)->beginTransaction(SPISettings(CLOCKSPEED, MSBFIRST, SPI_MODE0)); 
            digitalWrite(cs , LOW);
            // uchar temp = atoi(sendstr);
            // Serial.print((val & 0xFF00)>>8,HEX);
            // Serial.print(" ");
            // Serial.println((val & 0x00FF),HEX);
            (hspi)->transfer((temp_val & 0XFF00) >> 8);
            (hspi)->transfer((temp_val & 0X00FF));
            // Serial.println(temp_read);
            digitalWrite(cs , HIGH);
            (hspi)->endTransaction();

        }

    }
    // else{
    //     Serial.println("Disabled...");
    // }

    // (hspi)->beginTransaction(SPISettings(CLOCKSPEED, MSBFIRST, SPI_MODE0)); 
    // digitalWrite(cs , LOW);
    // (hspi)->transfer(0xAA);
    // digitalWrite(cs , HIGH);
    // (hspi)->endTransaction();
    // delay(100);  
}