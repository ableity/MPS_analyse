clc
clear
close all
filePath2 = "/Volumes/数据存储/MPI/MPS数据/" + ...
    "20230310/20230310/2023031014.txt";
filePath1 = "/Volumes/数据存储/MPI/MPS数据/" + ...
    "20230210北京脉冲MPS数据/20220616/20220616181.txt";

[H,u,u_chooseFrequency] = readData(filePath2);

u = averageSignal(u,2000);
u_chooseFrequency = averageSignal(u_chooseFrequency,2000);

figure
subplot(2,1,1)
plot(u(301:800))
title("不选频只平均")
subplot(2,1,2)
plot(u_chooseFrequency(301:800))
title("选频平均")