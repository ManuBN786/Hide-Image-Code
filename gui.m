function varargout = gui(varargin)
% GUI MATLAB code for gui.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui

% Last Modified by GUIDE v2.5 02-Dec-2014 17:32:08

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_OutputFcn, ...
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


% --- Executes just before gui is made visible.
function gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui (see VARARGIN)

% Choose default command line output for gui
handles.output = hObject;

ss = ones(256,256);
axes(handles.axes1);
imshow(ss);
axes(handles.axes2);
imshow(ss);
axes(handles.axes3);
imshow(ss);
axes(handles.axes4);
imshow(ss);
axes(handles.axes5);
imshow(ss);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Inputimage.
function Inputimage_Callback(hObject, eventdata, handles)
% hObject    handle to Inputimage (see GCBO)
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
cd ..
helpdlg('Input Image is Selected');
handles.FileName = FileName;
handles.input = input;
guidata(hObject,handles);


% --- Executes on button press in watermarkImage.
function watermarkImage_Callback(hObject, eventdata, handles)
% hObject    handle to watermarkImage (see GCBO)
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
%     figure;
    axes(handles.axes2);
    imshow(wtimage1);
    waterbits1 = wtimage1(:);
  
end
 cd ..
  title('Watermarking Color Image');
  helpdlg('Watermarking Color Image');
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
axes(handles.axes3);
imshow(embedded1);
title('embedded image');  

guidata(hObject,handles);


% --- Executes on button press in RecoverImage.
function RecoverImage_Callback(hObject, eventdata, handles)
% hObject    handle to RecoverImage (see GCBO)
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
axes(handles.axes5);
% axes(handles.axes6);
% axes(handles.axes2);
imshow(target5);
title('Recover Color Image');
% imwrite(target5,'retrieveCOLOR.bmp');
% fid = fopen('output.txt','wb');
% fid = imread()
% fwrite(fid,char(R),'char');
% fclose(fid);
 helpdlg('Color Image Extraction Process Completed');
 guidata(hObject,handles);

% --- Executes on button press in Clear.
function Clear_Callback(hObject, eventdata, handles)
% hObject    handle to Clear (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


c = ones(256,256);
axes(handles.axes1);
imshow(c);
axes(handles.axes2);
imshow(c);
axes(handles.axes3);
imshow(c);
axes(handles.axes4);
imshow(c);
axes(handles.axes5);
imshow(c);


set(handles.edit1,'string','');
set(handles.edit2,'string','');
guidata(hObject,handles);


% --- Executes on button press in validate.
function validate_Callback(hObject, eventdata, handles)
% hObject    handle to validate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

wtimage2=handles.wtimage2;
target7=handles.target7;
inputimage = wtimage2;
outputimage = target7;
[M N]=size(outputimage);
inputimage=uint8(inputimage);
outputimage=uint8(outputimage);
%%%%%%%%%%%%%%%%%%%%MSE%%%%%%%%%%%
MSE=(sum(sum((inputimage-outputimage).^2))/(M*N))/2;
set(handles.edit1,'string',MSE);
%%%%%%%%%%%%%%%%%%PSNR%%%%%%%%%%%
PSNR = 10*log10(255*255/MSE);
set(handles.edit2,'string',PSNR);
guidata(hObject,handles);



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in RXinput.
function RXinput_Callback(hObject, eventdata, handles)
% hObject    handle to RXinput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[filename,pathname] = uigetfile('*.jpg;*.bmp;*.png','Pick an Image');
if isequal(filename,0)||isequal(pathname,0)
    warndlg('User Press Cancel');
else
% filename = 'Cover_secret.bmp';
target4 = imread(filename);
axes(handles.axes4);
imshow(target4);
end

title('Stego Image');
helpdlg('Stego Image is selected');
handles.target4 = target4;
guidata(hObject,handles);


% --- Executes on button press in Close.
function Close_Callback(hObject, eventdata, handles)
% hObject    handle to Close (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close all;
