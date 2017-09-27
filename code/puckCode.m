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
            digitalOut('TR')
            pause(0.3)
            digitalOut('DF')
        else
            digitalOut('TL')
            pause(0.3)
            digitalOut('DF')
        end
        
        
    end
end