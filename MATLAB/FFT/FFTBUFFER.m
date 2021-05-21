clc; clear; close all

load('trial2.mat');

ts = 1/fs;
t_rec = 13.1072;
time = ts:ts:t_rec;

measured_signal = eeg(20,:);

highpass_signal = highpass(measured_signal, 0.3, 500);

delta_f = 1/t_rec;
f_axis = -fs/2+delta_f:delta_f:fs/2;

Hz66 = [1:221];
Hz86 = [1:221];
Hz12 = [1:221];
Hz20 = [1:221];

for i = 0:220
    fftse = fft(highpass_signal(1+5000*i:65536+5000*i));
    fftset = fftshift(fftse);
    set66 = 0;
    set86 = 0;
    set12 = 0;
    set20 = 0;
    for j = 1:7
        set66 = set66+abs(fftset(32851+1));
        Hz66(i+1)=set66/11;
    end
    for j = 1:7
        set86 = set86+abs(fftset(32877+1));
        Hz86(i+1)=set86/11;
    end
    for j = 1:7
        set12 = set12+abs(fftset(32922+1));
        Hz12(i+1)=set12/11;
    end
    for j = 1:7
        set20 = set20+abs(fftset(33027+1));
        Hz20(i+1)=set20/11;
    end
end

y = [1:221];

figure; hold on
a1 = plot(y,Hz66,'g'); m1 = 'Hz6.6';
a2 = plot(y,Hz86,'r'); m2 = 'Hz8.6';
a3 = plot(y,Hz12,'b'); m3 = 'Hz12';
a4 = plot(y,Hz20,'y'); m4 = 'Hz20';
legend([a1,a2,a3,a4], [m1,m2,m3,m4]);
hold off

%%
clc; clear; close all

load('trial2.mat');

ts = 1/fs;
t_rec = 13.1072;
time = ts:ts:t_rec;

measured_signal = eeg(20,:);

highpass_signal = highpass(measured_signal, 0.3, 500);

delta_f = 1/t_rec;
f_axis = -fs/2+delta_f:delta_f:fs/2;



fgh = figure(); % create a figure
axh = axes('Parent',fgh); % create axes
X = f_axis(32441:33096);
Y = [1:656];
lnh = plot(axh,X,Y); % plot in those axes

for i = 0:220
    pause(0.5)
    fftse = fft(highpass_signal(1+5000*i:65536+5000*i));
    fftset = fftshift(fftse);
    set(lnh,'YData',abs(fftset(32441:33096)));
end