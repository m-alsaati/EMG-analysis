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

%Normalizing the finger flex
NormalFingflex = Fingflex - min(Fingflex);
NormalFingflex = NormalFingflex ./ (max(Fingflex)-min(Fingflex));

%Plotting Normalized Graphs

%Finger Flexor
figure(5)
subplot(2,1,1);
plot(time, Fingflex, 'k');
title('Original Finger Flexor');
xlabel('time (s)'); ylabel('mV');
grid on

%Finger Flexor normalized
subplot(2,1,2);
plot(time, NormalFingflex, 'r');
title('Normalized Finger Flexor');
xlabel('time (s)'); ylabel('mV');
grid on

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

%Regions used for calculation purposes
%{

%taken from either plot of fig 5
FF1 = NormFingF(0.014:1.839);
FF2 = NormFingF(1.962:4.835);
FF3 = NormFingF(4.99:7.099);
FF4 = NormFingF(7.626:9.257);
FF5 = NormFingF(9.756:12.244);
FF6 = NormFingF(13.027:15.282);
FF7 = NormFingF(15.402:16.216);
FF8 = NormFingF(16.439:17.374);

%taken from either plot of fig 6
F1 = NormF(0.004:1.599);
F2 = NormF(2.391:4.052);
F3 = NormF(4.929:6.756);
F4 = NormF(7.656:9.625);
F5 = NormF(10.26:11.987);
F6 = NormF(13.002:15.188);
%}

thresh = Normal > 0.05; %defines when the regions of interest exists
threshfing = thresh.*NormalFingflex; 
threshforce = thresh.*Normal;

%Segmenting
seg = find(diff(thresh(:,1))); %used to find all the segments that will be used for calculations

%{
%only 6 segments used because we consider normailzed data
seg1 = 0:seg(1); 
seg2 = seg(2):seg(3); 
seg3 = seg(4):seg(5);
seg4 = seg(6):seg(7);
seg5 = seg(8):seg(9);
seg6 = seg(10):seg(11);
%}

segfing1 = NormalFingflex(1:seg(1));
segfing2 = NormalFingflex(seg(2):seg(3));
segfing3 = NormalFingflex(seg(4):seg(5));
segfing4 = NormalFingflex(seg(6):seg(7));
segfing5 = NormalFingflex(seg(8):seg(9));
segfing6 = NormalFingflex(seg(10):seg(11));

segforce1 = Normal(1:seg(1));
segforce2 = Normal(seg(2):seg(3));
segforce3 = Normal(seg(4):seg(5));
segforce4 = Normal(seg(6):seg(7));
segforce5 = Normal(seg(8):seg(9));
segforce6 = Normal(seg(10):seg(11));

Window = freq*0.25; %sets window size

%Short Term Analysis 

%takes all the data in [] and sends it to function
[msfing1, vfing1, drfing1, avgfing1, rootfing1] = Functions(segfing1, Window);
[msfing2, vfing2, drfing2, avgfing2, rootfing2] = Functions(segfing2, Window);
[msfing3, vfing3, drfing3, avgfing3, rootfing3] = Functions(segfing3, Window);
[msfing4, vfing4, drfing4, avgfing4, rootfing4] = Functions(segfing4, Window);
[msfing5, vfing5, drfing5, avgfing5, rootfing5] = Functions(segfing5, Window);
[msfing6, vfing6, drfing6, avgfing6, rootfing6] = Functions(segfing6, Window);

[msforce1, vforce1, drforce1, avgforce1, rootforce1] = Functions(segforce1, Window);
[msforce2, vforce2, drforce2, avgforce2, rootforce2] = Functions(segforce2, Window);
[msforce3, vforce3, drforce3, avgforce3, rootforce3] = Functions(segforce3, Window);
[msforce4, vforce4, drforce4, avgforce4, rootforce4] = Functions(segforce4, Window);
[msforce5, vforce5, drforce5, avgforce5, rootforce5] = Functions(segforce5, Window);
[msforce6, vforce6, drforce6, avgforce6, rootforce6] = Functions(segforce6, Window);

%Finger variables calculations
msfing1 = mean(msfing1); vfing1 = mean(vfing1); 
drfing1 = mean(drfing1); avgfing1 = mean(avgfing1); rootfing1 = mean(rootfing1);
msfing2 = mean(msfing2); vfing2 = mean(vfing2); 
drfing2 = mean(drfing2); avgfing2 = mean(avgfing2); rootfing2 = mean(rootfing2);
msfing3 = mean(msfing3); vfing3 = mean(vfing3); 
drfing3 = mean(drfing3); avgfing3 = mean(avgfing3); rootfing3 = mean(rootfing3);
msfing4 = mean(msfing4); vfing4 = mean(vfing4); 
drfing4 = mean(drfing4); avgfing4 = mean(avgfing4); rootfing4 = mean(rootfing4);
msfing5 = mean(msfing5); vfing5 = mean(vfing5); 
drfing5 = mean(drfing5); avgfing5 = mean(avgfing5); rootfing5 = mean(rootfing5);
msfing6 = mean(msfing6); vfing6 = mean(vfing6); 
drfing6 = mean(drfing6); avgfing6 = mean(avgfing6); rootfing6 = mean(rootfing6);

