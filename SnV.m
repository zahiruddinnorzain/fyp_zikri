clear all;
clc

i = imread('test22.jpg');
hsv = rgb2hsv(i);
h = hsv(:, :, 1); % Hue image.
s = hsv(:, :, 2); % Saturation image.
v = hsv(:, :, 3); % Value (intensity) image.
M = fspecial('laplacian',0.3);
v1 = imfilter(v,M);
v2 = imsubtract(v,v1);
s1 = imfilter(s,M);
s2 =  imsubtract(s,s1);
hsv2= cat(3,h,s2,v2);
ime = hsv2rgb(hsv2);
subplot(2,2,1); imshow(i); title('original');
subplot(2,2,2); imhist(i);
subplot(2,2,3); imshow(ime); title('HSV2RGB(SnV value)');
subplot(2,2,4); imhist(ime);

% Read the dimensions of the image.
[rows columns ~] = size(i);

% Calculate mean square error of R, G, B.   
mseRImage = (double(i) - double(ime)) .^ 2;
mseGImage = (double(i) - double(ime)) .^ 2;
mseBImage = (double(i) - double(ime)) .^ 2;

mseR = sum(sum(mseRImage)) / (rows * columns);
mseG = sum(sum(mseGImage)) / (rows * columns);
mseB = sum(sum(mseBImage)) / (rows * columns);

% A(:,:,1) would mean all rows and all columns in the first image plane - in other words, the red channel of the image.

% Average mean square error of R, G, B. mse -> (x,y) = sum(V(i,j) - V)^2
mse = (mseR + mseG + mseB)/3; 

% Calculate PSNR (Peak Signal to noise ratio).
PSNR_Value = 10 * log10( 255^2 / mse);

entrop = entropy (ime);



