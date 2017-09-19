% Phototransistor works best when red and blue light are shined onto the
% pucks, which increases the contrast, due to red reflecting the blue light
% more and the blue puck reflects the red ligt more.
% The additional light is acheived by plugging a blue and red LED into the
% always on pins, located above the 2-pin digital output. 

% variable that daq functions refer to the device as
s = daq.createSession('ni');
% declare analog input channel 0 as our
s.addAnalogInputChannel('myDAQ1', 'ai0', 'Voltage');

while true
    % Read value of input channel and output the value
    data = inputSingleScan(s)
end