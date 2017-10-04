s = daq.createSession('ni');

% Digital I/O
s.addDigitalChannel('myDAQ1', 'port0/line0:2', 'InputOnly')
s.addDigitalChannel('myDAQ1', 'port0/line3:7', 'OutputOnly')
% Analog I/O
s.addAnalogInputChannel('myDAQ1', 'ai0:1', 'Voltage')
s.addAnalogOutputChannel('myDAQ1', 'ao0', 'Voltage')

global NORTH; % direction bot is facing
global LEDSTATE;
global SERVOPOS;

while true
    % read inputs
    data = inputSingleScan(s);
    
    % have we hit arena wall?
    if data(1) == 1
        % Run turn around script
        turnAround()
    end
    
    % check if we have a puck
    puckCode(data(4), data(5))
    
    % drive
    output(s, 'DF', 0)
end