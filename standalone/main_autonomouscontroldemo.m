%%
rpi = raspberrypi('192.168.179.7');
disp(rpi)

%%
rpi.runModel('AutonomousControlDemo')

%%
rpi.stopModel('AutonomousControlDemo')

%%
rpi.runModel('PwmClear')

%%
clear rpi

%%
%rpi.execute('sudo shutdown -h now') % Shutdown
%rpi.execute('sudo shutdown -r now') % Reboot
