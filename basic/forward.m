function forward(rpi)
rpi.writeDigitalPin(19,1); % High
rpi.writeDigitalPin(20,0); % Low
rpi.writeDigitalPin(21,1); % High
rpi.writeDigitalPin(26,0); % Low
end