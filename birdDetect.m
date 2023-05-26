function [result,rcall, rcorr,inp] = birdDetect(filename)
[sound1,Fs1] = audioread('Bald Eagle.wav');
sound1 = sound1(:, 1);
[sound2,Fs2] = audioread('Great Tit.wav');
sound2 = sound2(:, 1);
[sound3,Fs3] = audioread('Pheasant Cuckoo.wav');
sound3 = sound3(:, 1);
[sound4,Fs4] = audioread('black capped chickadee.wav');
sound4 = sound4(:, 1);
[sound5,Fs5] = audioread('Hill Pigeon.wav');
sound5 = sound5(:, 1);
[sound6,Fs6] = audioread('Yellow Grosbeak.wav');
sound6 = sound6(:, 1);
Fss = [Fs1 Fs2 Fs3 Fs4 Fs5 Fs6];
birds = {'Bald Eagle' 'Great Tit' 'Pheasant Cuckoo' 'Black Capped Chickadee' 'Hill Pigeon' 'Yellow Grosbeak'};
calls = {sound1,sound2,sound3,sound4,sound5,sound6};
comps = {[],[],[],[],[],[]};
least = [0 0 0 0 0 0];
[input_sound,fs] = audioread(filename);
disp('The input sound is')
sound(input_sound,fs)
pause(length(input_sound)*1/fs)
input_sound = input_sound(:,1);

for i = 1:6
    comps{i} = xcorr(calls{i},input_sound);
    subplot(2,3,i)
    plot(comps{i})
    title(['Input correlated with ' birds{1,i}])
    threshold = 0.65*max(comps{i});
    least(i) = length(find(comps{i}>threshold));
end
[~, index] = min(least);
result = ['This sound belongs to the bird named: ' birds{index}];
rcall = calls{index};
rcorr = comps{index};
inp = input_sound;
sound(calls{index},Fss(index))
figure()
subplot(2,1,1)
plot(comps{index})
title('The auto correlated')
subplot(2,1,2)
plot(input_sound)
end

