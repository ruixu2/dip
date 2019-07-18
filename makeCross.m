function [se] = makeCross()
%MAKECIRCLE 此处显示有关此函数的摘要
%   此处显示详细说明
res=inputdlg({'请输入十字半长'},'十字结构元素',[1 35],{'3'});
res=str2double(res);
len=res(1,1);
se=zeros(2*len+1,2*len+1);
se(:,len+1)=1;
se(len+1,:)=1;
end