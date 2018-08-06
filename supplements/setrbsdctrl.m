%%
rpi = raspi;

%%
rpi.putFile('rbsdctrl.py','/home/pi');
rpi.system('ls /home/pi')

%%
rpi.system('sudo cp /home/pi/rbsdctrl.py /usr/local/sbin');
rpi.system('ls /usr/local/sbin')

%%
rpi.system('echo ''@reboot sudo python /usr/local/sbin/rbsdctrl.py &'' | crontab');
rpi.system('crontab -l')