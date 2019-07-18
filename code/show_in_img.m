function [] = show_in_img(F)
%SHOW_IMG 此处显示有关此函数的摘要
%   此处显示详细说明
F=fftshift(F);
f=abs(F);
f=log10(f+1);
fai=angle(F);
T=1;
sz=size(F);
if numel(sz)>2
    T=sz(3);
end
figure("Name","离散变换","NumberTitle","off");
for zone=1:T
    zone1=subplot(2,T,zone);
    imshow(f(:,:,zone));
    title(zone1,"幅度图");
    zone2=subplot(2,T,T+zone);
    imshow(fai(:,:,zone));
    title(zone2,"相位图");
end
end

