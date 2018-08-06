# Move this file to /usr/local/sbin
#
#   $ sudo cp ./rdsdctrl.py /usr/local/sbin
#
# Add the following lines to /etc/rc.local 
# 
#   sudo python /usr/local/sbin/rbsdctrl.py &
#   exit 0
#
# Or set crontab 
#
#   echo '@reboot sudo python /usr/local/sbin/rbsdctrl.py &' | crontab
#
# How to shutdown
#
#   Keep pusshing the button over 3 seconds
#
# How to reboot
#
#   Just hit the button
#
#
#
import RPi.GPIO as GPIO
import time
import os

GPIO.setmode(GPIO.BCM)
GPIO.setup(25,GPIO.IN,pull_up_down=GPIO.PUD_DOWN)

button_previous  = 0
button_current   = 0
brojac           = 0
flag_pressed     = 0

while True:

  button_current = GPIO.input(25);
  flag_pressed   = button_previous * button_current

  if (flag_pressed):
    brojac += 1
  else:
    brojac = 0

  if ((not button_current) and button_previous):
    #print("Reboot")
    os.system("sudo wall Reboot")    
    #os.system("sudo shutdown -r now")
  if (flag_pressed and brojac >= 100):
    #print("Shutdown")
    os.system("sudo wall Shutdown")        
    #os.system("sudo shutdown -h now")
    break
  
  button_previous = button_current
  time.sleep(0.03)
