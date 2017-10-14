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
    elseif dir == 'TL' % Turn left
        outputSingleScan(src, [LEDSTATE 0 1 0 1 SERVOPOS])
    elseif dir == 'TR' % Turn right
        outputSingleScan(src, [LEDSTATE 1 0 1 0 SERVOPOS])
    elseif dir == 'WTL' % Wide turn left
        outputSingleScan(src, [LEDSTATE 0 1 0 0 SERVOPOS])
    elseif dir == 'WTR' % Wide turn right
        outputSingleScan(src, [LEDSTATE 0 0 1 0 SERVOPOS])
    elseif dir == 'DS' % Stop Motors
        outputSingleScan(src, [LEDSTATE 0 0 0 0 SERVOPOS])
    elseif dir == 'LS'
        outputSingleScan(src, [LEDSTATE 0 0 0 0 SERVOPOS])
    end
    
    % If duration is anything other than zero, pause for that duration
    % (This results in outputting for a set duration)
    if dur ~= 0
        pause(dur)
        % Removing this may result in speedup
        outputSingleScan(src, [LEDSTATE 0 0 0 0 SERVOPOS]) 
    end
end