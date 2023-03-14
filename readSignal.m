function [H,u,u_chooseFrequency] = readSignal(filePath)
% 2023 03 11 
% 李蕾
% 读取文件

data = textread(filePath);

[~,n] = size(data);

if n == 3
    H = data(:,1);
    u = data(:,2);
    u_chooseFrequency = data(:,3);
else
    H = data(:,1);
    u = data(:,3);
    u_chooseFrequency = data(:,4);
end

end