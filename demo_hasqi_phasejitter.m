% demonstrate HAAQI on phase jittered speech
clear all; 
close all;

filepath = './inputs/000006.wav';

addpath('~/workspaces/mylib');
addpath('/home/sigmaroles/workspaces/toolboxes/HASPI_HASQI_HAAQI');
[sig_orig, fs] = audioread(filepath);
palpha_space = linspace(0,1,50);


score = [];

for i = 1:length(palpha_space)

    p_alpha = palpha_space(i);

    rt = phasejitter(sig_orig, fs, p_alpha);

    HL = ones(1,6); % no hearing loss = no gain applied .. is this correct ??

    %[Combined,Nonlin,Linear,raw] = HASQI_v2(x,fx,y,fy,HL,eq,Level1)
    [Combined,Nonlin,Linear,raw] = HASQI_v2(sig_orig,fs,rt,fs,HL,1,65);

    fprintf("alpha = %.3f, combined HASQI score = %.5f\n", p_alpha, Combined);

    score = [score; Combined];

end

plot(palpha_space, score);
xlabel("alpha (amount of phase jitter");
ylabel("HASQI combined score");