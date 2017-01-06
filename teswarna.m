I =imread('testing1.png');
subplot(1,2,1); imshow(I);
Igray= rgb2gray(I);
subplot(1,2,2); imshow(Igray);

% ngubah semua gambar ke bw, tapi ga semua
% cara 1
Ibw= im2bw(Igray, 0.9);  %0.9 itu threshold
subplot(1,2,2); imshow(Igray);

% % cara 2
% Ibw = double(Igray);
% id = find(Igray<230);
% Ibw(id)=0;
% id = find(Igray>=230);
% Ibw(id)=1;
% subplot(1,2,3); imshow(Igray);

J = ~Ibw;
stats = regionprops(J, 'BoundingBox');
for i=1:size(stats,1)
	figure(i+1);
	box=stats(i).BoundingBox;
	Icrop = double(imcrop(I,box));
	% cari nilai mean
	CM_mean = mean(Icrop);
	% cari nilai standar deviasi
	CM_std = std2(Icrop);
	% cari skewness
	CM_skew = skewness(Icrop(:));
	imshow(uint8(Icrop));
end