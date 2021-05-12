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

% Number of frames for each stimulus
FramesPerStimHz7 = round((1/7)/Frametime);
FramesPerStimHz9 = round((1/9)/Frametime);
FramesPerStimHz12 = round((1/12)/Frametime);
FramesPerStimHz20 = round((1/20)/Frametime);

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
posRightBottom = CenterRectOnPointd(baseRect, screenXpixels-centerSquare, screenYpixels-centerSquare);
posLeftBottom = CenterRectOnPointd(baseRect, centerSquare, screenYpixels-centerSquare);
posRightTop = CenterRectOnPointd(baseRect, screenXpixels-centerSquare, centerSquare);
posLeftTop = CenterRectOnPointd(baseRect, centerSquare, centerSquare);

%posCenter = CenterRectOnPointd(baseRect, xCenter, yCenter);

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

%posRedRightMiddle = CenterRectOnPointd(redRect, screenXpixels-centerSquare, yCenter);
%posRedLeftMiddle  = CenterRectOnPointd(redRect, centerSquare, yCenter);
posRedRightTop = CenterRectOnPointd(redRect, screenXpixels-centerSquare, centerSquare);
posRedLeftTop = CenterRectOnPointd(redRect, centerSquare, centerSquare);
posRedRightBottom = CenterRectOnPointd(redRect, screenXpixels-centerSquare, screenYpixels-centerSquare);
posRedLeftBottom = CenterRectOnPointd(redRect, centerSquare, screenYpixels-centerSquare);

%posRedCenter = CenterRectOnPointd(redRect, xCenter, yCenter);

% Initializing the colors
colorHz12 = white;
colorHz7 = white;
colorHz20 = white;
colorHz9 = white;

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
        end
        
        else
            colorHz7 = black;
    end
    %%%
    
    %%%
    if ~mod(Framecounter,FramesPerStimHz12)
        if (colorHz12 == black)
            colorHz12 = white;
        end
        
        else
            colorHz12 = black;
    end
    %%%  
    
    %%%
    if ~mod(Framecounter,FramesPerStimHz20)
        if (colorHz20 == black)
            colorHz20 = white;
        end
        
        else
            colorHz20 = black;
    end
    %%%
    
    %%%
    if ~mod(Framecounter,FramesPerStimHz9)
        if (colorHz9 == black)
            colorHz9 = white;
        end
        
        else
            colorHz9 = black;
    end
    %%%  
    
    
    Screen('FillRect', w, colorHz7, posRightBottom); 
    Screen('FillRect', w, red, posRedRightBottom);
    
    Screen('FillRect', w, colorHz12, posLeftBottom);
    Screen('FillRect', w, red, posRedLeftBottom);
    
    Screen('FillRect', w, colorHz20, posRightTop);
    Screen('FillRect', w, red, posRedRightTop);
    
    Screen('FillRect', w, colorHz9, posLeftTop);
    Screen('FillRect', w, red, posRedLeftTop);
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

% Cleanup
Screen('CloseAll');
Priority(0);