%Goal: Make a cue for 500 ms, give a stimulus for 5000 ms, then make it
%blank for 500 ms.
%Alt. Goal: Make a lot of boxes blink at different frequencies

% If it wont run, "in-comment" this :3
Screen('Preference', 'SkipSyncTests', 0);

% Windows
[w, wRect]=Screen('OpenWindow', 0, []);

% Setting max priority to the window - pausing other background processes in the OS
Priority(MaxPriority(w));

% Blinking time
BlinkTime = 10; 

% Pause time
pauseTime = 10;

% Magic function that will clear the framebuffer to background color after each flip
Screen('Flip',w);

% Find refresh rate in seconds
Frametime=Screen('GetFlipInterval',w); 

% Number of frames for all stimuli
FramesPerFull = round(BlinkTime/Frametime);

% Frames to seconds
%pauseTime = ((FramesPerFull/MaxTime)*pauseFrames)/((FramesPerFull/MaxTime)*pauseFrames)*pauseFrames;

% Hz stimilus
hz = 7; %7, 9, 12, 20  --  Outputs: 6.7, 8.6, 12, 20

% Number of frames for each stimulus
FramesPerStimHz = round((1/hz)/Frametime);

% Measure start time of session
StartT = GetSecs; 

% Frame counter begins at 0
Framecounter = 0; 

% Return an array of screenNumbers, corresponding to available logical or physical displays
screens = Screen('Screens');

% Select the external screen if it is present, else revert to the native screen
screenNumber = max(screens);

% Get the size of the on screen window in pixels
[screenXpixels, screenYpixels] = Screen('WindowSize', w);

% Size of rectangles
square = 300;
baseRect = [0, 0, square, square];
centerSquare = square/2;

optimalXsquares = floor(screenXpixels/square);
optimalYsquares = floor(screenYpixels/square);

optimalSizeX = screenXpixels/optimalXsquares;
optimalSizeY = screenYpixels/optimalYsquares;

optimalXspacing = (optimalSizeX-square)/optimalXsquares;
optimalYspacing = (optimalSizeY-square)/optimalYsquares;

% Positions of squares
[xCenter, yCenter] = RectCenter(wRect);
posCenter = CenterRectOnPointd(baseRect, xCenter, yCenter);

% Font and text size
font = 'Courier';
fontSize = 50;
Screen('TextSize', w, fontSize);
Screen('TextFont', w, font);
numLetters = 10;

% Position of text
textCenter = [xCenter-(fontSize/2*numLetters/2), yCenter];

% Colors    %%%%%%%%%%%%Figure out how to change color to red
white = WhiteIndex(screenNumber);
black = BlackIndex(screenNumber);
red = [255 0 0];

% Initializing the colors
colorHz =  black;

% Changing background color
Screen('FillRect', w, black);

% Small square in middle
redRect = [0, 0, 10, 10];
posSmallCenter = CenterRectOnPointd(redRect, xCenter, yCenter);

count = 0;
lock = 0;
while 1
        
    if Framecounter==FramesPerFull
        break; %End session
    end
    
    if Framecounter == 1
        pause(pauseTime)
    end
    
    %%% 
    if ~mod(Framecounter,FramesPerStimHz)
            if (colorHz == black)
                colorHz = white;
                count = count + 1;
            end
        
            else
                colorHz = black;                
    end
    %%%  
    
    Screen('FillRect', w, colorHz, posCenter);  
    Screen('FillRect', w, red, posSmallCenter);
    %DrawFormattedText(w, 'LOOK HERE ', textCenter(1), textCenter(2), [0 0 1]);
    Screen('Flip',w);

    
    if Framecounter == FramesPerFull-1%(FramesPerFull/MaxTime)*pauseFrames
        Screen('FillRect', w, white, posCenter);
        pause(pauseTime);
    end
    
    Framecounter = Framecounter + 1; %Increase frame counter
end



% Measure end time of session
EndT = GetSecs;

% Shows full length of time all stimuli were presented, for debugging reasons
EndT - StartT 
count
% Cleanup
Screen('CloseAll');
Priority(0);