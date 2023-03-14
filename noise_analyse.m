clc
clear
close all
% 20230313数据
% 噪声分析

% 信号数据
[H,u,~] = readSignal("/Volumes/数据存储/MPI/MPS数据/" + ...
    "20230313/202303135.txt");
Fu = fftRecode(u);

% 噪声数据
[~,noise,~] = readSignal("/Volumes/数据存储/MPI/MPS数据/" + ...
    "20230313/202303136.txt");
Fn = fftRecode(noise);

%对信号选频删频
frequency_table = find(Fn>0.002)-1;
out = deleteFrequency(u,1e6,frequency_table);

choosefre = 1:1e5;
out = chooseFrequency(out,1e6,choosefre);

%选频删频后的频谱
Fu_d = fftRecode(out);

%求平均
out = averageSignal(out,2000);

%找出信号的持平段
[H_flat,u_flat,pos] = exactFlatSignal(H, out);

%频率轴
f = 0:length(Fu)-1;


figure
subplot(4,1,1)
plot(f,Fu,"linewidth",2)
hold on
plot(f,Fn,"linewidth",2)
legend("signal","noise")
subplot(4,1,2)
plot(f,Fu,"linewidth",2)
title("signal","FontSize",20)
subplot(4,1,3)
plot(f,Fu_d,"linewidth",2)
title("signal delete frequency","FontSize",20)

subplot(4,1,4)
plot(f,Fn,"linewidth",2)
title("noise","FontSize",20)

figure
plot(u_flat(1:200))
title("持平段","FontSize",20)

figure
plot(u_flat)
title("持平段","FontSize",20)

clc
clear

%2kHz,3mT噪声
[H,noise_2k_3mT,~] = readSignal("/Volumes/数据存储/MPI/MPS数据/" + ...
    "20230313/202303136.txt");
Fn_2k_3mT = fftRecode(noise_2k_3mT);

%2kHz,1mT噪声
[~,noise_2k_1mT,~] = readSignal("/Volumes/数据存储/MPI/MPS数据/" + ...
    "20230313/2023031333.txt");
Fn_2k_1mT = fftRecode(noise_2k_1mT);

%2.5kHz,2mT噪声
[~,noise_2_5k_2mT,~] = readSignal("/Volumes/数据存储/MPI/MPS数据/" + ...
    "20230313/2023031333.txt");
Fn_25k_2mT = fftRecode(noise_2_5k_2mT);

%2kHz,10mT噪声
[~,noise_2k_10mT,~] = readSignal("/Volumes/数据存储/MPI/MPS数据/" + ...
    "20230313/2023031366.txt");
Fn_2k_10mT = fftRecode(noise_2k_10mT);
f = 0:length(Fn_2k_10mT)-1;
figure
subplot(4,1,1)
plot(f,Fn_2k_1mT)
title("2kHz,1mT噪声",FontSize=20)
subplot(4,1,2)
plot(f,Fn_2k_3mT)
title("2kHz,3mT噪声",FontSize=20)
subplot(4,1,3)
plot(f,Fn_2k_10mT)
title("2kHz,10mT噪声",FontSize=20)
subplot(4,1,4)
plot(f,Fn_25k_2mT)
title("2.5kHz,2mT噪声",FontSize=20)
