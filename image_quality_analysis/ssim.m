clear all;
clc;

% Original Image
ref = rgb2gray(imread('lena.png'));

% Add noise 
noisy = imnoise(ref, 'salt & pepper', 0.2);

% in-built ssim function
ssim1 = ssim(noisy, ref);

% SSIM implementation

% constants
c1 = 1; c2 = 1;

% get reference image size
[M1 N1] = size(ref);
% calculate mean of the reference image
mean_ref = sum(ref(:))/(M1*N1);

% get noisy image size
[M2 N2] = size(noisy);
% calculate mean of the noisy image
mean_noisy = sum(noisy(:))/(M2*N2);;

% calculate standard deviation of the reference image
x = (ref-mean_ref) .^ 2;
std_dev_ref = sqrt(sum(x(:)) / ((M1*N1)-1));

% calculate standard deviation of the noisy image
y = (noisy-mean_noisy) .^ 2;
std_dev_noisy = sqrt(sum(y(:)) / ((M2*N2)-1));

% calculate cross-covariance for the images
ab = sum((ref(:)-mean_ref) .* (noisy(:)-mean_noisy));
a = sum((ref(:)-mean_ref) .^ 2 );
b = sum((noisy(:)-mean_noisy) .^ 2 );
cross_covar = ab/sqrt((a*b));

% calculate ssim
n1 = (2*mean_ref*mean_noisy) + c1;
n2 = (2*cross_covar) + c2;
d1 = (mean_ref)^2 + (mean_noisy)^2 + c1;
d2 = (std_dev_ref)^2 + (std_dev_noisy)^2 + c2;

ssim = (n1*n2)/(d1*d2);

figure; imshow(ref); title("Original Image");
figure; imshow(noisy); title("Noisy Image");

fprintf('\n The Structural Similarity (SSIM) Index quality assessment index is %0.4f\n', ssim);




