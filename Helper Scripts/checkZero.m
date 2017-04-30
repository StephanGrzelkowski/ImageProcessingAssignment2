function bol = checkZero(f,i,j)
sizeX = size(f,1); 
sizeY = size(f,2); 
%ignore border cases
if i ~= 1 && j ~= 1 && i ~= sizeX && j ~= sizeY
    %check sides 
    if (sign(f(i-1,j-1))  + sign(f(i+1,j+1))) == 0 
        bol = 1;
    elseif (sign(f(i,j-1))  + sign(f(i,j+1))) == 0
        bol = 1;
    elseif (sign(f(i-1,j))  + sign(f(i+1,j))) == 0
        bol = 1;
    elseif (sign(f(i-1,j+1))  + sign(f(i+1,j-1))) == 0
        bol = 1;
    elseif f(i,j) == 0
        bol = 1;
    else 
        bol = 0;
    end
else
    bol = 0;
end


end