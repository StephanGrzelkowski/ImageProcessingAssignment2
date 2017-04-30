function G = Gauss1(S) 
M = 3*S; 

% create appropriate ranges for x and y
x = -M:M;
% create a sampling grid

% determine the scale
sigma = S;

% calculate the Gaussian function

G = 1/(sqrt(2*pi) * sigma).* exp(-(x.^2 / (2*sigma^2)));
   
        
G= G./sum(sum(G));
end