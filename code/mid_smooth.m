function new_img = mid_smooth(img,template)
%MEAN_SMOOTH 此处显示有关此函数的摘要
% 输入img和模板
%   此处显示详细说明
% img=imread(img_path);
radius=floor(template/2);
shape=size(img);
new_img=img;

for tunnel=1:ndims(img)
    for height =radius+1:shape(1)-radius
        for width =radius+1:shape(2) - radius
            new_img(height, width,tunnel)=0;
            pixel=zeros(template,template);
            for i = (-radius):radius
                for j = (-radius):radius
                    pixel((i+radius+1),(j+radius+1)) = img(height + i, width + j,tunnel);
                end
            end
            pixel=sort(pixel,2);
            new_img(height, width,tunnel)=pixel(floor(template^2/2));
        end
    end
end

new_img=uint8(new_img);
end