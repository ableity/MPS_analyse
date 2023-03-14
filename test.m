clc
clear
close all

filePath1  = "/Volumes/数据存储/MPI/MPS数据/" + ...
    "fsmps20230110/202301105.txt";
data = textread(filePath1);

F1 = fftRecode(data(:,3));
F2 = fftRecode(data(:,4));

datacf = chooseFrequency(data(:,3),1e6,8e3:8e3:40e3);
dataave = averageSignal(data(:,3),2000);
figure
for i = 1:6
    subplot(2,3,i)
    plot(data(1:2000,i),LineWidth=2)
    title("第"+num2str(i)+"列数据")
end


figure
subplot(2,2,1)
plot(data(1:2000,3));
title("原始数据",FontSize=20)
subplot(2,2,2)
plot(data(1:2000,4));
title("选频数据",FontSize=20)

subplot(2,2,3)
plot(0:length(F1)-1,F1);
title("原始数据傅立叶变换",FontSize=20)
subplot(2,2,4)
plot(0:length(F2)-1,F2);
title("选频数据傅立叶变换",FontSize=20)





