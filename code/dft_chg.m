function [F] = dft_chg(img_data)
%DFT2_CHG �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
img_data=im2double(img_data);
sz=size(img_data);
F=zeros(sz);
M=sz(1);
m=0:M-1;
T=1;
if numel(sz)>2
    T=sz(3);
end

for tunnel=1:T
    for column=1:sz(1)
        column_data=img_data(:,column,tunnel);
        part1=exp(-1i*2*pi/M);
        ux=m'*m;
        part2=part1.^ux;
        F(:,column,tunnel)=column_data'*part2;
    end
end
end
