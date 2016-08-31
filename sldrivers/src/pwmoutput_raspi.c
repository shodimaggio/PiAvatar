#include <wiringPi.h>
#include "pwmoutput_raspi.h"

// PWM Output initialization
void pwmOutputSetup(uint8_T pin, int32_T mode, int32_T divisor, uint32_T range)
{
    static int initialized = false;
    
    // Perform one-time wiringPi initialization
    if (!initialized) {
        wiringPiSetupGpio();
        initialized = true;
    }
 
    pinMode(pin,PWM_OUTPUT);
    if (mode==0) 
        pwmSetMode(PWM_MODE_MS);
    else
        pwmSetMode(PWM_MODE_BAL);
    pwmSetClock(divisor);
    pwmSetRange(range);

}

// Write an integer value to pin
void writePwmPin(uint8_T pin, uint8_T val)
{
    pwmWrite(pin, val);
}
// [EOF]
