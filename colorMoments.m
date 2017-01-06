function cm = colorMoments(img)
R=double(img(:,:,1));
G=double(img(:,:,2));
B=double(img(:,:,3));
meanR=meann(R);
stdR=std_skew(R,meanR,2);
skewR=std_skew(R,meanR,3);
meanG=meann(G);
stdG=std_skew(G,meanG,2);
skewG=std_skew(G,meanG,3);
meanB=meann(B);
stdB=std_skew(B,meanB,2);
skewB=std_skew(B,meanB,3);
cm=zeros(1,9)
cm(1,:)=[meanR stdR skewR meanG stdG skewG meanB stdB skewB];
end

