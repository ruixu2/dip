function [newImg,g] = otsu(img)
%OTSU 此处显示有关此函数的摘要，输入img
%   此处显示详细说明 返回newImg，g，newImg为二值化的图像，g为阈值
p=zeros(256,1);
w0=zeros(256,1);
w1=zeros(256,1);
u0=zeros(256,1);
u1=zeros(256,1);
u=zeros(256,1);
result=zeros(256,1);
imgSize=size(img);
M=imgSize(1);
N=imgSize(2);
if numel(imgSize)~=2
    img=rgb2gray(img);
end
for t=1:256
    grayScale=t-1;
    x=find(img==grayScale);
    p(t)=length(x)/(M*N);
end
for t=1:256
    w0(t)=sum(p(1:t));
    w1(t)=sum(p(t+1:256));
    u0(t)=0;
    for i=1:t
        u0(t)=u0(t)+(i-1)*p(i)/w0(t);
    end
    u1(t)=0;
    for i=t+1:256
        u1(t)=u1(t)+(i-1)*p(i)/w1(t);
    end
    u(t)=w0(t)*u0(t)+w1(t)*u1(t);
    result(t)=w0(t)*(u0(t)-u(t))^2+w1(t)*(u1(t)-u(t))^2;
end
[~,g]=max(result);
newImg=binaryImg(img,g);
%imshow(newImg);
end
