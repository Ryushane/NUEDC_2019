#include <Arduino.h>
// #include <HardwareSerial.h>
#include <SPI.h>
#include "src/UIX/UIX.h"
#include "src/ADF4351/ADF4351.h"
#include "esp_log.h"

#include "driver/dac.h"
#include "driver/adc.h"
#include "esp_adc_cal.h"


static const char* TAG = "UI"; // ESP32_log

#define CLOCKSPEED 1000000
#define CS 32 // 35不能作为输出端口，要换一个
#define MOSI 13
#define CE 33

#define INITFREQ 90.7

#define ADC_PIN 36
#define DA_OUT 25
// HardwareSerial SerialTest(2);
#define DELAYTRIGGERTIME 500 // ms



UIX uix;

SPIClass * hspi = NULL;
ADF4351 * PLL = NULL;

void adcget(int tag, UIXButton* obj);

void btnapplyclick(int tag, UIXButton* obj);
void btnsweepclick(int tag, UIXButton* obj);

void btnfreqplus(int tag, UIXButton* obj);
void btnfreqminus(int tag, UIXButton* obj);
void delaybtntrigger(int tag, UIXButton* obj);
void sendchar(char *);

void arrayConvolve(double*, double*, int, int);
// void reverseArray(double*, int);



char freqstr[100]="";
char recvstr[100]="";
char swpstr[100]="";
char adcstr[100]="";

double freq = INITFREQ;

int swpconfig = 1;
bool swp_flag = 0;
int swp_counter = 0;

bool tickflag = false;

unsigned long lastmillis = 0;

bool trigger_flag = 0;
unsigned long lasttrigger = 0;

double ampdata[300];
double swpdata[300];
double invker[16] = {0.0148189, -0.0112552, -0.0139333, 0.053656, -0.0694247, 0.00448376, \
0.157711, -0.312902, 0.221711, 0.32478, -1.15388, 1.44223, -0.167504, \
-0.1426, 0.0349846, 0.0106429};

int dacdata[300] = {89, 89, 88, 87, 87, 88, 88, 87, 87, 88, 87, 87, 87, 87, 87, 87, 87, \
91, 87, 86, 88, 86, 97, 86, 86, 95, 89, 86, 88, 87, 87, 88, 100, 87, \
86, 90, 96, 86, 85, 85, 85, 102, 87, 85, 87, 85, 98, 88, 85, 84, 84, \
101, 86, 84, 84, 84, 92, 84, 83, 84, 84, 84, 83, 83, 83, 83, 83, 83, \
84, 89, 93, 83, 83, 83, 83, 82, 82, 83, 93, 104, 110, 88, 83, 82, 82, \
81, 81, 108, 157, 169, 174, 153, 140, 103, 81, 81, 81, 117, 166, 178, \
182, 161, 148, 113, 81, 80, 80, 108, 157, 169, 174, 153, 140, 104, \
80, 80, 80, 80, 92, 104, 109, 88, 81, 80, 80, 80, 80, 80, 81, 88, 92, \
80, 80, 80, 80, 80, 80, 79, 80, 80, 81, 80, 79, 79, 79, 80, 79, 80, \
79, 80, 80, 80, 79, 80, 80, 80, 80, 80, 80, 79, 80, 80, 80, 80, 79, \
80, 80, 80, 80, 80, 80, 80, 80, 80, 81, 80, 80, 81, 81, 81, 80, 81, \
81, 81, 81, 81, 81, 81, 81, 81, 81, 81, 82, 81, 82, 82, 82, 82, 82, 82};

// find max freq
int maxlabel = 0;

// UIXPlot
double xlabel[200];
double ylabel[200];

UIXInputBox dispadc(20, 130, 80, 120, COLVSBLUE, COLCYAN, adcstr);
UIXButton btnadc(140, 220, 80, 120, COLVSBLUE, COLCYAN, "ADC", adcget);

UIXInputBox inptfreq(20, 130, 140, 180, COLVSBLUE, COLCYAN, freqstr);
UIXButton btnapply(20, 100, 185, 225, COLVSBLUE, COLCYAN, "APPLY", btnapplyclick);


