%Goal: Make a cue for 500 ms, give a stimulus for 5000 ms, then make it
%blank for 500 ms.
%Alt. Goal: Make a lot of boxes blink at different frequencies

% If it wont run, "in-comment" this :3
Screen('Preference', 'SkipSyncTests', 0);

% Windows
[w, wRect]=Screen('OpenWindow', 0, []);

% Setting max priority to the window - pausing other background processes in the OS
%Priority(MaxPriority(w));

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

% Number of frames for each stimulus
FramesPerStimHz7 = round((1/7)/Frametime); %7 hz ===> 6,7 output
FramesPerStimHz9 = round((1/9)/Frametime); %9 hz ===> 8,6 output
FramesPerStimHz12 = round((1/12)/Frametime); % 12 hz ===> 12 output
FramesPerStimHz20 = round((1/20)/Frametime); % 20 hz ===> 20 output
FramesPerStimHz37 = round((1/37)/Frametime);

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
halfCenterRect = [0, 0, square/2, square];
centerSquare = square/2;

optimalXsquares = floor(screenXpixels/square);
optimalYsquares = floor(screenYpixels/square);

optimalSizeX = screenXpixels/optimalXsquares;
optimalSizeY = screenYpixels/optimalYsquares;

optimalXspacing = (optimalSizeX-square)/optimalXsquares;
optimalYspacing = (optimalSizeY-square)/optimalYsquares;

% Positions of squares
[xCenter, yCenter] = RectCenter(wRect);
posRightBottom = CenterRectOnPointd(baseRect, screenXpixels-centerSquare, screenYpixels-centerSquare);
posLeftBottom = CenterRectOnPointd(baseRect, centerSquare, screenYpixels-centerSquare);
posRightTop = CenterRectOnPointd(baseRect, screenXpixels-centerSquare, centerSquare);
posLeftTop = CenterRectOnPointd(baseRect, centerSquare, centerSquare);
posCenter = CenterRectOnPointd(baseRect, xCenter, yCenter);
posCenterHalfLeft = CenterRectOnPointd(halfCenterRect, xCenter+centerSquare/2, yCenter);
posCenterHalfRight = CenterRectOnPointd(halfCenterRect, xCenter-centerSquare/2, yCenter);

% Font and text size
font = 'Courier';
fontSize = 50;
Screen('TextSize', w, fontSize);
Screen('TextFont', w, font);
numLetters = 10;

% Colors
white = WhiteIndex(screenNumber);
black = BlackIndex(screenNumber);
red = [255 0 0];

% Changing background color
Screen('FillRect', w, black);

% Small square in middle
redSquare = 10;
redRect = [0, 0, redSquare, redSquare];
centerRedSquare = redSquare/2;

posRedRightTop = CenterRectOnPointd(redRect, screenXpixels-centerSquare, centerSquare);
posRedLeftTop = CenterRectOnPointd(redRect, centerSquare, centerSquare);
posRedRightBottom = CenterRectOnPointd(redRect, screenXpixels-centerSquare, screenYpixels-centerSquare);
posRedLeftBottom = CenterRectOnPointd(redRect, centerSquare, screenYpixels-centerSquare);
posRedCenter = CenterRectOnPointd(redRect, xCenter, yCenter);

% Initializing the colors
colorHz7 = white;
colorHz9 = white;
colorHz12 = white;
colorHz20 = white;
colorHz37 = white;

%Initialising counters
count7  = 1;
count9  = 1;
count12 = 1;
count20 = 1;
count37 = 1;

while 1
        
    if Framecounter==FramesPerFull
        break; %End session
    end
    
    if Framecounter == 1
        pause(pauseTime)
    end
    
    %%% 
    if ~mod(Framecounter,FramesPerStimHz7)
        if (colorHz7 == black)
            colorHz7 = white;
            count7 = count7 + 1;
        end
        
        else
            colorHz7 = black;
    end
    %%%
    
    %%%
    if ~mod(Framecounter,FramesPerStimHz9)
        if (colorHz9 == black)
            colorHz9 = white;
            count9 = count9 + 1;
        end
        
        else
            colorHz9 = black;
    end
    %%%  
    
    %%%
    if ~mod(Framecounter,FramesPerStimHz12)
        if (colorHz12 == black)
            colorHz12 = white;
            count12 = count12 + 1;
        end
        
        else
            colorHz12 = black;
    end
    %%%
    
    %%%
    if ~mod(Framecounter,FramesPerStimHz20)
        if (colorHz20 == black)
            colorHz20 = white;
            count20 = count20 + 1;
        end
        
        else
            colorHz20 = black;
    end
    %%%  
    
    %%%
    if ~mod(Framecounter,FramesPerStimHz37)
        if (colorHz37 == black)
            colorHz37 = white;
            count37 = count37 + 1;
        end
        
        else
            colorHz37 = black;
    end
    %%%      
    
    
    Screen('FillRect', w, colorHz7, posRightBottom); 
    Screen('FillRect', w, red, posRedRightBottom);
    
    Screen('FillRect', w, colorHz9, posLeftBottom);
    Screen('FillRect', w, red, posRedLeftBottom);
    
    Screen('FillRect', w, colorHz12, posRightTop);
    Screen('FillRect', w, red, posRedRightTop);
    
    Screen('FillRect', w, colorHz20, posLeftTop);
    Screen('FillRect', w, red, posRedLeftTop);
    
    %Screen('FillRect', w, colorHz37, posCenter);
    Screen('FillRect', w, colorHz7, posCenterHalfLeft);
    Screen('FillRect', w, colorHz20, posCenterHalfRight);
    Screen('FillRect', w, red, posRedCenter);
    Screen('Flip',w);

    
    if Framecounter == FramesPerFull-1%(FramesPerFull/MaxTime)*pauseFrames
        pause(pauseTime);
    end
    
    Framecounter = Framecounter + 1; %Increase frame counter
end



% Measure end time of session
EndT = GetSecs;

% Shows full length of time all stimuli were presented, for debugging reasons
EndT - StartT 

% Printing counters
count7
count9
count12
count20
count37

% Cleanup
Screen('CloseAll');
Priority(0);