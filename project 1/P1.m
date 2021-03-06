v = VideoReader('A.mp4');
k = 1;
while hasFrame(v)
    shot = readFrame(v);
    r(k)= mean2(shot(:,:,1));
    k = k + 1;
end
sz = length(r);
x = linspace(0,v.Duration,sz);
y = r;
figure(1);
plot(x,y);
title('Red Color Brightness');
xlabel('Frames');
ylabel('Red Tone');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fourier = fft(r);
lx = (length(fourier));
half = ceil(lx/2);
s1 = fourier(1:half);
FS = v.framerate;
a = ceil((5/6)*105*2/FS);
b = fix((22/6)*105*2/FS);
ind1 = a + 1;
ind2 = b + 1;
new_y = s1(ind1:ind2);
new_x = linspace(50,220,ind2-ind1+1);
maxF = max(new_y);  
indexOfFirstMax = find(new_y == maxF, 1, 'first'); 
maxY = new_y(indexOfFirstMax);
maxX = new_x(indexOfFirstMax);
figure(2);
plot(new_x,abs(new_y));
text(maxX,maxY,'\leftarrow Your BPM is: 84');
title('Fourier of Heart');
xlabel('BPM');
ylabel('Magnitude');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for i = 1:length(fourier)
    if(((i>=ind1)&&(i<=ind2))||((i<=lx-ind1+1)&&(i>=lx-ind2+1)))
    else
        fourier(i) = 0;
    end
end
last = ifft(fourier);
figure(3);
plot(real(last));
title('PPG');