UIXButton freqplus(140, 220, 140, 180, COLDARKGRAY, COLCYAN, "+", delaybtntrigger);
UIXButton freqminus(140, 220, 185, 225, COLDARKGRAY, COLCYAN, "-", delaybtntrigger);

UIXInputBox inptswpconfig(20, 130, 240, 280, COLVSBLUE, COLCYAN, swpstr);
UIXButton btnsweep(140, 220, 240, 280, COLVSBLUE, COLCYAN, "SWEEP", btnsweepclick);


UIXConsole console(sendchar);

UIXPlot plotpanel(30 ,220, 20, 200, xlabel, ylabel, 75, 105, 0, 1000, COLORANGE, 2, true, true);

double swpadc(){
    int lptime = 10;
    int adc_temp;
    int adc_sum=0;
    double adc_out;
    for (int i=0; i<lptime; i++){
        adc_temp = adc1_get_raw(ADC1_CHANNEL_0);
        adc_sum += adc_temp;
    }
    adc_out = ((double)adc_sum) / lptime;    
    return adc_out;
}

void adcget(int tag, UIXButton* obj){
    adcstr[0]='\0';    //clear received string
    int lptime = 10;
    int adc_temp;
    int adc_sum=0;
    double adc_out;
    for (int i=0; i<lptime; i++){
        adc_temp = adc1_get_raw(ADC1_CHANNEL_0);
        adc_sum += adc_temp;
    }
    adc_out = ((double)adc_sum) / lptime;
    sprintf(adcstr, "%lf", adc_out);
}


void btnapplyclick(int tag, UIXButton* obj){
    sscanf(freqstr, "%lf", &freq);
    // Serial.println(freq);
    frequpdate();
    obj->selected = false;
}

void btnsweepclick(int tag, UIXButton* obj){
    sscanf(swpstr, "%d", &swpconfig);
    swp_flag = 1;
    lastmillis = millis();
}

// callback
void sendchar(char * testchar){
    console.log("Received char %s", testchar);
}

void delaybtntrigger(int tag, UIXButton* obj){
    // lasttrigger = millis();
    //doing nothing
}




// func
void frequpdate(){
    PLL->setFreq(freq);
    freqstr[0]='\0';    //clear received string
    sprintf(freqstr, "%lf", freq);
    inptfreq.invalidate();
}


// deconvolution
void arrayConvolve(double* ker, double* data, int kersize, int datasize) {
    double temp = 0;
	//for (int j = 0; j < datasize; j++)
	//	printf("data = %lf", data[]);
	for (int i = 0; i < (datasize - kersize + 1); i++) {
		for (int k = 0; k < kersize; k++) {
			temp += ker[kersize - k - 1] * data[(i+k)];
		}
		data[i] = temp;
		temp = 0;
	}
	for (int j = 0; j < (kersize-1); j++) {
		data[datasize-j-1] = 0;
	}
}

// void reverseArray(double* arr,int size) {
// 	for (int i = 0; i < size / 2; i++) {
// 		double temp = arr[i];
// 		arr[i] = arr[size - 1 - i];
// 		arr[size - 1 - i] = temp;
// 	}
// }


// int findspur(double* arr, int size, int windowsize, double maxamp){
//     int spurNum = 0;
//     for(int i=0; i<size; i++){
//         if()
//     }
// }


