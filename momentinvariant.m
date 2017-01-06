function hasil = momentinvariant(Ibw)


%mencari nilai moment
m00 = moment(Ibw,0,0,0,0);
m10 = moment(Ibw,1,0,0,0);
m01 = moment(Ibw,0,1,0,0);

%mencari titik tengah
xc = round(m10/m00);
yc = round(m01/m00);

%mencari nilai normalize moment

n02 = normalizemoment(Ibw,0,2,xc,yc);
n03 = normalizemoment(Ibw,0,3,xc,yc);
n11 = normalizemoment(Ibw,1,1,xc,yc);
n12 = normalizemoment(Ibw,1,2,xc,yc);
n20 = normalizemoment(Ibw,2,0,xc,yc);
n21 = normalizemoment(Ibw,2,1,xc,yc);
n30 = normalizemoment(Ibw,3,0,xc,yc);

%mencari nilai moment invariant
M1=n20+n02;
M2=(n20-n02)^2+4*n11^2;
M3=(n30-3*n12)^2+(3*n21-n03)^2;
M4=(n30+n12)^2+(n21+n03)^2;
M5=(n30-3*n12)*(n30+n12)+((n30+n12)^2-3*(n21-n03)^2)+(3*n21-n03)*(n21+n03)*(3*(n30+n12)^2-(n21+n03)^2);
M6=(n20-n02)*((n30+n12)^2-(n21+n03)^2)+4*n11*(n30+n12)*(n21+n03);
M7=(3*n21-n03)*(n30+n12)*((n30+n12)^2-3*(n21+n03)^2)+(3*n12-n30)*(n21+n03)*(3*(n12+n30)^2-(n21+n03)^2);
hasil = [M1,M2,M3,M4,M5,M6,M7];
%disp(hasil);
