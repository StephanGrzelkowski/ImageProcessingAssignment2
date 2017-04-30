%implemented the Gauss function in calcGaussian with M = 3 and N = 3
%creating a local neighborhood of 5x5. We chose this range so we have a 
%% 
% calculate the sum for different sigma
% we expect 
S = 1; 
G = calcGaussian(S);
sumG = sum(sum(G));
%2.461

% sigma 2
S = 2; 
G = calcGaussian(S);
sumG = sum(sum(G));
%3.156

%% sigma correction 
% to fix this integral problem we added the normalization line to the end
% of the function. G = G./sum(sum(G));
figure; 
mesh(calcGaussian(1))

%% physical unit of scale
% sigma gives the steepness of the bell curve. With higher sigma the points
% further away from our sampling point get measured heavier

%% plot of elaped time
%the elapsed time figure for increasing scale
F = imread('cameraman.tif');
elapsedTime = zeros(20,20);
samplingSigma = 1 : 40; 
for j = 1 : 20
    for i = samplingSigma
        tic;
            H = imfilter (F, calcGaussian(i), 'conv', 'replicate');
            elapsedTime(j,i) = toc; 
    end
end

figure; 
plot(samplingSigma, mean(elapsedTime))

%% order of compuational complexity
%The complexity of the algorithm is O(n^2) where n is sigma

%% 
elapsed2 = zeros(1,20);
elapsed3 = zeros(1,20);
for i = 1:20 
    tic; 
    H = imfilter (F, calcGaussian(4), 'conv', 'replicate');
    H = imfilter (H, calcGaussian(4), 'conv', 'replicate');
    elapsed2(i) = toc;
end
for i = 1:20 
    tic
    H = imfilter (H, calcGaussian(16), 'conv', 'replicate');
    elapsed3(i) = toc; 
end
figure; 
plot([1 2], [mean(elapsed2), mean(elapsed3)])
ylim([0,max(elapsed3) + 0.001])
xlim([0, 2.5])
ylabel('elapsed time')

% the time it takes to do a double blurring with sigma is not the same as
% the time it takes to do the convolution using sigma^2
%% Gauss1 implementation
%see  Gauss1.m
%% 2D  gauss convolution using Gauss1

F = imread('cameraman.tif');
elapsedTime = zeros(20,20);
samplingSigma = 1 : 20; 
for j = 1 : 20
    for i = samplingSigma
        tic;
            H = imfilter (F, Gauss1(i), 'conv', 'replicate');
            H = imfilter (H, Gauss1(i)', 'conv', 'replicate');
            elapsedTime(j,i) = toc; 
    end
end


figure; 
plot(samplingSigma, mean(elapsedTime))

%computational complexity is linear: O(2sigma)

%% gD
%calculate gaussian
f = im2double(imread('cameraman.tif'));
F = gD(f,1,1,1);
imshow(F,[min(min(F)), max(max(F))])
%%
f = im2double(imread('cameraman.tif'));
F = gD(f,1,2,2  );
imshow(F,[min(min(F)), max(max(F))])


