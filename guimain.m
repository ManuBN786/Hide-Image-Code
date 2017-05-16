function varargout = guimain(varargin)
% GUIMAIN MATLAB code for guimain.fig
%      GUIMAIN, by itself, creates a new GUIMAIN or raises the existing
%      singleton*.
%
%      H = GUIMAIN returns the handle to a new GUIMAIN or the handle to
%      the existing singleton*.
%
%      GUIMAIN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUIMAIN.M with the given input arguments.
%
%      GUIMAIN('Property','Value',...) creates a new GUIMAIN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before guimain_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to guimain_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help guimain

% Last Modified by GUIDE v2.5 03-Dec-2014 10:57:44

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @guimain_OpeningFcn, ...
                   'gui_OutputFcn',  @guimain_OutputFcn, ...
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
% End initialization code - DO NOT EDIT


% --- Executes just before guimain is made visible.
function guimain_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to guimain (see VARARGIN)

% Choose default command line output for guimain
handles.output = hObject;
ss = ones(256,256);
axes(handles.axes1);
imshow(ss);
axes(handles.axes2);
imshow(ss);
axes(handles.axes4);
imshow(ss);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes guimain wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = guimain_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in CoverImage.
function CoverImage_Callback(hObject, eventdata, handles)
% hObject    handle to CoverImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cd 'Images'
[FileName,PathName] = uigetfile('*.jpg;*.png;*.bmp','Pick an image');
if isequal(FileName,0)||isequal(PathName,0)
    warndlg('User Press Cancel');
else

    a = imread(FileName);
    input =imresize(a,[512 512]);  
    
    [r,c,p] = size(input);
%     save p;
%     if p==3 
%     R=input(:,:,1);
%     G=input(:,:,2);
%     B=input(:,:,3);
%     figure; 
    axes(handles.axes1);
    imshow(input);
    title('Cover Image');
  
%     figure;
%     imshow(B);
%     title('B Plane Image');
% 
%     else
%         B = input;
%         figure;
%         imshow(B);
%         title('Cover Image');
%     end
end
 % [S1,S2,S3,S4,S5,S6,S7,S8,S9,S10,S11,S12,S13,S14,S15,S16] = Color_Divide4_4(input);
cd ..
helpdlg('Input Image is Selected');
[S1,S2,S3,S4,S5,S6,S7,S8,S9,S10,S11,S12,S13,S14,S15,S16] = Color_Divide4_4(input);
handles.FileName = FileName;
handles.input = input;
guidata(hObject,handles);


% --- Executes on button press in WaterMarkImage.
function WaterMarkImage_Callback(hObject, eventdata, handles)
% hObject    handle to WaterMarkImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cd 'Images'
%% watermarked Image1
[file,path] = uigetfile('*.png;*.jpg;*.bmp;','Pick an Image File');
if isequal(file,0) || isequal(path,0)
    warndlg('User Pressed Cancel');
else
    wimage1 = imread(file);
    wtimage1=imresize(wimage1,[256 256]);
   % wtimage1 = imadjust(wtimage1,stretchlim(wtimage1));
    
   

%     figure;
    axes(handles.axes2);
    imshow(wtimage1);
    waterbits1 = wtimage1(:);
%  figure, imshow(wtimage1);title('Secret Image');
end
% stretched_truecolor1 = imadjust(wtimage1,stretchlim(wtimage1));
%figure
%imshow(stretched_truecolor1)
%title('Imadjust')
 cd ..
  title('Secret Image');
  helpdlg(' Secret Image Selected ');
  [S1,S2,S3,S4,S5,S6,S7,S8,S9,S10,S11,S12,S13,S14,S15,S16] = Color_Divide4_4(wtimage1);
 % S = {S1,S2,S3,S4,S5,S6,S7,S8,S9,S10,S11,S12,S13,S14,S15,S16};
  RMSE = sqrt(mse(wtimage1))
  handles.file = file;
  handles.wtimage1 = wtimage1;
  handles.waterbits1 = waterbits1;
  guidata(hObject,handles);
  


% --- Executes on button press in WaterMarkedImage.
function WaterMarkedImage_Callback(hObject, eventdata, handles)
% hObject    handle to WaterMarkedImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
input = handles.input;
waterbits1 = handles.waterbits1;

Inputimage1 = input;
original1 = Inputimage1;
target2 = Inputimage1;

% aaa = target1;
% Cover_Image_waterbits = aaa(:);
% F = Cover_Image_waterbits;
  F = waterbits1;
sz1 = size(Inputimage1);
size1 = sz1(1) * sz1(2);
sz2 = size(F);
size2 = sz2(1);

if size2 > size1 
    fprintf('\nImage File Size  %d\n',size1);
    fprintf('Text  File Size  %d\n',size2);
    disp('Text File is too Large');
else
    fprintf('\nImage File Size  %d\n',size1);
    fprintf('Text  File Size  %d\n',size2);
    disp('Text File is Small');

    i = 1;j = 1;k = 1;
    while k <= size2
        a = F(k);
        o1 = original1(i,j);
        o2 = original1(i,j+1);
        o3 = original1(i,j+2);
    
        [r1,r2,r3] = hidetext(o1,o2,o3,a); 
        
        target2(i,j) = r1;
        target2(i,j+1) = r2;
        target2(i,j+2) = r3;
        
        if i < sz1(1)
            i = i + 1;
        else
            i = 1;
            j = j + 1;
        end
        k = k + 1;
    end
    
    width1 = sz1(1);
    txtsz = size2;
    n = size(original1);
    A11 = fix(txtsz/256); % Quotient
    B11 = txtsz - A11 * 256; % Reminder
    
    target3 = target2;  %% 1st in 2nd & 3rd Image Embedding process

    save A11;save width1;save B11;
 
    imwrite(target3,'Stego_Image.bmp','bmp');
