#ifndef _SOFTPWM_OUTPUT_RASPI_H_
#define _SOFTPWM_OUTPUT_RASPI_H_
#include "rtwtypes.h"
    
void softPwmOutputSetup(uint8_T pin, int32_T initialValue, int32_T pwmRange);
void writeSoftPwmPin(uint8_T pin, uint8_T val);

#endif //_SOFTPWM_OUTPUT_RASPI_H_

