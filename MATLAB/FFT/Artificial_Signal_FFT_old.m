clear;clc; close all

%% THIS FILE IS OLD. GO GET THE NEW VERSION

fs = 250;            % Hz sampling frequency, nyquist frequency is fs/2
ts = 1/fs;           % Sampling period
t_rec = 10;          % Recording time in seconds NOTE give a number that can be divide by 2, see indexes below
time = ts:ts:t_rec;  % Time domain (x axis)

delta_f = 1/t_rec;                       % Increment on the frequency axis.
f_axis = (-fs/2+delta_f):delta_f:(fs/2); % Frequency axis. It goes from -nyquist to +nyquist

% Frequencies
f1 = 6.6;
f2 = 8.6;
f3 = 12;
f4 = 20;

% DC noise %%%% Figure out if this is constant or random
DC = 2; %round(rand(1)*4);

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

%
xSignal = 0;
for i = 1:n
    ranVec = transpose(rand(1,nNoiseSignal)*70); % Output between 0 and 70 because it is the frequencies
    ranAmp = 10;
    ranShift = transpose(rand(1,nNoiseSignal)*2*pi); % Output between 0 and 2pi (because it's radians)

    singleSignal = 2 + y1 + y2 + y3 + y4 + sum(ranAmp.*sin(2*pi*ranVec*time+ranShift));
    xSignal = xSignal + singleSignal;
end

%transpose(rand(1,nNoiseSignal)*10); % Output between 0 and 10, because it's the amplitude

averageSignal = xSignal/n;

% Removing the DC noise by subtracting by the average
meanSignal = averageSignal - mean(averageSignal);

% Calculating fourier transform of mean data
signalData = fft(meanSignal);

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
threshold = 2000;

% Boundaries around frequencies of interest
intervalFreq7  = signalFftRight(56:76);   % 6,6 Hz
intervalFreq15 = signalFftRight(76:96); % 8,6 Hz
intervalFreq22 = signalFftRight(110:130); % 12 Hz
intervalFreq11 = signalFftRight(190:210); % 20 Hz, failsafe: shouldn't give a large signal.

% The integral under the graph of the above interval, and removing the
% complex numbers.
freqValue7  = abs(trapz(intervalFreq7));
freqValue15 = abs(trapz(intervalFreq15));
freqValue22 = abs(trapz(intervalFreq22));
freqValue11 = abs(trapz(intervalFreq11));

% Initialising the checks
checkSpike = [0 0 0 0];

% If statements to output commands when detecting a spike in the designated
% frequency intervals
if freqValue7 > threshold
    checkSpike(1) = 1;
else
    checkSpike(1) = 0;
end
if freqValue15 > threshold
    checkSpike(2) = 1;
else
    checkSpike(2) = 0;
end
if freqValue22 > threshold
    checkSpike(3) = 1;
else
    checkSpike(3) = 0;
end
if freqValue11 > threshold
    checkSpike(4) = 1;
else
    checkSpike(4) = 0;
end

checkSpike