end

embedded1 = imread('Stego_Image.bmp');
axes(handles.axes4);
imshow(embedded1);
title('Embedded image'); 
helpdlg('Color Transformation Process Completed');

guidata(hObject,handles);

%Key = round(sqrt(mse(target3(:,:,1))))
% --- Executes on button press in StegnoImageInput.
function StegnoImageInput_Callback(hObject, eventdata, handles)
% hObject    handle to StegnoImageInput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% 
% [filename,pathname] = uigetfile('*.jpg;*.bmp;*.png','Pick an Image');
% if isequal(filename,0)||isequal(pathname,0)
%     warndlg('User Press Cancel');
% else
% filename = 'Cover_secret.bmp';
target4 = imread('Stego_Image.bmp');
axes(handles.axes2);
imshow(target4);
% end

title('Stego Image');
helpdlg('Stego Image is selected');
handles.target4 = target4;
guidata(hObject,handles);




% --- Executes on button press in RecoveredImage.
function RecoveredImage_Callback(hObject, eventdata, handles)
% hObject    handle to RecoveredImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
target4 = handles.target4;
 n=size(target4);
load A11;load width1;load B11;
% txtsz=double(target(n(1),n(2)+2)) + 256* double(target(n(1),n(2)));% Text Size
% width=target(n(1),n(2),2);% Image's Width
i = 1;j = 1;k = 1;

 while k <= txtsz
    r1 = target4(i,j);
    r2 = target4(i,j+1);
    r3 = target4(i,j+2);
    
    R(k)=findtext(r1,r2,r3);
    if i<width1
        i=i+1;
    else
        i=1;
        j=j+1;
    end
    k=k+1;
 end

target5 = reshape(R,[256,256,3]);
target5 = uint8(target5);
x = 1:1:100;
y = sqrt(mse(target5(:,:,1)));
figure,plot(x,y);xlabel('Pixel Intensities'); ylabel('RMSE');
axes(handles.axes4);
% axes(handles.axes6);
% axes(handles.axes2);
imshow(target5);
title('Recoverd Color Image');
% imwrite(target5,'retrieveCOLOR.bmp');
% fid = fopen('output.txt','wb');
% fid = imread()
% fwrite(fid,char(R),'char');
% fclose(fid);
 helpdlg('Image Extraction Process Completed');
 guidata(hObject,handles);
%figure, imshow(target5);title('Recovered Image');
%shadow = target5;
srgb2lab = makecform('srgb2lab');
lab2srgb = makecform('lab2srgb');

shadow_lab = applycform(target5, srgb2lab); % convert to L*a*b*

% the values of luminosity can span a range from 0 to 100; scale them
% to [0 1] range (appropriate for MATLAB(R) intensity images of class double) 
% before applying the three contrast enhancement techniques
max_luminosity = 100;
L = shadow_lab(:,:,1)/max_luminosity;

% replace the luminosity layer with the processed data and then convert
% the image back to the RGB colorspace
shadow_imadjust = shadow_lab;
shadow_imadjust(:,:,1) = imadjust(L)*max_luminosity;
shadow_imadjust = applycform(shadow_imadjust, lab2srgb);

shadow_histeq = shadow_lab;
shadow_histeq(:,:,1) = histeq(L)*max_luminosity;
shadow_histeq = applycform(shadow_histeq, lab2srgb);

shadow_adapthisteq = shadow_lab;
shadow_adapthisteq(:,:,1) = adapthisteq(L)*max_luminosity;
shadow_adapthisteq = applycform(shadow_adapthisteq, lab2srgb);



%stretched_truecolor = imadjust(wtimage1,stretchlim(wtimage1));
%figure
%imshow(stretched_truecolor)
%title('Imadjust')

%stretched_truecolor2 = adapthisteq(target5,stretchlim(target5));
%figure
%imshow(stretched_truecolor2)
%title('Adapthisteq')

%stretched_truecolor2 = histeq(target5,stretchlim(target5));
%figure
%imshow(stretched_truecolor2)
%title('Histeq')



%figure, imshow(shadow);
%title('Original');

%figure, imshow(shadow_imadjust);
%title('Imadjust');

%%

%figure, imshow(shadow_histeq);
%title('Histeq');

%figure, imshow(shadow_adapthisteq);
%title('Adapthisteq');

% --- Executes on button press in MosaicingImage.
function MosaicingImage_Callback(hObject, eventdata, handles)
% hObject    handle to MosaicingImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


handles.output = hObject;
ss = ones(256,256);
axes(handles.axes1);
imshow(ss);
axes(handles.axes2);
imshow(ss);
axes(handles.axes4);
imshow(ss);

[file,path] = uigetfile('*.jpeg;*.jpg;*.png;*.bmp','pick an image');
if isequal(file,0)||isequal(path,0)
    warndlg('user press cancel');
else
    target3 = imread(file);
    imshow(target3);
end
m = 1; n = 1;
b = double(rgb2gray(target3));
[r c]=size(b);

for i=1:8:r-7
    for j = 1:8:c-7
        block = b(i:i+7,j:j+7);
        dcblock(i:i+7,j:j+7) = dct2(block);
        LRAI(m,n) = dcblock(i,j);
        n = n+1;
    end
    m = m+1;
    n = 1;
end
axes(handles.axes4);
imshow(ss);
[r c] = size(LRAI);
axes(handles.axes1);
imshow (LRAI,[]);
title('Mosaicing Image');
helpdlg('Image Mosaicing Process Completed');

 guidata(hObject,handles);
 
% X = input(' Enter the key ');
%Key = round(sqrt(mse(target3(:,:,1))));
%   if (X = Key)
%   disp('Recovered Image is Authentic');
%   end
