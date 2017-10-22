clear;clc;

% Create session
s = daq.createSession('ni');

% Digital I/O
s.addDigitalChannel('myDAQ1', 'port0/line0:2', 'InputOnly')
s.addDigitalChannel('myDAQ1', 'port0/line3:7', 'outputOnly')
% Analog I/O
s.addAnalogInputChannel('myDAQ1', 'ai0', 'Voltage')
s.addAnalogInputChannel('myDAQ1', 'ai1', 'Voltage')
s.addAnalogOutputChannel('myDAQ1', 'ao0', 'Voltage')

% (input pos) | line number | Input
%
% Digital
% (1) | line 0 | Front bumper switch
% (2) | line 1 | Unused switch
% (3) | line 1 | Unused switch
% Analog
% (4) | ai0 | Colour detection phototransistor
% (5) | ai1 | Safe zone line detection phototransistor

% (output pos) | line number | Actuator
%
% (1) | line 3 | LED output
% For motors, Yellow wire on lower number
% (2, 3) | line 4:5 | Right Motor
% (4, 5) | line 6:7 | Left Motor
% (6) | ao0 | Servo

% Direction bot is facing (North is 'up' with the safe zone on the right)
global NORTH;
NORTH = 1;
% Boolean state of 'landmine' detected LED
global LEDSTATE; 
LEDSTATE = 0;
% 0-10 value for position of servo; 0 is lowered, 10 raised
global SERVOPOS;
SERVOPOS = 10;

% Voltage readings for puck photo transistor, readings between
% the 'low' and 'high' indicate what is being deteced
rLow = 1.0;   % Maximum value for red puck
rHigh = 2; % Maximum value for red puck
bLow = 0.31;  % Minumum value for blue puck
bHigh = 0.33; % Maximum value for blue puck
lLow = 0.1;  % Maximum value for safe zone line
lHigh = 0.16; % Maximum value for safe zone line


% Eternally looping program, equivilant to main() for arduino
data=inputSingleScan(s);
while data(2) == 0
    % Move forward
    output(s, 'DF', 0)
    
    % Read inputs
    data = inputSingleScan(s);
    % Turn around code ====================================================
    if data(1) == 1 % check status of front bumper
        % turn around script 
        
        % back up a little
        output(s, 'DB', 0.3)
    
        
        if NORTH == 1
            % Turn R
            output(s, 'WR', 0.9)
            output(s, 'TR', 0.45)
            NORTH = 0;
        else
            % Turn L
            output(s, 'WL', 0.7)
            output(s, 'TL', 0.4)
            NORTH = 1;
        end
    end
    
    % puckcode ============================================================
    
    % Check if the colour sensor is detecting a blue puck
    if data(4) > bLow && data(4) < bHigh 
        fprintf('Blue detected! \n')
        % BLUE
        % Evade puck (drive around its right side)
        
        % Back up a little
        output(s, 'DB', 0.3)

        if NORTH == 1
            % Turn R
            output(s, 'TR', 0.2)
        else
            % Turn L
            output(s, 'TL', 0.2)
        end

        % power motor for a bit
        output(s, 'DF', 0.5)

        % Snake around
        if NORTH == 1
            output(s, 'WL', 1)
            output(s, 'DF', 0.5)
            output(s, 'TR', 0.2)
        else
            output(s, 'WR', 0.1)
            output(s, 'DF', 0.5)
            output(s, 'TL', 0.2)
        end
        
    % Check if the colour sensor is detecting a red puck
    elseif data(4) > rLow && data(4) < rHigh
        fprintf('Red detected! \n')
        % RED
        
        fprintf('\n servo! \n')
        % Turn on led, lower grabber
        LEDSTATE = 1;
        SERVOPOS = 8;
        output(s, 'LS', 0.5)
        fprintf('Servo closed! \n')
        
        output(s, 'DB', 0.2)
        
        % Turn to face safe zone
        fprintf('Turning! \n')
        if NORTH == 1
            fprintf('Turning right! \n')
            output(s, 'WR', 0.45)
            output(s, 'TR', 0.2)
        else
            fprintf('Turning left! \n')
            output(s, 'WL', 0.45)
            output(s, 'TL', 0.2)
        end
    
        fprintf('driving! \n')
        % Drive towards safe zone
        output(s, 'DF', 0)

        % Safe zone code ======================================================
        fprintf('ns code! \n')
        notSafe = true;
        while notSafe == true % Drive until we see safe zone
            data = inputSingleScan(s);
            if data(5) > lLow && data(5) < lHigh
                notSafe = false;
            end
        end
        pause(0.3) % Keep driving so robot is well within safe zone

        % Now in safe zone ====================================================
        fprintf('Lifting grabber! \n')
        % Turn LED off and raise grabber
        LEDSTATE = 0;
        SERVOPOS = 10;
        output(s, 'LS', 0.5)
        fprintf('grabber lift completed! \n')
        % Get clear of puck
        output(s, 'DB', 1)


        % Return to starting corner ============================================

        % Turn to 'south' wall of arena
        output(s, 'TR', 0.5)
        % drive to 'south' wall
        output(s, 'DF', 0)
        % Keep driving until bumper hit
        % Acts as interrupt
        while data(1) == 0
            data = inputSingleScan(s);
        end

        % Face starting corner
        output(s, 'TR', 0.3)
        % Keep driving until bumper hit
        % Acts as interrupt
        while data(1) == 0
            data = inputSingleScan(s);
            output(s, 'DF', 0)
        end

        %Face 'North'
        output(s, 'TR', 0.3)
        NORTH = 1;
    end
end
output(s, 'DS', 0)