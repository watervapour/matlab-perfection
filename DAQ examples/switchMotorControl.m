% this code will run a motor plugged into DO 4/5 when a switch in DI 0 is
% pressed
% =========================================================================


% create a session (what to reference to the daq with)
s = daq.createSession('ni');
% specify that line 0of port 0 is the input (DI:0)
s.addDigitalChannel('myDAQ1', 'port0/line0', 'InputOnly');
% specify that lines 4 & 5 of port 0 are outputs (D0:4 & DO:5)
s.addDigitalChannel('myDAQ1', 'port0/line4:5', 'OutputOnly');


% infinite loop
while true
    % assign data variable the boolean status of the switch
    data = inputSingleScan(s);
    % check if swithc is pressed
    if data == 1
        % power pin 5, spinning motor
        outputSingleScan(s, [0 1])
    else
        % dont power any pins, motor will not spin
        outputSingleScan(s, [0 0])
    end
end

% while the code in the while loop can be shortened to 
% outputSingleScan(s, [0 inputSingleScan(s)])
% it is more human readable in the longer form