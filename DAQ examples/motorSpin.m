% this code will spin motors in both the 4/5 and 6/7 pair of digital
% outputs both clockwise and counter clockwise.
% =========================================================================


% create a session (what to reference to the daq with)
s = daq.createSession('ni');
% specify that lines 4, 5, 6 & 7 of port 0 are outputs (D0:4, DO:5, DO:6 & DO:7)
s.addDigitalChannel('myDAQ1', 'port0/line4:7', 'OutputOnly');


% infinite loop
while true
    delay = 0.5;
    % power line 4
    outputSingleScan(s, [1 0 0 0])
    pause(delay)
    % power line 5
    outputSingleScan(s, [0 1 0 0])
    pause(delay)
    % power line 6
    outputSingleScan(s, [0 0 1 0])
    pause(delay)
    % power line 7
    outputSingleScan(s, [0 0 0 1])
    pause(delay)
    % power no lines
    outputSingleScan(s, [0 0 0 0])
    pause(delay)
    
    
    % outputSingleScan takes 2 inputs, the session and an array of values
    % fof all output pins, with boolean values determining which lines 
    % receive power (as seen above).
end