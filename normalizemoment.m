function hasil = normalizemoment(I,p,q,a,b)
    y = ((p+q)/2)+1;
    hasil = moment(I,p,q,a,b)/(moment(I,0,0,a,b))^y;
