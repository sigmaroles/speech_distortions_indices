% demonstrate HAAQI on phase jittered speech
clear all; 
close all;

filepath = './inputs/000006.wav';

%addpath('~/workspaces/mylib');
%addpath('/home/sigmaroles/workspaces/toolboxes/visqolrelease');
[sig_orig, fs] = audioread(filepath);
palpha_space = linspace(0,0.4,190);


score = [];

for i = 1:length(palpha_space)

    p_alpha = palpha_space(i);
    rt = phasejitter(sig_orig, fs, p_alpha);

    %function [moslqo, vnsim, debugInfo]=visqol(refSig,fs1,degSig,fs2,bandFlag,plotFlag,debugFlag)
    [ascore,blah1,blah2] = visqol(sig_orig,fs,rt,fs,'WB',0,0);
    fprintf("alpha = %.5f, VISQOL score = %.6f\n", p_alpha, ascore);
    score = [score; ascore];

end

plot(palpha_space, score);
xlabel("alpha (amount of phase jitter");
ylabel("VISQOL score");