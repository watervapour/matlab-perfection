% Motor spins direction depending on button hit

% create variable for daq functions to refer to the device with
s = daq.createSession('ni');

% declare DI:0 and DI:1 as inputs
s.addDigitalChannel('myDAQ1', 'port0/line0:1', 'InputOnly');
% decalre Do:4 and Do:5 as outputs
s.addDigitalChannel('myDAQ1', 'port0/line4:5', 'OutputOnly');

while true
   % assign state of all pins as arry called data
   data = inputSingleScan(s)
   % power the out put pins based on the state of the array "data"
   outputSingleScan(s, [data(1), data(2)]) ;
end