function new_img = mean_smooth(img,template)
%MEAN_SMOOTH 此处显示有关此函数的摘要
%输入图片img，和模板
%   此处显示详细说明
% img=imread(img_path);
radius=floor(template/2);
shape=size(img);
new_img=img;
for tunnel=1: ndims(img) 
    for height =(radius+1):(shape(1)-radius)
        for width =(radius+1):(shape(2) - radius)
            new_img(height, width,tunnel)=0;
            for i = (-radius):radius
                for j = (-radius):radius
                    new_img(height, width,tunnel) = new_img(height, width,tunnel) + img(height + i, width + j,tunnel)/(template*template);
                end
            end
        end
    end
end
new_img=uint8(new_img);
end


