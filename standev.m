function hasil=standev(img,mean)
[h w]=size(img)
jumlah=0;
for i=1:h
    for j=1:w
        jumlah=jumlah+((img(i,j)-mean)^2);
    end
end
hasil=(jumlah/(h*w))^(1/2);
end