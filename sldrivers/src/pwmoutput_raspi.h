#ifndef _PWM_OUTPUT_RASPI_H_
#define _PWM_OUTPUT_RASPI_H_
#include "rtwtypes.h"
    
void pwmOutputSetup(uint8_T pin, int32_T mode, int32_T divisor, uint32_T range);
void writePwmPin(uint8_T pin, uint8_T val);

#endif //_PWM_OUTPUT_RASPI_H_