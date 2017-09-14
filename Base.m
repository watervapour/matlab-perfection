clear all;
clc;

s = daq.createSession('ni');

s.addDigitalChannel('myDAQ1', 'port0/line0', 'InputOnly');
%motors might need to be declared seperately
s.addDigitalChannel('myDAQ1', 'port0/line4:7', 'OutputOnly');


%s.addDigitalChannel('myDAQ1', 'port0/line3', 'OutputOnly');
%servo channel
%s.addAnalogChannel('myDAQ1', 'port1/line0:2', 'InputOnly');
%startBackground(s);
motorSpin(s,'DF')
while true
    data = inputSingleScan(s);
    if data(1) == 1
        motorSpin(s,'DB');
    else
        motorSpin(s,'DF');
    end
    pause(0.1)
end
