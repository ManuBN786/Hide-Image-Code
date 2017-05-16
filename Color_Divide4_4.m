% Divide image into 4*4
function [image1,image2,image3,image4,image5,image6,image7,image8,image9,image10,image11,image12,image13,image14,image15,image16] = Color_Divide4_4(Remove_minima)

[rows, columns, numberOfColorChannels] = size(Remove_minima);
      r4 = int32(rows/4);
      c4 = int32(columns/4);
      
      image1 = Remove_minima(1:r4, 1:c4, :);
      image2 = Remove_minima(1:r4, c4+1:2*c4, :);
      image3 = Remove_minima(1:r4, 2*c4+1:3*c4);
      image4 = Remove_minima(1:r4, 3*c4+1:4*c4);
      
      image5 = Remove_minima(r4+1:2*r4, 1:c4, :);
      image6 = Remove_minima(r4+1:2*r4, c4+1:2*c4, :);
      image7 = Remove_minima(r4+1:2*r4, 2*c4+1:3*c4, :);
      image8 = Remove_minima(r4+1:2*r4, 3*c4+1:4*c4, :);
      
      image9 = Remove_minima(2*r4+1:3*r4, 1:c4, :);
      image10 = Remove_minima(2*r4+1:3*r4, c4+1:2*c4, :);
      image11 = Remove_minima(2*r4+1:3*r4, 2*c4+1:3*c4, :);
      image12 = Remove_minima(2*r4+1:3*r4, 3*c4+1:4*c4, :);
      
      image13 = Remove_minima(3*r4+1:end, 1:c4, :);
      image14 = Remove_minima(3*r4+1:end, c4+1:2*c4, :);
      image15 = Remove_minima(3*r4+1:end, 2*c4+1:3*c4, :);
      image16 = Remove_minima(3*r4+1:end, 3*c4+1:4*c4, :);
      
      figure,subplot(4,4,1);imshow(image1);title('1');
      subplot(4,4,2);imshow(image2);title('2');
      subplot(4,4,3);imshow(image3);title('3');
      subplot(4,4,4);imshow(image4);title('4');
      subplot(4,4,5);imshow(image5);title('5');
      subplot(4,4,6);imshow(image6);title('6');
      subplot(4,4,7);imshow(image7);title('7');
      subplot(4,4,8);imshow(image8);title('8');
      subplot(4,4,9);imshow(image9);title('9');
      subplot(4,4,10);imshow(image10);title('10');
      subplot(4,4,11);imshow(image11);title('11');
      subplot(4,4,12);imshow(image12);title('12');
      subplot(4,4,13);imshow(image13);title('13');
      subplot(4,4,14);imshow(image14);title('14');
      subplot(4,4,15);imshow(image15);title('15');
      subplot(4,4,16);imshow(image16);title('16');