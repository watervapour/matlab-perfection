global NORTH;
bLow = xx;
bHigh = xx;
rLow = xx;
rHigh = xx;

function puckCode(sensor)
    if sensor > bLow && sensor < bHigh
        % BLUE
        
        %evade puck (drive around its right side)
        % ay need to account for edge of arena, use r when north?
    elseif sensor > rLow && sensor < rHigh
        % RED
        
        %flash led
        digitalOut(s, 'CC')
        
        if NORTH == 1
            servoControl(90)
        else
            servoControl(-90)
        end
        
        digitalOut(s, 'DF')
        
        
    end
end