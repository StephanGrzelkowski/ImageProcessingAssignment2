function F = gD(f,sigma,xorder,yorder)
G = Gauss1(sigma); 
   
switch xorder
    case 0 
        Gx = G;
    case 1
        x = -3*sigma : 3*sigma;
        Gx = (-x./sigma^2).*G;
    case 2
        x = -3*sigma : 3*sigma;
        Gx = (x.^2/sigma^4) - 1/(sigma^2).*G;
end
        
      
switch yorder
    case 0 
        Gy = G;
    case 1
        y = -3*sigma : 3*sigma;
        Gy = (-y./sigma^2).*G;
    case 2
        y = -3*sigma : 3*sigma;
        Gy = (y.^2/sigma^4) - 1/(sigma^2).*G;
end
        
F = imfilter(f, Gx, 'conv', 'replicate');
F = imfilter(F, Gy', 'conv', 'replicate');
end