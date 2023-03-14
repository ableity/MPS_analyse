function out = averageSignal(signal,num)
    %信号长度截取2000个点（必须是1MHz/2kHz的整数倍）
    length_total = length(signal);

    %重复周期数设置到理论最大值
    num_average = floor(length_total/num);
    %平均H和M
    in = signal(1:num*num_average);
    in = reshape(in,num,[]);
    out = sum(in,2)/num_average;

end