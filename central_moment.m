function hasil = central_moment( I,xc,yc,p,q )

[x,y] = size(I);
hasil=0;
for i=1:y
    for j=1:x
        hasil=hasil+(i-xc)^p*(j-yc)^q*I(j,i);
    end
end