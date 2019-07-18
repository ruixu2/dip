function [newImg] = binaryImg(img,g)
%BINARYIMG 此处显示有关此函数的摘要
%   此处显示详细说明
sz=size(img);
newImg=zeros(sz);
for i=1:sz(1)
    for j=1:sz(2)
        if img(i,j)>g
           newImg(i,j)=1;
        end
    end
end
end

