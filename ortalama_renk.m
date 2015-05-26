clear all;
close all;
clc
CI = imread('C:\Users\Esra ERDEN\Desktop\croplu\4a.jpg');

for i=1:size(CI,1)
    for k=1:size(CI,2)
        if (CI(i,k,1)>40 && CI(i,k,1)<150) && (CI(i,k,2)>120 && CI(i,k,2)<230) && (CI(i,k,3)>60 && CI(i,k,3)<170)
            CI(i,k,1)=5;
            CI(i,k,2)=5;
            CI(i,k,3)=5;
        end
    end
end
% figure(4), imshow(CI);
I = CI;
GI = rgb2gray(CI);
GIE = (GI> 120 & GI< 170);
GIE = im2bw(GIE);
%imshow(GIE);
sayac = 0;
toplamR = 0;
toplamG = 0;
toplamB = 0;
for i=1:size(GIE,1)
    for k=1:size(GIE,2)
        if GIE(i,k) == 0;
            CI (i,k,1) = 5;
            CI (i,k,2) = 5;
            CI (i,k,3) = 5;
        else
            toplamR = im2double(CI (i,k,1)) + toplamR;
            toplamG = im2double(CI (i,k,2)) + toplamG;
            toplamB = im2double(CI (i,k,3)) + toplamB;
            sayac = sayac + 1;
            continue;
        end
    end
end

oR = toplamR / sayac;
oG = toplamG / sayac;
oB = toplamB / sayac;

oRenk(1,1,1) = oR;
oRenk(1,1,2) = oG;
oRenk(1,1,3) = oB;
oRenk = im2uint8(oRenk);

oRenkS = (imresize(oRenk, [200 200]));

figure(1);
subplot(221);   imshow(I),   title('Orjinal Resim');
subplot(222);   imshow(GIE),   title('Gri Resim');
subplot(223);   imshow(CI),  title('Bölütlenmiş Resim')
subplot(224);   imshow(oRenkS),  title('Ortalama Yuz Rensgi');
