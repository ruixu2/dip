function new_img = prewitt_first_sharpen(img,dire)
%FIRST_SHARPEN 此处显示有关此函数的摘要
%   此处显示详细说明
% img=imread(img_path);
new_img=img;
shape=size(img);
if dire==1
    for tunnel=1:ndims(img)
        for height=2:shape(1)-1
            for width=2:shape(2)-1
                new_img(height,width,tunnel)=img(height+1,width,tunnel)+img(height+1,width-1,tunnel)+img(height+1,width+1,tunnel)-img(height-1,width+1,tunnel)-img(height-1,width,tunnel)-img(height-1,width-1,tunnel);
            end
        end
    end 
end
if dire==2
    for tunnel=1:ndims(img)
        for height=2:shape(1)-1
            for width=2:shape(2)-1
                new_img(height,width,tunnel)=img(height,width+1,tunnel)+img(height+1,width+1,tunnel)+img(height-1,width+1,tunnel)-img(height-1,width-1,tunnel)-img(height+1,width-1,tunnel)-img(height,width-1,tunnel);
            end
        end
        
    end
end
new_img=uint8(new_img);
end


