% (1)    line 3 = LED output
% (2, 3) line 4:5 = Drive motor
% (4, 5) line 6:7 = Claw motor

function digitalOut(src, dir)
    if dir == 'FL'
        % turn LED on then off
        outputSingleScan(src, [1 0 0 0 0])
        pause(0.2)
        outputSingleScan(src, [0 0 0 0 0])
    elseif dir == 'DF' % Drive Forwards
        outputSingleScan(src, [0 0 1  0 0])
    elseif dir == 'DB' % Drive Backwards
        outputSingleScan(src, [0 1 0 0 0])    
    elseif dir == 'CO' % Claw Open
        outputSingleScan(src, [0 0 0 1 0])
    elseif dir == 'CC' % Claw Close
        outputSingleScan(src, [0 0 0 0 1])
    elseif dir == 'SM' % Stop Motors
        outputSingleScan(src, [0 0 0 0 0])
    end
end