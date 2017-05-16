clc;
clear all;
close all;

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
    figure
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


cd 'Images'
%% watermark Image
[file,path] = uigetfile('*.png;*.jpg;*.bmp;','Pick an Image File');
if isequal(file,0) || isequal(path,0)
    warndlg('User Pressed Cancel');
else
    wimage1 = imread(file);
    wtimage1=imresize(wimage1,[256 256]);
    figure;
    
    imshow(wtimage1);
    waterbits1 = wtimage1(:);
  
end
 cd ..
  title('Watermarking Color Image');
  helpdlg('Watermarking Color Image');
  
  %%  Embedding Image  %%

  
  Inputimage1 = input;
original1 = Inputimage1;
target2 = Inputimage1;

% aaa = target1;
% Cover_Image_waterbits = aaa(:);
% F = Cover_Image_waterbits;
  F = wtimage1(:);
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
% figure;
figure;
imshow(embedded1);
title('embedded image');  
%% 
[filename,pathname] = uigetfile('*.jpg;*.bmp;*.png','Pick an Image');
if isequal(filename,0)||isequal(pathname,0)
    warndlg('User Press Cancel');
else
% filename = 'Cover_secret.bmp';
target4 = imread(filename);
% axes(handles.axes1);
imshow(target4);
end
  
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
figure;
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
 
 
 
 


%% MSE PSNR

[M N W] = size (wtimage1);
inputimage=uint8(wtimage1);
outputimage=uint8(target5);
%%%%%%%%%%%%%%%%%%%%MSE%%%%%%%%%%%
MSE=(sum(sum((inputimage-outputimage).^2))/(M*N))/2;
d isp(MSE);
%%%%%%%%%%%%%%%%%%PSNR%%%%%%%%%%%
PSNR = 10*log10(255*255/MSE);
disp(PSNR);