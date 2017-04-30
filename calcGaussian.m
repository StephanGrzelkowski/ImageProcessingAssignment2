function G = calcGaussian(S)
M = 3*S; 
N = 3*S; 
% create appropriate ranges for x and y
x = -M:M;
y = -N:N;
% create a sampling grid
[X, Y] = meshgrid (x, y);
% determine the scale
sigma = S;



% calculate the Gaussian function

G = 1/(sqrt(2*pi) * sigma).* exp(-((sqrt(X.^2 + Y.^2)).^2 / (2*sigma^2)));
G= G./sum(sum(G));
end