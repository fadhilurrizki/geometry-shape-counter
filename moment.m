function hasil = moment(I,p,q,a,b)

[m,n] = size(I);
hasil = 0;
for i = 1 : n
    for j = 1 : m
            hasil = (hasil +(i-a)^p*(j-b)^q*I(j,i));
    end
end
