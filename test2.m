clc
clear
close all

filePath1 = "/Volumes/数据存储/MPI/MPS数据/" + ...
    "20230210北京脉冲MPS数据/20220616/20220616181.txt";
filePath2 = "/Volumes/数据存储/MPI/MPS数据/" + ...
    "20230310/20230310/2023031014.txt";

[H,u,u_chooseFrequency] = readData(filePath1);

[H2,u2,u_chooseFrequency2] = readData(filePath2);
figure
plot(H(1:2000))
hold on
plot(-H2(1:2000))
legend("old","new")

% F1 = fftRecode(u_chooseFrequency);
% F2 = fftRecode(u_chooseFrequency2);

F1 = fftRecode(u);
F2 = fftRecode(u2);
figure
plot(F1,'r',LineWidth=2)
hold on
plot(F2,'b',LineWidth=2)
hold on
plot(2001:4000:46001,F1(2001:4000:46001),'r',LineWidth=2)
hold on
plot(2001:4000:46001,F2(2001:4000:46001),'k',LineWidth=2)
legend("old","new")
xlim([0,58001])

F1 = F1/F1(2001);
F2 = F2/F2(2001);

figure
plot(F1,'r',LineWidth=2)
hold on
plot(F2,'b',LineWidth=2)
hold on
plot(2001:4000:46001,F1(2001:4000:46001),'r',LineWidth=2)
hold on
plot(2001:4000:46001,F2(2001:4000:46001),'k',LineWidth=2)
legend("old","new")
xlim([0,58001])
title("最大值归一化")


figure
subplot(2,1,1)
plot(F1)
title("old")
subplot(2,1,2)
plot(F2)
title("new")

figure
subplot(2,1,1)
plot(u_chooseFrequency(1:1000))
title("old")
subplot(2,1,2)
plot(u_chooseFrequency2(1:1000))
title("new")


