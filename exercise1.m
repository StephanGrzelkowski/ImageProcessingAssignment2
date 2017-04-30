F = imread('cameraman.tif');
%motion blur 
G = 0.2.* [1 1 1 1 1]
    
Hmotion = imfilter(F,G,'conv','replicate'); 

G = 3; 
Hscale = imfilter(F,G,'conv','replicate'); 

G  = [1, 0, 0, 0; 0, 0, 0, 0]; 
Htranslate = imfilter(F,G,'conv','replicate');

figure; 
subplot(141)
imshow(F)
title('Original')
subplot(142)
imshow(Hmotion)
title('Motion blur')
subplot(143) 
imshow(Hscale)
title('Image intensity scale')
subplot(144)
imshow(Htranslate)
title('TranslatedImage')
