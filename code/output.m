% (output pos) | line number | Actuator
%
% (1) | line 3 | LED output
%
% For motors, Yellow wire on lower number
% (2, 3) | line 4:5 | Right Motor
% (4, 5) | line 6:7 | Left Motor
%
% (6) | ao0 | Servo

global LEDSTATE;
global SERVOPOS;

function output(src, dir, dur)
    if dir == 'DF' % Drive Forwards
        outputSingleScan(src, [LEDSTATE 0 1 1 0 SERVOPOS])
    elseif dir == 'DB' % Drive Backwards
        outputSingleScan(src, [LEDSTATE 1 0 0 1 SERVOPOS])    
    elseif dir == 'TL' % Claw Open
        outputSingleScan(src, [LEDSTATE 0 1 0 1 SERVOPOS])
    elseif dir == 'TR' % Claw Close
        outputSingleScan(src, [LEDSTATE 1 0 1 0 SERVOPOS])
    elseif dir == 'DS' % Stop Motors
        outputSingleScan(src, [LEDSTATE 0 0 0 0 SERVOPOS])
    elseif dir == 'LS'
        outputSingleScan(src, [LEDSTATE 0 0 0 0 SERVOPOS])
    end
    
    if dur ~= 0
        pause(dur)
    end
end