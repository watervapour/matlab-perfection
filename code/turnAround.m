global NORTH;

function turnAround()
    if NORTH == 1
        % Turn R
    else
        % Turn L
    end
    
    % power motor for a bit
    digitalOut(s, 'DF')
    pause(0.3)
    digitalOut(s, 'SM')
    
    
end