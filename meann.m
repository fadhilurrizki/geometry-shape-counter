function hasil = meann(img)
[h w] = size(img);
%mencari nilai mean dari B
jumlah=0;
for i=1:h
    for j=1:w
        jumlah=jumlah+img(i,j);
    end
end
hasil=jumlah/(h*w);
end