void setup(){

    hspi = new SPIClass(HSPI);
    PLL = new ADF4351(CS, CE, hspi);

    adc1_config_width(ADC_WIDTH_BIT_12);
    adc1_config_channel_atten(ADC1_CHANNEL_0, ADC_ATTEN_DB_11);  // 6dB: Dynamic Range 2.2V

    dac_output_enable(DAC_CHANNEL_1);
    dac_output_voltage(DAC_CHANNEL_1, 0);

    Serial.begin(115200);
    delay(500);
    hspi->begin();
    PLL->initialize(freq, 100); // initialize the PLL to output 400 Mhz, using an
    sprintf(freqstr, "%lf", freq);
    sprintf(swpstr, "%d", swpconfig);

    pinMode(15, OUTPUT);

    uixuserpanelnum = 3;
    uixpanels[0].label="PLL";
    uixpanels[0].uixobjects+=inptfreq;
    uixpanels[0].uixobjects+=btnapply;
    uixpanels[0].uixobjects+=freqplus;
    uixpanels[0].uixobjects+=freqminus;

    uixpanels[0].uixobjects+=dispadc;
    uixpanels[0].uixobjects+=btnadc;
    uixpanels[0].uixobjects+=inptswpconfig;
    uixpanels[0].uixobjects+=btnsweep;


    uixpanels[1].label="Console";
    uixpanels[1].uixobjects+=console;

    uixpanels[2].label="Plot";
    uixpanels[2].uixobjects+=plotpanel;
    uix.begin();
    // UIXPlot xlabel init
    for(int i=0; i<200; i++)
    {
        xlabel[i] = 80 + i*0.1;
    }
}

void loop(){
    tickflag = uix.tick();
    if((freqminus.pressed || freqplus.pressed) && trigger_flag == 0){
        lasttrigger = millis();
        trigger_flag = 1;
    }
    if(freqminus.pressed && (trigger_flag==1) && (millis() - lasttrigger) > DELAYTRIGGERTIME){
        if(tickflag){
            freq = freq - 0.1;
            frequpdate();
        }
    }
    if(freqplus.pressed && (trigger_flag==1) && (millis() - lasttrigger) > DELAYTRIGGERTIME){
        if(tickflag){
            freq = freq + 0.1;
            frequpdate();
        }
    }

    if(!freqplus.pressed && !freqminus.pressed){
        trigger_flag = 0;
    }

    if(swp_flag && ((millis() - lastmillis) >= (swpconfig * 5))){
        dac_output_voltage(DAC_CHANNEL_1, dacdata[swp_counter]);       
        lastmillis += swpconfig * 5;
        freq = freq + 0.1;
        delayMicroseconds(100*swpconfig); // 这里延时一个swpconfig等待锁相环稳定
        swpdata[swp_counter] = swpadc();
        swp_counter += 1;
        frequpdate();
        // 由功率映射成Vpp,然后进行反卷积0.012847029007901344` E^(0.003834755854437685` #) &
        if(swp_counter == 215){
            // Serial.println("ADCdata is");
            for(int i=0; i<215; i++)
            {
                Serial.printf("%lf,",swpdata[i]);
                ampdata[i] = 0.012847029007901344* exp(0.003834755854437685 * swpdata[i]);
            }

            Serial.printf("\nAmp data:\n");
            for(int i=0; i<200; i++)
            {
                if(ampdata[i] > ampdata[maxlabel]){
                    maxlabel = i;
                    // Serial.println("Get MAX!");
                }
                Serial.printf("%lf,",ampdata[i]);
            }
            // Serial.printf("\nMAX LABEL = %d", maxlabel);
            double maxFreq;
            maxFreq = 80 + (maxlabel+1)* 0.1;
            Serial.printf("\n MAX amp Freq is %lf",maxFreq);

            // 计算杂散频率个数
            // findspur()
            // deconvolution module
            arrayConvolve(invker, ampdata, 16, 215); // invker size and swpdata size
            // reverseArray(ampdata, 215);
            for(int i=1; i<200; i++){
                ylabel[199-i] = ampdata[i];
            }
            // memcpy(&ylabel, &swpdata, 200);
            plotpanel.invalidate();
            Serial.println("\nDeconvolved data");

            for(int i=0; i<200; i++)
            {
                if(ampdata[i] > ampdata[maxlabel]){
                }
                Serial.printf("%lf,",ampdata[i]);
            }

            freq = freq - swp_counter * 0.1;
            frequpdate();
            swp_flag = 0;
            swp_counter = 0;
        }
    }

    // console.log("this is a test %d", counter);
    // counter = counter + 1;
}