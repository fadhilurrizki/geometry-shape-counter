function hasil=std_skew(img,mean,x)
[h w]=size(img)
jumlah=0;
for i=1:h
    for j=1:w
        jumlah=jumlah+((img(i,j)-mean)^x);
    end
end
hasil=(jumlah/(h*w))^(1/x);
end