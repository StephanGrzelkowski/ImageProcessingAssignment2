function rotatedImage = rotateImage ( image , angle , method, border )
%rotation matrix
angleMod = deg2rad(mod(angle,90));
angle = deg2rad(angle);


% calculate the added length of rotations
%Calculate diagonal 
N = sin(angleMod) * size(image,1) + cos(angleMod) * size(image,2); 
M = sin(angleMod) * size(image,2) + cos(angleMod) * size(image,1);  


exRows = ceil(abs((M - size(image,1))/2)); 
exColumns = ceil(abs((N - size(image,2))/2)); 


prependColumns = zeros(size(image,1), exColumns); 
image = [prependColumns, image, prependColumns]; 


prependRows = zeros(exRows, size(image,2)); 
image = [prependRows; image; prependRows]; 



%image = prependedImage; 
x_vec = 1 : size(image,1);
y_vec = 1 : size(image,2);

x_mat = repmat(x_vec,size(image,2),1);
x_mat = reshape(x_mat,[1,size(image,2)*size(image,1)]);

y_mat = repmat(y_vec, 1,size(image,1));
coord = [x_mat; y_mat; ones(1,size(image,2)*size(image,1))];
R_affine = [cos(angle), sin(angle), size(image,1)/2; ...
            -sin(angle), cos(angle),  size(image,2)/2;...
            0,          0,           1]; 
T = [1, 0, -size(image,1)/2; 
    0, 1, -size(image,2)/2; 
    0, 0, 1]; 

R_affine = R_affine * T; 
new_coord = R_affine*coord;

for i = 1 : size(new_coord,2)
    x = new_coord(1,i); 
    y = new_coord(2,i); 
   
    rotatedImage(coord(1,i), coord(2,i)) = pixelValue(image,x,y,method,border);


end

end