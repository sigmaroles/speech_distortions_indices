% demonstrate phase jitter
clear all; 
close all;
filepath = './inputs/M2_b6_w6_orig.wav';
% parameter to control distortion -- zero = no distortion, one = max distortion
p_alpha = 0.71;


[sig_orig, fs] = audioread(filepath);
% make sure phasejitter.m is in matlab path
rt = phasejitter(sig_orig, fs, p_alpha);

%[odg, movb] = PQevalAudio_fn(ref, test)
[odg, movb] = PQevalAudio_fn(sig_orig, rt);