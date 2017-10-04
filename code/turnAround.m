global NORTH;

function turnAround()
    % back up a little
    output(s, 'DB', 0.1)
    
    if NORTH == 1
        % Turn R
        output(s, 'TR', 0.2)
    else
        % Turn L
        output(s, 'TL', 0.2)
    end
    
end