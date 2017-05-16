function out = binary_vector(in)
% This code converts unsigned integer number into Binary vector.
% It is used in this project for conversion into binary numbers of 8-bit unsigned pixel values, 
% row, column and color information and also the number of images.
%
% Syntax:
% binary_vector(unsigned_integer_number)
%
% Example:
%
% >> binary_vector(234)
% 
% ans =
% 
%      0
%      1
%      0
%      1
%      0
%      1
%      1
%      1

out=zeros(8,1);
if ~in
    return;
else
    while(1)
        out(floor(log2(in))+1)=1;
        in= in - power(2,floor(log2(in)));
        if ~in
            break;end
    end
end