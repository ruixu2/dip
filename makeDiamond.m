function [se] = makeDiamond()
%MAKEDIAMOND 此处显示有关此函数的摘要
%   此处显示详细说明
res2=inputdlg({'请输入中心到顶点的长度'},'菱形结构元素',[1 45],{'3'});
res2=str2double(res2);
len=res2(1,1);
se=strel('diamond',len);
end

