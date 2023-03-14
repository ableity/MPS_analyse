function out = fftRecode(in)
L = length(in);
Y = fft(in);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);

out = P1;
end