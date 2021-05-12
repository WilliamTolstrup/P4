clear; clc; close all

load('trial2.mat')

fs = 250;            % Hz sampling frequency, nyquist frequency is fs/2
ts = 1/fs;           % Sampling period
t_rec = 10;          % Recording time in seconds NOTE give a number that can be divide by 2, see indexes below
time = ts:ts:t_rec;  % Time domain (x axis)

realSignal = eeg(20,:);     % The real signal is instanced here

delta_f = 1/t_rec;                       % Increment on the frequency axis.
f_axis = (-fs/2+delta_f):delta_f:(fs/2); % Frequency axis. It goes from -nyquist to +nyquist

% Frequencies
f1 = 6.6;
f2 = 8.6;
f3 = 12;
f4 = 20;

% DC noise %%%% Figure out if this is constant or random
DC = 20*sin(2*pi*0.035*time);%2; %round(rand(1)*4);

n = 500;            % Iterations of for loop
nNoiseSignal = 312; % Number of noise signals

% Generating sine waves with specific frequencies
amp = 2;
y1 = amp*sin(2*pi*f1*time);
y2 = amp*sin(2*pi*f2*time);
y3 = amp*sin(2*pi*f3*time);
y4 = amp*sin(2*pi*f4*time);

% Creating combined signal
xClean = y1+y2+y3+y4; % Without noise

% xSignal is defined here.
xSignal = 0;

%% Artifical artifact creation of human blinks
% The position of real blinks / artifacts in a real EEG is defined
blink1 = realSignal(1168295:1169410);
blink2 = realSignal(1190120:1191415);

% Empty blinks are declared for late specifiation
blink1_250 = 0;
blink2_250 = 0;

% The following for-loops converts artifacts from the realSignal
% The conversion is from 5000 Hz to 250 Hz:
j = 1;
for i = 1:1116
    if mod(i,20) == 1
      blink1_250(j) = blink1(i);
      j = j+1;
    end
end

j = 1;
for i = 1:1296
    if mod(i,20) == 1
      blink2_250(j) = blink2(i);
      j = j+1;
    end
end


for i = 1:n
    ranVec = transpose(rand(1,nNoiseSignal)*70); % Output between 0 and 70 because it is the frequencies
    ranAmp = 10;
    ranShift = transpose(rand(1,nNoiseSignal)*2*pi); % Output between 0 and 2pi (because it's radians)    

    % Empty vectors are defined with ranges of the full signal.
    zeroset1 = zeros(size(time));
    zeroset2 = zeros(size(time));

    % This for-loop is adding artifacts to the artificial signal.
    for i = 0:34
        % This rand function uses a 2% chance of adding an artifact
        % The if-statements inserts the artifacts if True.
        j = randi([1 50],1);
        if  j == 1
            zeroset1(1+i*70:56+i*70)=zeroset1(1+i*70:56+i*70)+blink1_250;
        end
        if  j == 2
            zeroset2(1+i*70:65+i*70)=zeroset2(1+i*70:65+i*70)+blink2_250;
        end
    end

    % This is the final part, where the signals are summed together.
    singleSignal = DC + y1 + y2 + y3 + y4 + zeroset1 + zeroset2 + sum(ranAmp.*sin(2*pi*ranVec*time+ranShift));
    xSignal = xSignal + singleSignal;
end

%transpose(rand(1,nNoiseSignal)*10); % Output between 0 and 10, because it's the amplitude

averageSignal = xSignal/n;

% Removing the DC noise by subtracting by the average
meanSignal = averageSignal - mean(averageSignal);

% hello
filtersignal = highpass(meanSignal, 0.4, 500);

% Calculating fourier transform of mean data
signalData = fft(filtersignal);

% The side spikes are moved around so that they convulge in the center,
% making them easier to remove
signalDataShift = fftshift(signalData);

% Limiting the signal, to only show right side of fft (Hard coded, very
% reliant on t_rec)
limitX1 = 1251;
limitX2 = 1250+1250/140*35; % 35 is the top limit shown on the fft graph
signalFftRight = signalDataShift(limitX1:limitX2);

% Plotting graphs
numGraphsY = 3;
numGraphsX = 1;

% Signal
subplot(numGraphsY,numGraphsX,1);
plot(time, xClean);
title('Clean signal')
xlabel('Time [s]');
ylabel('Signal');

% Noise signal
subplot(numGraphsY,numGraphsX,2);
plot(time, xSignal);
title('Noise signal')
xlabel('Time [s]');
ylabel('Signal');

% fft transform on noise signal
subplot(numGraphsY,numGraphsX,3);
plot(f_axis(limitX1:limitX2),abs(signalFftRight)); % remeber that data is complex...one can exptract the phase spectrum out of this data
title('fft transform on noise signal with frequencies')
xlabel('Frequency [Hz]')
ylabel('Identify this value');

% Thresholding
threshold = 1900;

% Boundaries around frequencies of interest
intervalFreq7  = signalFftRight(56:76);   % 6,6 Hz
intervalFreq15 = signalFftRight(76:96); % 8,6 Hz
intervalFreq22 = signalFftRight(110:130); % 12 Hz
intervalFreq11 = signalFftRight(190:210); % 20 Hz, failsafe: shouldn't give a large signal.x

% Initialising the checks
checkSpike = [0 0 0 0];

% If statements to output commands when detecting a spike in the designated
% frequency intervals
for i = 1:7
    if abs(signalFftRight(62+i)) > threshold
        checkSpike(1) = 1;  
    end
end
for i = 1:7
    if abs(signalFftRight(82+i)) > threshold
        checkSpike(2) = 1;  
    end
end
for i = 1:7
    if abs(signalFftRight(116+i)) > threshold
        checkSpike(3) = 1;  
    end
end
for i = 1:7
    if abs(signalFftRight(196+i)) > threshold
        checkSpike(4) = 1;  
    end
end

checkSpike
