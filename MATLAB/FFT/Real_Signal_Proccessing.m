clc; clear; close all;

load('test1.mat');
% load('trial2.mat')

ts = 1/fs;
t_rec = 13.1072;
% time = ts:ts:234.66;
time = ts:ts:t_rec;

O1 = 9;
O2 = 10;
Pz = 19;
Oz = 20;
POz = 31;

measured_channel = eeg(Oz,:);

highpass_signal = highpass(measured_channel, 0.3, 500);

first_sampling_6Hz = measured_channel(55001:95000);   
Hz6_clean = highpass_signal(42233: 107768);
delta_f = 1/t_rec;
f_axis = -fs/2 + delta_f:delta_f:fs/2;

fft6Hz = fft(Hz6_clean);
shift6Hz = fftshift(fft6Hz);

figure(1)
plot(f_axis(32504:33028), abs(shift6Hz(32504:33028)));

%% Section 2. Eletric boogaloo.

load('trial2.mat');

measured_channel2 = eeg(Oz,:);
highpass_signal2 = highpass(measured_channel2, 0.3, 500);

first_sampling_6Hz = measured_channel2(55001:95000);   
Hz6_clean2 = highpass_signal2(42233: 107768);

fft6Hz2 = fft(Hz6_clean2);
shift6Hz2 = fftshift(fft6Hz2);

figure(3)
plot(f_axis(32504:33028), abs(shift6Hz2(32504:33028)));


%% Section 3. Combination boogaloo.

averaged_Hz6 = (shift6Hz + shift6Hz2)/2

figure(4)
plot(f_axis(32504:33028), abs(averaged_Hz6(32504:33028)));

threshhold6Hz = averaged_Hz6(32851:32856);

answer = [0,0]
for i = 1:6
    if averaged_Hz6(32850+i) >= 50000
       answer(1) = 1   
    else
       answer(1) = 0   
    end
end