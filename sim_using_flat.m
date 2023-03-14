clc
clear
close all
% 2023 03 09 李蕾
% 持平段分析

%仿真
t = 0:1e-6:10*1/10e3;
H = zeros(1,length(t));
pos_sim = floor(length(t)/2);
H(pos_sim:end) = 1.5;



parameter = parameter_of_simulation("n",0.65e-3);
[~,ub,~] = simdata_synomag(H,t,parameter);




% 读取地址
filepath  = "/Volumes/数据存储/MPI/MPS数据/20230310/20230310/";
datanum = 2:2:10;

filenum = length(datanum);

for i =1:filenum
filename(i) = "20230310"+num2str(datanum(i))+".txt";
end


%存储原始数据
H_average  =  zeros(2000,filenum);
U_average =  zeros(2000,filenum);


%存储位置
pos = zeros(1,filenum);

%定义寻找好位置时，放置的同起点矩阵
pointnum = 200;

%归一化数据
u_normalize_average = zeros(filenum,pointnum);

%磁场数据
H_pos  = zeros(filenum,1000);

for i = 1:filenum
    %读取数据并保存原始数据
    [Ht,ut] = readdata(filepath+filename(i));
    H_average(:,i) = averagedata(Ht,2000);
    U_average(:,i) = averagedata(ut,2000);

    %寻找信号最大值作为起点
    u_1_T =U_average(1:500,i);
    post = find(u_1_T == max(max(u_1_T)));
    pos(i) = post(1);

end


 r = 4;

 pos(r) = pos(r)+2;


%观察激励磁场是否重合，不重合需要调整pos
figure
for i = 1:filenum
    H_pos(i,:) = H_average(pos(i):pos(i)+999,i);
    plot(H_pos(i,:),LineWidth=2)
    hold on
end
legend("0%","1%","10%","20%","50%",fontsize=20)

%截取
for i = 1:filenum
    %截取归一化
    u_normalize_average(i,:) = U_average(pos(i):pos(i)+pointnum-1,i)/max(max(U_average(pos(i):pos(i)+pointnum-1,i)));
end

%仿真数据
simdata = ub(pos_sim:pos_sim+pointnum-1);
simdata = simdata/max(max(simdata));


%拟合数据
t = 0:1e-6:1e-6*(pointnum-1);
[relaxtime1,intensity1,relaxtime2,intensity2,fitresult] = ...
calc_relax_time_using_fit(t,u_normalize_average(1,:));
fitdata = intensity1*exp(-t./(relaxtime1*1e-6))+...
            intensity2*exp(-t./(relaxtime2*1e-6));
fitdata = fitdata/max(max(fitdata));

[relaxtime1,intensity1,fitresult1D] = ...
calc_relax_time_using_fit1D(t,u_normalize_average(1,:));
fitdata1D = intensity1*exp(-t./(relaxtime1*1e-6));
fitdata1D = fitdata1D/max(max(fitdata1D));

figure
plot(u_normalize_average',"linewidth",2)
legend("0%","1%","10%","20%","50%",fontsize=20)
title("未选频均值",FontSize=20)

figure
plot(t,u_normalize_average(1,:),'k',"linewidth",2)
hold on
plot(t,simdata,"linewidth",2)
hold on
plot(t,fitdata1D,"linewidth",2)
hold on
plot(t,fitdata,"linewidth",2)
legend("实测","仿真","单指数","双指数拟合",FontSize=20)




function [H,M] = readdata(path)
%20230302 李蕾
%修改为增加平均的功能

%20230213 李蕾
%读取脉冲激励MPI的txt数据
    data = textread(path);
%     figure
%     for i = 1:6
%         subplot(2,3,i)
%         plot(data(1:500,i))
%     end
    
    %读取第一列的磁场数据和第四列的粒子信号数据
    
    H = data(:,1);
    M = data(:,3);
    
end

function out = averagedata(in,num)

    
    %读取第一列的磁场数据和第四列的粒子信号数据
    
    %信号长度截取2000个点（必须是1MHz/2kHz的整数倍）
    length_H = num;
    [m,n] = size(in);
    if m>n
        length_total = m;
    else
        length_total = n;
    end
    %重复周期数设置到理论最大值
    num_average = floor(length_total/length_H);
    
    %平均H和M
    in = in(1:length_H*num_average);
    in = reshape(in,length_H,[]);
    out = sum(in,2)/num_average;


end