function [F] = dft2_chg(img_data)
%DFT2_CHG �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
img_data=im2double(img_data);
sz=size(img_data);
M=sz(1);
N=sz(2);
n=0:N-1;
m=0:M-1;
T=1;
if numel(sz)>2
    T=sz(3);
end
F=zeros(sz);
new_data=zeros(sz);
for tunnel=1:T
    for column=1:sz(1)
        column_data=img_data(:,column,tunnel);
        part1=exp(-1i*2*pi/M);
        ux=m'*m;
        part2=part1.^ux;
        new_data(:,column,tunnel)=column_data'*part2;
    end
end
for tunnel=1:T
    for row=1:sz(2)
        row_data=new_data(row,:,tunnel);
        part1=exp(-1i*2*pi/N);
        vy=n'*n;
        part2=part1.^vy;
        F(row,:,tunnel)=row_data*part2;
    end
end

end


