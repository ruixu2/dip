function [se] = makeLine()
%MAKERECTANGLE 此处显示有关此函数的摘要
%   此处显示详细说明
res=inputdlg({'请输入长度','请输入角度'},'矩阵结构元素',[1 45],{'3','0'});
res=str2double(res);
len=res(1,1);
deg=res(2,1);
se=strel('line',len,deg);
end

