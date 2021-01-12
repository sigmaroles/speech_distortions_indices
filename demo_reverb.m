clear all;
close all;

addpath('~/workspaces/mylib');

[speechSignalOrig,fs]=audioread('./inputs/000006.wav');
y_reverb = addreverb(speechSignalOrig, fs, [3.4 7.5 8.9 9.2]);

figure;
subplot(2,1,1);
plot(speechSignalOrig);
title("Original speech. RMS = " + num2str(rms(speechSignalOrig)));
subplot(2,1,2);
plot(y_reverb);
title("Reverberant speech. RMS = " + num2str(rms(y_reverb)));

% play the original, wait one second, and then play the reverb result
zer = zeros(fs,1);
%apl1 = audioplayer(speechSignalOrig, fs);
%apl2 = audioplayer(zer, fs);
apl3 = audioplayer(y_reverb, fs);
%playblocking(apl1);
%playblocking(apl2);
playblocking(apl3);