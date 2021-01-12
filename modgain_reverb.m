% add reverb to a modulated sinusoid and then calculate its modulation gain

clear all;
close all;

ns = 1;
fs = 44100;
f_carrier = 1000;
f_mod = 6;
moddepth = -10;
ramplen = 0.05; %ms


m = 10 ^ (moddepth/20);
timev = linspace(0,ns,fs);
carrier = sin(2*pi*f_carrier*timev);
modulator = (1 + (m * sin(2*pi*f_mod*timev))) / 2;
zz = zeros(1,round(fs/10));
psig = carrier .* modulator;
ramp = tukeywin(length(psig), 2*ramplen);
ramp = ramp';
psig2 = psig .* ramp;
psig2 = horzcat(zz, horzcat(psig, zz))';
psig_reverb = addreverb(psig2, fs, [9.2 12 18])';

n_samples = ns*fs;
indx1 = round(n_samples/2);
indx2 = round(n_samples/2) + round(n_samples/3);
psig2 = psig2(indx1:indx2);
psig_reverb = psig_reverb(indx1:indx2);

env_input = abs(hilbert(psig2));
env_output = abs(hilbert(psig_reverb));

modgain = get_mindex(env_input, env_output);
fprintf("Modulation index (output/input) raw : %.6f\n", modgain);

subplot(2,1,1);
plot(env_input);
xlim([0 length(psig_reverb)]);
title("Original, samples = " + num2str(length(psig2)))
subplot(2,1,2);
plot(env_output);
xlim([0 length(psig_reverb)]);
title("Reverb-ed, samples = " + num2str(length(psig_reverb)) + "mod. gain = " + num2str(modgain));


function m_gain = get_mindex(e1, e2)
    vi_max = max(e1);
    vi_min = min(e1);
    vo_max = max(e2);
    vo_min = min(e2);
    m_input = 1 - (vi_min / vi_max);
    m_output = 1 - (vo_min / vo_max);
    m_gain = m_output / m_input;
    fprintf("Insig: max = %.4f, min = %.4f, mod index = %.4f (%.4f dB)\n", vi_max, vi_min, m_input, 20*log10(m_input));
    fprintf("Outsig: max = %.4f, min = %.4f, mod index = %.4f (%.4f dB)\n", vo_max, vo_min, m_output, 20*log10(m_output));
end