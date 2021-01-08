% demonstrate phase jitter
clear all; 
close all;
filepath = './inputs/M2_b6_w6_orig.wav';
% parameter to control distortion -- zero = no distortion, one = max distortion
p_alpha = 0.71;


[sig_orig, fs] = audioread(filepath);
% make sure phasejitter.m is in matlab path
rt = phasejitter(sig_orig, fs, p_alpha);

subplot(2,1,1);
plot(sig_orig);
title("original signal");
subplot(2,1,2);
plot(rt);
title("phase jittered signal");

apl = audioplayer(sig_orig, fs);
playblocking(apl);
apl = audioplayer(rt, fs);
playblocking(apl);
fname = filepath + "_phasejittered_" + num2str(p_alpha) + "_.wav";
audiowrite(fname, rt, fs);