Fingseg1 = mean(segfing1); 
Fingseg2 = mean(segfing2); 
Fingseg3 = mean(segfing3); 
Fingseg4 = mean(segfing4); 
Fingseg5 = mean(segfing5); 
Fingseg6 = mean(segfing6);

%Finger Table
Segment = ["Force", "Mean", "VAR", "MS", "DR", "RMS"]';
Fing1 = [Fingseg1, avgfing1, vfing1, msfing1, drfing1, rootfing1]';
Fing2 = [Fingseg2, avgfing2, vfing2, msfing2, drfing2, rootfing2]';
Fing3 = [Fingseg3, avgfing3, vfing3, msfing3, drfing3, rootfing3]';
Fing4 = [Fingseg4, avgfing4, vfing4, msfing4, drfing4, rootfing4]';
Fing5 = [Fingseg5, avgfing5, vfing5, msfing5, drfing5, rootfing5]';
Fing6 = [Fingseg6, avgfing6, vfing6, msfing6, drfing6, rootfing6]';
Table = table(Segment, Fing1, Fing2, Fing3, Fing4, Fing5, Fing6)

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

%Force Table
Segment = ["Force", "Mean", "VAR", "MS", "DR", "RMS"]';
Force1 = [Forceseg1, avgforce1, vforce1, msforce1, drforce1, rootforce1]';
Force2 = [Forceseg2, avgforce2, vforce2, msforce2, drforce2, rootforce2]';
Force3 = [Forceseg3, avgforce3, vforce3, msforce3, drforce3, rootforce3]';
Force4 = [Forceseg4, avgforce4, vforce4, msforce4, drforce4, rootforce4]';
Force5 = [Forceseg5, avgforce5, vforce5, msforce5, drforce5, rootforce5]';
Force6 = [Forceseg6, avgforce6, vforce6, msforce6, drforce6, rootforce6]';
Table = table(Segment, Force1, Force2, Force3, Force4, Force5, Force6)

%Memory allocation for all force data
ForceAVG = [Forceseg1, Forceseg2, Forceseg3, Forceseg4, Forceseg5, Forceseg6];
ForceAVP = [avgforce1, avgforce2, avgforce3, avgforce4, avgforce5, avgforce6];
ForceVRS = [vforce1, vforce2, vforce3, vforce4, vforce5, vforce6];
ForceMRS = [msforce1, msforce2, msforce3, msforce4, msforce5, msforce6];
ForceDYN = [drforce1, drforce2, drforce3, drforce4, drforce5, drforce6];
ForceRMS = [rootforce1, rootforce2, rootforce3, rootforce4, rootforce5, rootforce6];

%Linear Regression
%All the values are sent into the linear reg function to be plotted
[m, b, y_est, residual, mse1, r_sqr1] = FunctionsLinReg(ForceAVG, ForceAVP);
[m, b, y_est, residual, mse2, r_sqr2] = FunctionsLinReg(ForceAVG, ForceVRS);
[m, b, y_est, residual, mse3, r_sqr3] = FunctionsLinReg(ForceAVG, ForceMRS);
[m, b, y_est, residual, mse4, r_sqr4] = FunctionsLinReg(ForceAVG, ForceDYN);
[m, b, y_est, residual, mse5, r_sqr5] = FunctionsLinReg(ForceAVG, ForceRMS);

Segment = ["MSE", "Corellation Coefficient"]';
AVP = [mse1, r_sqr1(1,2)]';
VRS = [mse2, r_sqr2(1,2)]';
MRS = [mse3, r_sqr3(1,2)]';
DYN = [mse4, r_sqr4(1,2)]';
RMS = [mse5, r_sqr5(1,2)]';
Table = table(Segment, AVP, VRS, MRS, DYN, RMS)

function [MRS, VRS, DYR, AVP, RMS] = extractFeatures1(signal, windowSize)
    for i = 1 : length(signal)-windowSize
        MRS(i) = mean(signal(i : i + windowSize - 1));
        VRS(i) = var(signal(i : i + windowSize - 1));
        DYR(i) = max(signal(i : i + windowSize - 1)) - min(signal(i : i+ windowSize - 1));
        AVP(i) = mean((signal(i : i + windowSize - 1)).^2);
        RMS(i) = rms(signal(i : i + windowSize - 1));
    end
end
