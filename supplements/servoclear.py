import wiringpi as pi, time, math

servo_pin = 18

pi.wiringPiSetupGpio()
pi.pinMode( servo_pin, 2 )
pi.pwmSetMode(0)
pi.pwmSetRange(1024)
pi.pwmSetClock(375)

angle_deg = 0

move_deg = int(74 + 48 / 90 * angle_deg)

pi.pwmWrite( servo_pin, move_deg )
