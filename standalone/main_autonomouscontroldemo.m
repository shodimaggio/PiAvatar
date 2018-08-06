%%
rpi = raspberrypi('192.168.38.54');
disp(rpi)

%%
rpi.runModel('AutonomousControlDemo')

%%
if rpi.isModelRunning('AutonomousControlDemo')
    rpi.stopModel('AutonomousControlDemo')
else
    fprintf('Model is not running\n')
end

%%
rpi.runModel('PwmClear')
%%
clear rpi

%%
%rpi.execute('sudo shutdown -h now') % Shutdown
%rpi.execute('sudo shutdown -r now') % Reboot
