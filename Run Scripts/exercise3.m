clear all  
close all

%% start exercise 3
x = -100:100;
y = -100:100;
[X, Y] = meshgrid (x, y);
A = 1; B = 2; V = 6* pi /201; W = 4* pi /201;
F = A * sin(V*X) + B * cos(W*Y);
imshow (F, [], 'xData', x, 'yData', y);
title('Sine and cosine forms')


%% Partial direvatives: 
% the partial derivatives ignore the term with the not analyzed variable as
% a constant. The sin term then becomes cos with the constant(V & W) multiplied
% on the outside, and the cos becomes -sin
% fx = A*V*cos(Vx)
% fy = -B*W*sin(Wy)
% fxx = -A*V^2*sin(Vx)
% fyy = -B*W^2*cos(Wy)

%% implementation of first Partial derivatives 
Fx = A*V*cos(V*X);
Fy = -B*W*sin(W*Y);
figure; 
subplot(121)
imshow (Fx, [], 'xData', x, 'yData', y);
title('Partial Derivative in  x direction')

subplot(122)
imshow(Fy, [], 'xData',y,'yData',y); 
title('Partial Derivative in  y direction')

%% Plot for combined derivative with vector 

xx = -100:10:100;
yy = -100:10:100;
[XX , YY] = meshgrid(xx, yy);
Fx = A*V*cos(V*XX);
Fy = -B*W*sin(W*YY);
figure; 
imshow (F,[],'xData',x,'yData',y);
hold on;
quiver (xx,yy,Fx,Fy,'r');
hold off ;
title('Gradient vector overlayed image')
%% Use gaussian filter on partial derivatives 


Gx = gD(F,1,1,0);  %first order gaussian in x
Gy = gD(F,1,0,1);  %first order gaussian in y


XXG = 1 : 10 : size(Gx,1); 
YYG = 1 : 10 : size(Gy,2); 
Gxs = zeros(length(XXG),length(YYG));
Gys = zeros(length(XXG),length(YYG));
for i = 1 :  length(XX)
    for j = 1 : length(YY)
        Gxs(i,j) = Gx(XXG(i),XXG(j)); 
        Gys(i,j) = Gy(YYG(i),YYG(j)); 
    end
end


figure; 
imshow (F,[],'xData',x,'yData',y);
axis on
hold on;
quiver(xx,yy,Gxs,Gys,'r');
hold off ;
title('Gradient vector overlayed image with gaussian filter')
%% First rotate the image then do Filtering 

%put rotate image in the current folder 
Fr = rotateImage(F, 10, 'linear','basic'); % give negative values which problems with displaying 
%crop image
Fr = Fr(17 : (end - 16), 17 : (end-16));

GxR = gD(Fr,1,1,0); 
GyR = gD(Fr,1,0,1);

GxsR = zeros(length(XXG),length(YYG));
GysR = zeros(length(XXG),length(YYG));
for i = 1 :  length(XX)
    for j = 1 : length(YY)
        GxsR(i,j) = GxR(XXG(i),XXG(j)); 
        GysR(i,j) = GyR(YYG(i),YYG(j)); 
    end
end

figure; 
imshow (Fr,[],'xData',x,'yData',y);
axis on
hold on;
quiver(xx,yy,GxsR,GysR,5,'r');
hold off ;
title('Gradient vector overlayed for rotated image')
%note that the edges to the basic border filling have very high gradient
%vectors as is expected


%% Gradient direction w
%fw = sqrt(Fx^2 + Fy^2)
%fww = Fx^2* Fxx+ 2Fx*Fy*Fxy + Fy^2 * Fyy

%calculate all the derivates needed for fw and fww of our F:
Gx = gD(F,1,1,0); 
Gy = gD(F,1,0,1);
Gxx = gD(F,1,2,0); 
Gyy = gD(F,1,0,2); 
Gxy = gD(F,1,1,1); 

fw = sqrt(Gx.^2 + Gy.^2); 
fww = (Gx.^2).*Gxx + 2.*Gx.*Gy.*Gxy + (Gy.^2).*Gyy;

%% Canny edge detector 
%see implementation in canny.m and checkZero.m (Helper Scripts folder)

%% test canny on cameraman 

F = im2double(imread('cameraman.tif'));
e = canny(F,1);

figure; 
imshow(e) 

% Dit werkt niet. We weten waar het probleem ligt maar niet hoe we het
% moeten oplossen. De gaussian derivatives in een richting in de canny
% functie werken wel goed. Maar de twede derivatives niet. En we krijgen
% ook goede beelden voor fw en fww maar in de twede afgeleides zijn alle
% waardes positief dus er is geen nul doorgang te vinden. Onder figure map
% heb ik fww nog gecopierd die dus wel degelijk de edges aangeeft van
% cameraman.tif



