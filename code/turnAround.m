global NORTH;

function turnAround()
    % back up a little
    output(s, 'DB')
    pause(0.1)
    
    if NORTH == 1
        % Turn R
        output(s, 'TR')
        pause(0.2)
    else
        % Turn L
        output(s, 'TL')
        pause(0.2)
    end
    
end