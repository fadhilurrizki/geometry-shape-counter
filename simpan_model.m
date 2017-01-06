I = imread('kotak.png');
Ibw = im2bw(I);
s = regionprops(~Ibw,'Image');
a=s(1).Image;
M = momentinvariant(a);
%M = segmentasimodel(Ibw);
save('segiempat.mat','M');

I = imread('segitiga.png');
Ibw = im2bw(I);
s = regionprops(~Ibw,'Image');
a=s(1).Image;
M = momentinvariant(a);
%M = segmentasimodel(Ibw);
save('segitiga.mat','M');

I = imread('lingkaran.png');
Ibw = im2bw(I);
s = regionprops(~Ibw,'Image');
a=s(1).Image;
M = momentinvariant(a);
%M = segmentasimodel(Ibw);
save('lingkaran.mat','M');

I = imread('segilima.png');
Ibw = im2bw(I);
s = regionprops(~Ibw,'Image');
a=s(1).Image;
M = momentinvariant(a);
%M = segmentasimodel(Ibw);
save('segilima.mat','M');

I = imread('bintang.png');
Ibw = im2bw(I);
s = regionprops(~Ibw,'Image');
a=s(1).Image;
M = momentinvariant(a);
%M = segmentasimodel(Ibw);
save('bintang.mat','M');

