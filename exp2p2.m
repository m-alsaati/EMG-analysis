datadir = ('D:\Documents\Third Year\BME 632\BME 632 Matlab stuff\Lab 2 Data\GraspForce.csv');
data = readtable(datadir);
Fingflex = data.Finger_Flexor;
Force = data.Force;
freq = 1000;
period = 1/freq;
time = 0:length(Force) - 1000;

%2.1-----------------------------------------

%Clipping Noise
Fingflex = Fingflex(1000:end);
Force = Force(1000:end);

%Normalizing Force
Normal = Force - min(Force);
Normal = Normal ./ (max(Force)-min(Force));

%Plotting Normalized Graphs

%Force
figure(6)
subplot(2,1,1);
plot(time, Force, 'k');
title('Original Force');
xlabel('time (s)'); ylabel('N');
grid on

%Force Normalized
subplot(2,1,2);
plot(time, Normal, 'r');
title('Normalized Force');
xlabel('time (s)'); ylabel('N');
grid on

thresh = Normal > 0.05; %defines when the regions of interest exists
threshforce = thresh.*Normal;

%Segmenting
seg = find(diff(thresh(:,1))); %used to find all the segments that will be used for calculations

segforce1 = Normal(1:seg(1));
segforce2 = Normal(seg(2):seg(3));
segforce3 = Normal(seg(4):seg(5));
segforce4 = Normal(seg(6):seg(7));
segforce5 = Normal(seg(8):seg(9));
segforce6 = Normal(seg(10):seg(11));

W1 = (0.02:0.099:2)*freq; %sets window size
mse_1 = zeros(1,20);
r_sqr_1 = zeros(1,20);
mse_2 = zeros(1,20);
r_sqr_2 = zeros(1,20);
mse_3 = zeros(1,20);
r_sqr_3 = zeros(1,20);

%Short Term Analysis 
for i = 1: 20
    Window = round(W1(i));
    %takes all the data in [] and sends it to function
    [msforce1, vforce1, drforce1, avgforce1, rootforce1] = Functions(segforce1, Window);
    [msforce2, vforce2, drforce2, avgforce2, rootforce2] = Functions(segforce2, Window);
    [msforce3, vforce3, drforce3, avgforce3, rootforce3] = Functions(segforce3, Window);
    [msforce4, vforce4, drforce4, avgforce4, rootforce4] = Functions(segforce4, Window);
    [msforce5, vforce5, drforce5, avgforce5, rootforce5] = Functions(segforce5, Window);
    [msforce6, vforce6, drforce6, avgforce6, rootforce6] = Functions(segforce6, Window);
    
    %Force Average 
    msforce1 = mean(msforce1); vforce1 = mean(vforce1); 
    drforce1 = mean(drforce1); avgforce1 = mean(avgforce1); rootforce1 = mean(rootforce1);
    msforce2 = mean(msforce2); vforce2 = mean(vforce2); 
    drforce2 = mean(drforce2); avgforce2 = mean(avgforce2); rootforce2 = mean(rootforce2);
    msforce3 = mean(msforce3); vforce3 = mean(vforce3); 
    drforce3 = mean(drforce3); avgforce3 = mean(avgforce3); rootforce3 = mean(rootforce3);
    msforce4 = mean(msforce4); vforce4 = mean(vforce4); 
    drforce4 = mean(drforce4); avgforce4 = mean(avgforce4); rootforce4 = mean(rootforce4);
    msforce5 = mean(msforce5); vforce5 = mean(vforce5); 
    drforce5 = mean(drforce5); avgforce5 = mean(avgforce5); rootforce5 = mean(rootforce5);
    msforce6 = mean(msforce6); vforce6 = mean(vforce6); 
    drforce6 = mean(drforce6); avgforce6 = mean(avgforce6); rootforce6 = mean(rootforce6);
    
    Forceseg1 = mean(segforce1); 
    Forceseg2 = mean(segforce2); 
    Forceseg3 = mean(segforce3); 
    Forceseg4 = mean(segforce4); 
    Forceseg5 = mean(segforce5); 
    Forceseg6 = mean(segforce6);
    
    %Memory allocation for all force data
    ForceAVG = [Forceseg1, Forceseg2, Forceseg3, Forceseg4, Forceseg5, Forceseg6];
    ForceAVP = [avgforce1, avgforce2, avgforce3, avgforce4, avgforce5, avgforce6];
    ForceMRS = [msforce1, msforce2, msforce3, msforce4, msforce5, msforce6];
    ForceRMS = [rootforce1, rootforce2, rootforce3, rootforce4, rootforce5, rootforce6];
    
    %Linear Regression
    %All the values are sent into the linear reg function to be plotted
    [m, b, y_est, residual, mse1, r_sqr1] = FunctionsLinReg(ForceAVG, ForceAVP);
    [m, b, y_est, residual, mse3, r_sqr3] = FunctionsLinReg(ForceAVG, ForceMRS);
    [m, b, y_est, residual, mse5, r_sqr5] = FunctionsLinReg(ForceAVG, ForceRMS);

    mse_1(i) = mse1;
    mse_2(i) = mse3;
    mse_3(i) = mse5;
    r_sqr_1(i) = r_sqr1(1,2);
    r_sqr_2(i) = r_sqr3(1,2);
    r_sqr_3(i) = r_sqr5(1,2);
end

labels = {'1','2','3','4','5','6','7','8','9','10','11','12','13','14','15','16','17','18','19','20'};
figure;
scatter(r_sqr_1, mse_1);
text(r_sqr_1, mse_1, labels);
xlabel('Correlation Coefficient, r');
ylabel('MSE');
title('MSE vs. Correlation Coefficient for Mean');
grid on

figure;
scatter(r_sqr_2, mse_2);
text(r_sqr_2, mse_2, labels);
xlabel('Correlation Coefficient, r');
ylabel('MSE');
title('MSE vs. Correlation Coefficient for MS');
grid on

figure;
scatter(r_sqr_3, mse_3);
text(r_sqr_3, mse_3, labels);
xlabel('Correlation Coefficient, r');
ylabel('MSE');
title('MSE vs. Correlation Coefficient for RMS');
grid on

function [MRS, VRS, DYR, AVP, RMS] = extractFeatures1(signal, windowSize)
    for i = 1 : length(signal)-windowSize
        MRS(i) = mean(signal(i : i + windowSize - 1));
        VRS(i) = var(signal(i : i + windowSize - 1));
        DYR(i) = max(signal(i : i + windowSize - 1)) - min(signal(i : i+ windowSize - 1));
        AVP(i) = mean((signal(i : i + windowSize - 1)).^2);
        RMS(i) = rms(signal(i : i + windowSize - 1));
    end
end
