datadir = ('D:\Documents\Third Year\BME 632\BME 632 Matlab stuff\Lab 2 Data\IsometricMovement.csv');
data = readtable(datadir);
Bicep = data.Bicep;
freq = 1000;
period = 1/freq;
t = 0:length(Bicep) - 1000;

bicep = Bicep(1000:end);

plot(t, bicep, 'k');
title('Bicep Movement VS Time');
xlabel('Time (s)');
ylabel('EMG (mV)');

window1 = 0.05;
window2 = 0.25;
window3 = 1.00;
sizeW1 = freq*window1;
sizeW2 = freq*window2;
sizeW3 = freq*window3;

mean = zeros(size(bicep));
variance = zeros(size(bicep));
dynamic_range = zeros(size(bicep));
avg_power = zeros(size(bicep));
RMS = zeros(size(bicep));

signal_w1 = bicep;
signal_w2 = bicep;
signal_w3 = bicep;
signal_w1(length(signal_w1) + sizeW1) = 0;
signal_w2(length(signal_w2) + sizeW2) = 0;
signal_w3(length(signal_w3) + sizeW3) = 0;

[MRS,VRS,DYR,AVP,RMS]=extractFeatures1(signal_w1, sizeW1);
figure('Name','First Window VS Time (0.05s window)')
plot(t,bicep,t,MRS,'g',t,VRS,'r',t, DYR,'c',t,AVP,'m',t,RMS,'k');
xlabel('time (s)');
ylabel('EMG (mV)');
title('First Window VS Time (0.05s window)');
legend('EMG signal','Mean Recitified Signal','Varience','Dynamic Range','AveragePower','Root Mean Square');
grid

[MRS,VRS,DYR,AVP,RMS] = extractFeatures1(signal_w2, sizeW2);
figure('Name','Second Window VS Time (0.25s window)')
plot(t,bicep,t,MRS,'g',t,VRS,'r',t, DYR,'c',t,AVP,'m',t,RMS,'k');
xlabel('time (s)');
ylabel('EMG (mV)');
title('Second Window VS Time (0.25s window)');
legend('EMG signal','Mean Recitified Signal','Varience','Dynamic Range','AveragePower','Root Mean Square');
grid

[MRS,VRS,DYR,AVP,RMS] = extractFeatures1(signal_w3, sizeW3);
figure('Name','Third Window VS Time (1s window)')
plot(t,bicep,t,MRS,'g',t,VRS,'r',t, DYR,'c',t,AVP,'m',t,RMS,'k');
xlabel('time (s)');
ylabel('EMG (mV)');
title('Third Window VS Time (1s window)');
legend('EMG signal','Mean Recitified Signal','Varience','Dynamic Range','AveragePower','Root Mean Square');
grid

%Function for extraction
function [MRS, VRS, DYR, AVP, RMS] = extractFeatures1(signal, windowSize)
    for i = 1 : length(signal)-windowSize
        MRS(i) = mean(signal(i : i + windowSize - 1));
        VRS(i) = var(signal(i : i + windowSize - 1));
        DYR(i) = max(signal(i : i + windowSize - 1)) - min(signal(i : i+ windowSize - 1));
        AVP(i) = mean((signal(i : i + windowSize - 1)).^2);
        RMS(i) = rms(signal(i : i + windowSize - 1));
    end
end

