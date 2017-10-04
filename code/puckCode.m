global NORTH;
global LEDSTATE;
global SERVOPOS;
bLow = xx;
bHigh = xx;
rLow = xx;
rHigh = xx;
gLow = xx;
gHigh = xx;

function puckCode(colour)
    if colour > bLow && colour < bHigh
        % BLUE
        
        % evade puck (drive around its right side)
        % back up a little
        output(s, 'DB')
        pause(0.1)

        if NORTH == 1
            % Turn R
            output(s, 'TR')
            pause(0.1)
        else
            % Turn L
            output(s, 'TL')
            pause(0.1)
        end

        % power motor for a bit
        output(s, 'DF')
        pause(0.3)
        output(s, 'DS')

        % Snake around
        if NORTH == 1
            output(s, 'TL')
            pause(0.1)
            output(s, 'TR')
            pause(0.1)
        else
            output(s, 'TR')
            pause(0.1)
            output(s, 'TL')
            pause(0.1)
        end
    elseif colour > rLow && colour < rHigh
        % RED
        
        % turn on led, close 'claw'
        LEDSTATE = 1;
        SERVOPOS = 3;
        output(s, 'LS')
        
        if NORTH == 1
            digitalOut('TR')
            pause(0.3)
        else
            digitalOut('TL')
            pause(0.3)
        end
    end
    digitalOut('DF')
    
    % safe zone code
    notSafe = true;
    while notSafe = true
        ground = inputSingleScan(s)(5);
        if ground > gLow && ground < gHigh
            notSafe = false;
        end
        % pause(0.05)
    end
    % now in safe zone
    
    % update led and servo
    LEDSTATE = 0;
    SERVOPOS = 10;
    output(s, 'LS')
    pause(0.2)
    % get clear of puck
    output(s, 'DB')
    pause(0.2)
    
    % flee home
    output(s, 'TR')
    pause(0.2)
    output(s, 'DF')
    % not hit wall yet loop
    while data(1) == 0
        data = inputSingleScan(s);
        output(s, 'DF')
    end
    %TR 90
    output(s, 'TR')
    pause(0.2)
    %not hit wall yet again
    while data(1) == 0
        data = inputSingleScan(s);
        output(s, 'DF')
    end
    %TR 90
    output(s, 'TR')
    pause(0.2)
end