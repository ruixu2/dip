function varargout = homework(varargin)
% homework MATLAB code for homework.fig
%      homework, by itself, creates a new homework or raises the existing
%      singleton*.
%
%      H = homework returns the handle to a new homework or the handle to
%      the existing singleton*.
%
%      homework('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in homework.M with the given input arguments.
%
%      homework('Property','Value',...) creates a new homework or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before homework_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to homework_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% adjust the above text to modify the response to help homework

% Last Modified by GUIDE v2.5 13-Jun-2019 19:17:35

% Begin initialization code - DO NOT ADJUST
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @homework_OpeningFcn, ...
    'gui_OutputFcn',  @homework_OutputFcn, ...
    'gui_LayoutFcn',  [] , ...
    'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT ADJUST


% --- Executes just before homework is made visible.
function homework_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to homework (see VARARGIN)

% Choose default command line output for homework
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes homework wait for user response (see UIRESUME)
% uiwait(handles.mainFig);


% --- Outputs from this function are returned to the command line.
function varargout = homework_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --------------------------------------------------------------------
function file_Callback(hObject, eventdata, handles)
% hObject    handle to file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function adjust_Callback(hObject, eventdata, handles)
% hObject    handle to adjust (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function image_Callback(hObject, eventdata, handles)
    %h=msgbox("请期待后续更新！");
    %uiwait(h);
% hObject    handle to image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function help_Callback(hObject, eventdata, handles)
% hObject    handle to help (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function open_img_Callback(hObject, eventdata, handles)
set(handles.hint,"Visible","off");
%初始化设置结构元素
se=ones(3,3);
handles.se=se;
[img_name,img_path]=uigetfile({'*.jpg;*.jpeg;*.bmp;*.tif;*.tiff;*.png'},"选择图片");
if img_name==0
    return
end
img=imread([img_path,img_name]);

imgInfo=imfinfo([img_path,img_name]);
handles.imgInfo=imgInfo;
% 保存imgInfo
axes(handles.img_zone);
imshow(img);
%显示图片
pos=get(handles.img_zone,'pos');
pos(1:4)=[450-imgInfo.Width/2 350-imgInfo.Height/2  imgInfo.Width imgInfo.Height];
set(handles.img_zone,'pos',pos);
%保存后面操作需要的数据
handles.rawImg=img;
handles.new_img=img;
handles.img_name=img_name;
handles.img_path=img_path;
% 建立信息面板
% imgFields=fieldnames(imgInfo);
% infoCell=cell(length(imgFields),2);
% for i=1:length(imgFields)
%     value=getfield(imgInfo,imgFields{i});
%     infoCell{i,1}=imgFields{i};
%     infoCell{i,2}=value;
% end
% 
% set(handles.infoTable,'Data',infoCell);

guidata(hObject,handles);
% hObject    handle to open_img (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function save_img_Callback(hObject, eventdata, handles)
new_img=handles.new_img;
img_path=handles.img_path;
img_name=handles.img_name;
imwrite(new_img,[img_path img_name]);
msgbox("已保存","提示");
% hObject    handle to save_img (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function save_another_Callback(hObject, eventdata, handles)
[img_name,img_path]=uiputfile({'*.jpg;*.jpeg;*.bmp;*.tif;*.tiff'},"另存为");
new_img=handles.new_img;
imwrite(new_img,[img_path img_name]);
% hObject    handle to save_another (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




% --------------------------------------------------------------------
function filter_Callback(hObject, eventdata, handles)
% hObject    handle to filter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function mean_filter_Callback(hObject, eventdata, handles)
    %img_path=handles.img_path;
    %img_name=handles.img_name;
    img=handles.new_img;
    %得到用户输入的模板大小，默认为3
    definput={'3'};
    while true
        input=inputdlg("输入模板大小,如3x3输入3即可,必须为奇数","模板大小",[1 40],definput);
        if isempty(input)
            return
        end
        template_size=str2double(input);
        if mod(template_size,2)==1
           break
        end
        f=errordlg("请重新输入","模板大小错误");
        uiwait(f);
    end
    %进行图片的均值滤波
    new_img=mean_smooth(img,template_size);
    imshow(new_img);
    handles.new_img=new_img;
    guidata(hObject,handles);


% hObject    handle to mean_filter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --------------------------------------------------------------------
function mid_filter_Callback(hObject, eventdata, handles)
% img_path=handles.img_path;
% img_name=handles.img_name;
img=handles.new_img;
definput={'3'};
 %得到用户输入的模板大小，默认为3
while true
    input=inputdlg("输入模板大小,如3x3输入3即可,必须为奇数","模板大小",[1 40],definput);
    if isempty(input)
        return
    end
    template_size=str2double(input);
    if mod(template_size,2)==1
       break
    end
    f=errordlg("请重新输入","模板大小错误");
    uiwait(f);
end
%进行中值滤波
new_img=mid_smooth(img,template_size);
imshow(new_img);
handles.new_img=new_img;
guidata(hObject,handles);
% hObject    handle to mid_filter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function first_sharpen_Callback(hObject, eventdata, handles)
%     img_path=handles.img_path;
%     img_name=handles.img_name;
img=handles.new_img;
 %得到用户输入的选项
[index,tf]=listdlg("ListString",{'普通水平','普通垂直','Sobel水平','Sobel垂直','Reborts水平','Reborts垂直','Prewitt水平','Prewitt垂直'},"Name","选择锐化","SelectionMode","Single","ListSize",[200 130]);
%根据选项进行锐化
if index==1
    new_img=first_sharpen(img,1);
elseif index==2
    new_img=first_sharpen(img,2);
elseif index==3
    new_img=sobel_first_sharpen(img,1);
elseif index==4
    new_img=first_sharpen(img,2);
elseif index==5
    new_img=reborts_first_sharpen(img,1);
elseif index==6
    new_img=reborts_first_sharpen(img,2);
elseif index==7
    new_img=prewitt_first_sharpen(img,1);
elseif index==8
    new_img=prewitt_first_sharpen(img,2);
end
imshow(new_img);
handles.new_img=new_img;
guidata(hObject,handles);
% hObject    handle to first_sharpen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function second_sharpen_Callback(hObject, eventdata, handles)
% img_path=handles.img_path;
% img_name=handles.img_name;
img=handles.new_img;
%得到用户输入的选项
[index,tf]=listdlg("ListString",{'普通水平','普通垂直','Laplacian普通','Laplacian对角'},"Name","选择锐化","SelectionMode","Single","ListSize",[200 100]);
%根据选项进行锐化
if index==1
    
    new_img=second_sharpen(img,1);
elseif index==2
    new_img=second_sharpen(img,2);
elseif index==3
    new_img=laplacian_second_sharpen(img,1);
elseif index==4
    new_img=laplacian_second_sharpen(img,2);
end

axes(handles.img_zone);
imshow(new_img);
handles.new_img=new_img;
guidata(hObject,handles);
% hObject    handle to second_sharpen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function template_size_Callback(hObject, eventdata, handles)
% hObject    handle to template_size (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function template_size_CreateFcn(hObject, eventdata, handles)
% hObject    handle to template_size (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --------------------------------------------------------------------
function shear_Callback(hObject, eventdata, handles)
img=handles.new_img;
img=imcrop(img);
%判断是否截图
if isempty(img)
    img=handles.new_img;
end
handles.new_img=img;
imgInfo=handles.imgInfo;

%重新调整图片的位置
pos=get(handles.img_zone,'pos');
pos(1:4)=[450-imgInfo.Width/2 350-imgInfo.Height/2  imgInfo.Width imgInfo.Height];
set(handles.img_zone,'pos',pos);
imshow(img);
%显示图片
guidata(hObject,handles);
% hObject    handle to shear (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function zoom_Callback(hObject, eventdata, handles)
img=handles.new_img;
%得到用户的输入缩放倍数
input=inputdlg("输入缩放倍数","缩放大小",[1 40],{'1'});
scale=str2double(input);

imgInfo=handles.imgInfo;
imgInfo.Height=imgInfo.Height*scale;
imgInfo.Width=imgInfo.Width*scale;

%图片进行调整大小
img=imresize(img,scale);
%重新设置图片位置
imshow(img);
pos=get(handles.img_zone,'pos');
pos(1:4)=[450-imgInfo.Width/2 350-imgInfo.Height/2  imgInfo.Width imgInfo.Height];
set(handles.img_zone,'pos',pos);
handles.new_img=img;
handles.imgInfo=imgInfo;
guidata(hObject,handles);
% hObject    handle to zoom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function fourier_Callback(hObject, eventdata, handles)
% hObject    handle to fourier (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function one_discrete_Callback(hObject, eventdata, handles)
% img_path=handles.img_path;
% img_name=handles.img_name;
% img=imread([img_path img_name]);
img=handles.new_img;
sz=size(img);
f=zeros(sz);

%直接调用库函数进行傅里叶变换，增加效率
if numel(sz)==2
    f=fft(img);
end
if numel(sz)>2
    for i=1:sz(3)
       f(:,:,i)=fft(img(:,:,i));
    end
end
imshow(f);
show_in_img(f);
handles.f=f;
guidata(hObject,handles);
% hObject    handle to one_discrete (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function two_discrete_Callback(hObject, eventdata, handles)
% img_path=handles.img_path;
% img_name=handles.img_name;
% img=imread([img_path img_name]);
img=handles.new_img;
sz=size(img);
f=zeros(sz);

%直接调用库函数进行傅里叶变换，增加效率
if numel(sz)==2
    f=fft(img);
end
if numel(sz)>2
    for i=1:sz(3)
        f(:,:,i)=fft2(img(:,:,i));
    end
end
imshow(f);
show_in_img(f);
handles.f=f;
guidata(hObject,handles);
% hObject    handle to two_discrete (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function morphology_Callback(hObject, eventdata, handles)
% hObject    handle to morphology (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function binProcess_Callback(hObject, eventdata, handles)
% hObject    handle to binProcess (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
img=handles.new_img;
flag=inputdlg("请输入阈值",'二值化',[1 40],{'128'});
flag=str2double(flag)/255;
img=im2bw(img,flag);
handles.new_img=img;
axes(handles.img_zone);
imshow(img);
handles.new_img=img;
guidata(hObject,handles);


% --------------------------------------------------------------------
function expand_Callback(hObject, eventdata, handles)
img=handles.new_img;
%拿到结构元素
se=handles.se;
%进行图片膨胀
img=imdilate(img,se);
handles.new_img=img;
axes(handles.img_zone);
imshow(img);
guidata(hObject,handles);
% hObject    handle to expand (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function etch_Callback(hObject, eventdata, handles)
img=handles.new_img;
%拿到结构元素
se=handles.se;
%进行图片腐蚀
img=imerode(img,se);
handles.new_img=img;
axes(handles.img_zone);
imshow(img);
guidata(hObject,handles);
% hObject    handle to etch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function open_Callback(hObject, eventdata, handles)
% hObject    handle to open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
img=handles.new_img;
se=handles.se;
%进行图片开操作
img=imopen(img,se);
handles.new_img=img;
axes(handles.img_zone);
imshow(img);
guidata(hObject,handles);

% --------------------------------------------------------------------
function close_Callback(hObject, eventdata, handles)
% hObject    handle to close (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
img=handles.new_img;
se=handles.se;
%进行图片关操作
img=imclose(img,se);
handles.new_img=img;
axes(handles.img_zone);
imshow(img);
guidata(hObject,handles);

% --------------------------------------------------------------------
function structUnit_Callback(hObject, eventdata, handles)
result=listdlg('ListString',{"矩形","圆形","圆环","十字","线","菱形"},'ListSize',[160,100],'SelectionMode','single');
switch result
    case 1
        se=makeRectangle();
    case 2
        se=makeCircle();
    case 3
        se=makeRing();
    case 4
        se=makeCross();
    case 5
        se=makeLine();
    case 6
        se=makeDiamond();
end
%创建不同类型的结构元素
handles.se=se;
guidata(hObject,handles);

% hObject    handle to structUnit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function weightingFilter_Callback(hObject, eventdata, handles)
% hObject    handle to weightingFilter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
definput={'1','2'};
input=inputdlg({"输入对角权重","请输入邻边权重"},"加权模板3x3",[1 40;1 40],definput);
if isempty(input)
    return
end

%增加加权的滤波模板
template_size=str2double(input);
h=zeros(3,3);
h(2,:)=template_size(2,1);
h(:,2)=template_size(2,1);
h(1,1)=template_size(1,1);
h(1,3)=template_size(1,1);
h(3,1)=template_size(1,1);
h(3,3)=template_size(1,1);
h=h./sum(sum(h));
img=handles.new_img;
new_img=imfilter(img,h);
imshow(new_img);
handles.new_img=new_img;
guidata(hObject,handles);


% hObject    handle to mean_filter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --------------------------------------------------------------------


% --------------------------------------------------------------------
function restore_Callback(hObject, eventdata, handles)
img=handles.rawImg;
handles.new_img=img;
imshow(img);
guidata(hObject,handles);
%将图片还原到最初的样子
% hObject    handle to restore (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_2_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function imgDivision_Callback(hObject, eventdata, handles)
% hObject    handle to imgDivision (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function otsu_Callback(hObject, eventdata, handles)
img=handles.new_img;
%图片进行大津法风
img=otsu(img);
axes(handles.img_zone);
imshow(img);
handles.new_img=img;
guidata(hObject,handles);
% hObject    handle to otsu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function iter_Callback(hObject, eventdata, handles)
img=handles.new_img;
img=iter(img);
%图像进行迭代法分割
axes(handles.img_zone);
imshow(img);
handles.new_img=img;
guidata(hObject,handles);
% hObject    handle to iter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function iDftChg_Callback(hObject, eventdata, handles)
% hObject    handle to iDftChg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
f=handles.f;
sz=size(f);
%直接调用库函数进行反傅里叶变换，增加效率
%判断sz的个数
if numel(sz)==2
    img=ifft(f);
end
if numel(sz)>2
    for i=1:sz(3)
        img(:,:,i)=ifft(f(:,:,i));
    end
end
img=uint8(img);
imshow(img);
% handles.new_img=img;
guidata(hObject,handles);


% --------------------------------------------------------------------
function iDft2Chg_Callback(hObject, eventdata, handles)
% hObject    handle to iDft2Chg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
f=handles.f;
sz=size(f);
%直接调用库函数进行反傅里叶变换，增加效率
if numel(sz)==2
    img=ifft(f);
end
if numel(sz)>2
    for i=1:sz(3)
        img(:,:,i)=ifft2(f(:,:,i));
    end
end
img=uint8(img);
imshow(img);
guidata(hObject,handles);


% --------------------------------------------------------------------
function enhance_Callback(hObject, eventdata, handles)
% hObject    handle to enhance (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function segment_Callback(hObject, eventdata, handles)
% hObject    handle to segment (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function threSegm_Callback(hObject, eventdata, handles)
% hObject    handle to threSegm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
level=graythresh(handles.new_img);
handles.new_img=im2bw(handles.new_img,level);
imshow(handles.new_img);
guidata(hObject,handles);

% --------------------------------------------------------------------
function edgeExtra_Callback(hObject, eventdata, handles)
img=handles.new_img; 
sz=size(img);
if numel(sz)>2
    img=rgb2gray(img);
end
%图像进行边缘提取
img=edge(img);
imshow(img);
handles.new_img=img;
guidata(hObject,handles);
% hObject    handle to edgeExtra (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function histogram_Callback(hObject, eventdata, handles)
img=handles.new_img;
figure('NumberTitle', 'off', 'Name', '直方图');
imhist(img);
%显示图片的直方图
% handles.imgHist=
% hObject    handle to histogram (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --------------------------------------------------------------------
function equal_Callback(hObject, eventdata, handles)
img=handles.new_img;
%对图片进行均衡化
img=histeq(img);
imshow(img);
handles.new_img=img;
guidata(hObject,handles);
% hObject    handle to equal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function smooth_Callback(hObject, eventdata, handles)
% hObject    handle to smooth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function sharpen_Callback(hObject, eventdata, handles)
% hObject    handle to sharpen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function rgb2gray_Callback(hObject, eventdata, handles)
% hObject    handle to rgb2gray (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
img=handles.new_img;
%将图片进行rgb转灰度
img=rgb2gray(img);
handles.new_img=img;
imshow(handles.new_img);
guidata(hObject,handles);

% --------------------------------------------------------------------
function rgb2bin_Callback(hObject, eventdata, handles)
% hObject    handle to rgb2bin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
img=handles.new_img;
%先将图片转灰度，再将图片转黑白
img=rgb2gray(img);
img=otsu(img);
handles.new_img=img;
imshow(img);
guidata(hObject,handles);

% --------------------------------------------------------------------
function gray2bin_Callback(hObject, eventdata, handles)
% hObject    handle to gray2bin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
img=handles.new_img;
sz=size(img);
if numel(sz)>2
    errordlg("图片不是灰度图片",'错误');
end
%将灰度图片转黑白
img=otsu(img);
handles.new_img=img;
imshow(img);
guidata(hObject,handles);


% --------------------------------------------------------------------
function useGuide_Callback(hObject, eventdata, handles)
open("作业final程序操作手册.pdf");
% hObject    handle to useGuide (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function about_Callback(hObject, eventdata, handles)
f = msgbox("作者qq：1983782527","关于");
% hObject    handle to about (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function openImg_ClickedCallback(hObject, eventdata, handles)
set(handles.hint,"Visible","off");
se=ones(3,3);
handles.se=se;
[img_name,img_path]=uigetfile({'*.jpg;*.jpeg;*.bmp;*.tif;*.tiff;*.png'},"选择图片");
if img_name==0
    return
end
img=imread([img_path,img_name]);
imgInfo=imfinfo([img_path,img_name]);
handles.imgInfo=imgInfo;
% 保存imgInfo
axes(handles.img_zone);
imshow(img);
pos=get(handles.img_zone,'pos');
pos(1:4)=[450-imgInfo.Width/2 350-imgInfo.Height/2  imgInfo.Width imgInfo.Height];
set(handles.img_zone,'pos',pos);

handles.rawImg=img;
handles.new_img=img;
handles.img_name=img_name;
handles.img_path=img_path;
% 建立信息面板
% imgFields=fieldnames(imgInfo);
% infoCell=cell(length(imgFields),2);
% for i=1:length(imgFields)
%     value=getfield(imgInfo,imgFields{i});
%     infoCell{i,1}=imgFields{i};
%     infoCell{i,2}=value;
% end
% 
% set(handles.infoTable,'Data',infoCell);

guidata(hObject,handles);
% hObject    handle to open_img (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function saveImg_ClickedCallback(hObject, eventdata, handles)
new_img=handles.new_img;
img_path=handles.img_path;
img_name=handles.img_name;
imwrite(new_img,[img_path img_name]);
%写入图片，并提示已保存信息
msgbox("已保存","提示");
% hObject    handle to saveImg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function addNoise_Callback(hObject, eventdata, handles)
img=handles.new_img;
[index,tf]=listdlg("ListString",{'椒盐噪声','高斯白噪声','斑点噪声','泊松噪声'},"Name","选择噪声","SelectionMode","Single","ListSize",[200 130]);
%根据输入加入不同的噪声
if index==1
    new_img=imnoise(img,'salt & pepper');
elseif index==2
    new_img=imnoise(img,'gaussian');
elseif index==3
    new_img=imnoise(img,'speckle');
elseif index==4
    new_img=imnoise(img,'poisson');
end
imshow(new_img);
handles.new_img=new_img;
guidata(hObject,handles);
% hObject    handle to addNoise (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function gaussianFilter_Callback(hObject, eventdata, handles)
% hObject    handle to gaussianFilter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
img=handles.new_img;
sz=inputdlg('请输入模板大小','模板创建',[1 40]);
s=str2double(sz);
h=fspecial('gaussian',s);
img=imfilter(img,h);
imshow(img);
handles.new_img=img;
guidata(hObject,handles);

% --------------------------------------------------------------------
function motionFilter_Callback(hObject, eventdata, handles)
% hObject    handle to motionFilter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
img=handles.new_img;
sz=inputdlg({'请输入长度','请输入角度'},'模板创建',[1 40]);
s=str2double(sz);
h=fspecial('gaussian',s(1,1),s(2,1));
img=imfilter(img,h);
imshow(img);
handles.new_img=img;
guidata(hObject,handles);
