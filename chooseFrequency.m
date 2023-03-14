function out = chooseFrequency(signal,f,frequency_table)
    % 20230307 李蕾 选频程序
    % signal 原始信号，f 采样率，frequency_table选取的频率
    L = length(signal);
    signal_f = fft(signal);
    unit_f = f/L; 
    % 在信号输入前，需要保证frequency_table里面的数都能够整除unit_f

    signla_choose_f = zeros(size(signal_f));

    frequency_num = frequency_table/unit_f;
    for i = 1:length(frequency_table)
        num1 = frequency_num(i)+1;
        num2 = L-frequency_num(i)+1;

        signla_choose_f(num1) = signal_f(num1);
        signla_choose_f(num2) = signal_f(num2);
    end
    out = ifft(signla_choose_f);
end