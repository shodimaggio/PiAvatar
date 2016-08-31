#include <wiringPi.h>
#include <softPwm.h>
#include "softpwmoutput_raspi.h"

// SoftPWM Output initialization
void softPwmOutputSetup(uint8_T pin, int32_T initialValue, int32_T pwmRange)
{
    static int initialized = false;
    
    // Perform one-time wiringPi initialization
    if (!initialized) {
        wiringPiSetupGpio();
        initialized = true;
    }
 
    // mode = 1: OUTPUT
    pinMode(pin,OUTPUT);
    softPwmCreate(pin,initialValue,pwmRange);
}

// Write an integer value to pin
void writeSoftPwmPin(uint8_T pin, uint8_T val)
{
    softPwmWrite(pin, val);
}
// [EOF]
