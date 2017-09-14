function motorSpin(src, dir)
    if dir == 'DF' % Drive Forwards
        outputSingleScan(src,[0 1 0 0])
    elseif dir == 'DB' % Drive Backwards
        outputSingleScan(src,[1 0 0 0])    
    elseif dir == 'CO' % Claw Open
        outputSingleScan(src,[0 0 1 0])
    elseif dir == 'CC' % Claw Close
        outputSingleScan(src,[0 0 0 1])
    elseif dir == 'SM' % Stop Motors
        outputSingleScan(src,[0 0 0 0])
end
