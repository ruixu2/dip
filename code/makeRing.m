function [se] = makeCircle()
%MAKECIRCLE 此处显示有关此函数的摘要
%   此处显示详细说明
res=inputdlg({'请输入内半径r','请输入外半径R'},'环形结构元素',[1 35;1 35],{'3','5'});
res=str2double(res);
r=res(1,1);
R=res(2,1);
se=zeros(2*R+1,2*R+1);
for i=1:2*R+1
    for j=1:2*R+1
        if abs(i-R-1)+abs(j-R-1)>=r&&abs(i-R-1)+abs(j-R-1)<=R
            se(i,j)=1;
        end
    end
end
end
