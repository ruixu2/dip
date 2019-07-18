function [se] = makeRectangle()
%MAKERECTANGLE 此处显示有关此函数的摘要
%   此处显示详细说明
res=inputdlg({'请输入长','请输入宽'},'矩阵结构元素',[1 35;1 35],{'3','3'});
res=str2double(res);
m=res(2,1);
n=res(1,1);
se=ones(m,n);
end
