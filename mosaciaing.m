clc;
close all;
clear all;

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
[r c] = size(LRAI);
figure;
imshow (LRAI,[]);
col = c/3;

for i = 1:r
    for j = 1:col
        
        img(i,j) = LRAI(i,j);
    end
end
figure
imshow(img);
col1 = col+1;
col2 = 2*col;
for i = 1:r
    for j = col1:col2
        
        img1(i,j) = LRAI(i,j);
    end
end