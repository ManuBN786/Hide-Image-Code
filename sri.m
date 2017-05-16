clc;
clear all;
close all;
%% Cover Image
cd 'Images'
[FileName,PathName] = uigetfile('*.jpg;*.png;*.bmp','Pick an image');
if isequal(FileName,0)||isequal(PathName,0)
    warndlg('User Press Cancel');
else

    a = imread(FileName);
    input =imresize(a,[512 512]);  
    [r,c,p] = size(a);
%     save p;
%     if p==3 
%     R=input(:,:,1);
%     G=input(:,:,2);
%     B=input(:,:,3);
    figure; 
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

% 
%% watermarked Image1
cd 'Images'
[file,path] = uigetfile('*.png;*.jpg','Pick an Image File');
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
  
  %% watermarked Image2
  cd 'Images'
[file1,path1] = uigetfile('*.bmp;*.png;*.jpg','Pick an Image File');
if isequal(file1,0) || isequal(path1,0)
    warndlg('User Pressed Cancel');
else
    wimage2 = imread(file1);
%     wtimage2=imresize(wimage2,[256 256]);
  wtimage2=rgb2gray(imresize(wimage2,[128 128]));
    figure;
    imshow(wtimage2);
    waterbits2 = wtimage2(:);
end
cd ..
title('Watermarking BW Image');



%%  image_Embedding

%% 2nd in 3rd Image Embedding process
% filename = handles.filename;
% Inputimage = imread(filename);
Inputimage = wtimage1;            %% 2nd Image
original = Inputimage;
target = Inputimage;


F = waterbits2;                   %% 3rd Image Bit's value

sz1 = size(Inputimage);
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
        o1 = original(i,j);
        o2 = original(i,j+1);
        o3 = original(i,j+2);
    
        [r1,r2,r3] = hidetext(o1,o2,o3,a); 
        
        target(i,j) = r1;
        target(i,j+1) = r2;
        target(i,j+2) = r3;
        
        if i < sz1(1)
            i = i + 1;
        else
            i = 1;
            j = j + 1;
        end
        k = k + 1;
    end
    
    width = sz1(1);
    txtsz = size2;
    n = size(original);
    A1 = fix(txtsz/256); % Quotient
    B1 = txtsz - A1 * 256; % Reminder
    
    target1 = target;         %% 2nd in 3rd Image Embedding process
%     target1(n(1),n(2)) = A1;
%     target1(n(1),n(2)+1) = width;% Image's Width
%     target1(n(1),n(2)+2) = B1;
    save A1;save width;save B1;
    
    %save secret.mat target;% txtsz width;
    imwrite(target1,'secret.bmp','bmp');
end

embedded = imread('secret.bmp');
figure;
imshow(embedded);
title('2nd in 3rd Image Embedding process completed');

helpdlg('2nd in 3rd Image Embedding process completed');
%%  1st in 2nd & 3rd Image Embedding process

Inputimage = input;
original = Inputimage;
target = Inputimage;

aaa = imread('secret.bmp');
Cover_Image_waterbits = aaa(:);
F = Cover_Image_waterbits;

sz1 = size(Inputimage);
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
        o1 = original(i,j);
        o2 = original(i,j+1);
        o3 = original(i,j+2);
    
        [r1,r2,r3] = hidetext(o1,o2,o3,a); 
        
        target(i,j) = r1;
        target(i,j+1) = r2;
        target(i,j+2) = r3;
        
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
    n = size(original);
    A11 = fix(txtsz/256); % Quotient
    B11 = txtsz - A1 * 256; % Reminder
    
    target2 = target;  %% 1st in 2nd & 3rd Image Embedding process

    save A11;save width1;save B11;
 
    imwrite(target2,'Cover_secret.bmp','bmp');
end

embedded1 = imread('Cover_secret.bmp');
figure;
imshow(embedded1);
title('1st in 2nd & 3rd Image Embedding process completed');
helpdlg('1st in 2nd & 3rd Image Embedding process completed');


%% Extraction Process
%% 2nd & 3rd in 1st Image  Extraction Process
filename = 'Cover_secret.bmp';
target = imread(filename);
% target=Stg_Img;
n=size(target2);
load A11;load width1;load B11;
% txtsz=double(target(n(1),n(2)+2)) + 256* double(target(n(1),n(2)));% Text Size
% width=target(n(1),n(2),2);% Image's Width
i = 1;j = 1;k = 1;

 while k <= txtsz
    r1 = target(i,j);
    r2 = target(i,j+1);
    r3 = target(i,j+2);
    
    R(k)=findtext(r1,r2,r3);
    if i<width
        i=i+1;
    else
        i=1;
        j=j+1;
    end
    k=k+1;
 end

target3 = reshape(R,[256,256,3]);
target3 = uint8(target3);
figure;
imshow(target3);
title('Recover Color Image');
imwrite(target3,'retrieveCOLOR.bmp');
% fid = fopen('output.txt','wb');
% fid = imread()
% fwrite(fid,char(R),'char');
% fclose(fid);
%  helpdlg('Extraction Process Completed');




%% 3rd in 2nd Image  Extraction Process
filename = 'retrieveCOLOR.bmp';
target3 = imread(filename);
% target=Stg_Img;
n=size(target3);
load A1;load width;load B1;
% txtsz=double(target(n(1),n(2)+2)) + 256* double(target(n(1),n(2)));% Text Size
% width=target(n(1),n(2),2);% Image's Width
i = 1;j = 1;k = 1;

 while k <= txtsz
    r1 = target(i,j);
    r2 = target(i,j+1);
    r3 = target(i,j+2);
    
    R1(k)=findtext(r1,r2,r3);
    if i<width
        i=i+1;
    else
        i=1;
        j=j+1;
    end
    k=k+1;
 end

target4 = reshape(R1,[128,128]);
target4 = uint8(target4);
figure;
imshow(target4);
title('Recover BW Image');
imwrite(target4,'retrieveBW.bmp');
% fid = fopen('output.txt','wb');
% fid = imread()
% fwrite(fid,char(R),'char');
% fclose(fid);
 helpdlg('Extraction Process Completed');





