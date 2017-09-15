% this code will read the status of switches plugged into digital input
% pins 0/1/2 and output their values into the command window
% =========================================================================


% create a session (what to reference to the daq with)
s = daq.createSession('ni');
% specify that lines 0, 1 and 2 of port 0 are inputs (DI:0, DI:1 & DI:2)
s.addDigitalChannel('myDAQ1', 'port0/line0:2', 'InputOnly');


% infinite loop
while true
   % variable data is populated by a scan of input channels
   data = inputSingleScan(s)
   % as data will be an array access a particular channel with
   % data(x)
   % channel position in arry not determined by number, rather by order in
   % which its declared
end