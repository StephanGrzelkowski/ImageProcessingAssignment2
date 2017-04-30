function e = canny(image,sigma)
%calculate gaussian derivates of the images of different orders: 

Gx = gD(image,sigma,1,0); 
Gy = gD(image,sigma,0,1);
Gxx = gD(image,sigma,2,0); 
Gyy = gD(image,sigma,0,2); 
Gxy = gD(image,sigma,1,1); 

%calculate gradient vectors fw and fww
fw = sqrt(Gx.^2 + Gy.^2); 
fww =  (Gx.^2).*Gxx + 2.*Gx.*Gy.*Gxy + (Gy.^2).*Gyy;
fww = (1./(Gx.^2 + Gy.^2)).*fww; % normalize


e = zeros(size(image)); 
for i = 1 : size(image,1)
    for j = 1 : size(image,2)
        if checkZero(fww,i,j) == 1
            e(i,j) = fw(i,j);
        end
    end
end

end