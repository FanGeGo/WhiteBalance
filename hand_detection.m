clc
close all;
clear all;
 
im_ = imread('C:\Users\Esra ERDEN\Desktop\foto\14a.jpg');
im = imcrop(im_, [1200 1450 550 650 ]);
 
for i = 1:size(im, 1)
    for k = 1:size(im, 2)
        if (im(i, k, 1) > 40 && im(i, k, 1) < 150) && (im(i, k, 2) > 120 && im(i, k, 2) < 230) && (im(i, k, 3) > 60 && im(i, k, 3) < 170)
            im(i, k, 1) = 5;
            im(i, k, 2) = 5;
            im(i, k, 3) = 5;
        end
    end
end
 
I = im;
GI = rgb2gray(im);
GIE = (GI > 120 & GI < 170);
GIE = im2bw(GIE);
 
sayac = 0;
toplamR = 0;
toplamG = 0;
toplamB = 0;
for i = 1:size(GIE, 1)
    for k = 1:size(GIE, 2)
        if GIE(i, k) == 0;
            im(i, k, 1) = 5;
            im(i, k, 2) = 5;
            im(i, k, 3) = 5;
        else
            toplamR = im2double(im (i, k, 1)) + toplamR;
            toplamG = im2double(im (i, k, 2)) + toplamG;
            toplamB = im2double(im (i, k, 3)) + toplamB;
            sayac = sayac + 1;
            continue;
        end
    end
end
 
oR = toplamR / sayac;
oG = toplamG / sayac;
oB = toplamB / sayac;
 
oRenk(1, 1, 1) = oR;
oRenk(1, 1, 2) = oG;
oRenk(1, 1, 3) = oB;
oRenk = im2uint8(oRenk);
 
oRenkS = (imresize(oRenk, [200 200]));
figure(1);
subplot(2, 3, 1);   imshow(im1),     title('orginal image');
subplot(2, 3, 2);   imshow(GIE),     title('Gri Resim');
subplot(2, 3, 3);   imshow(im),      title('Bölütlenmiş Resim')
subplot(2, 3, 4);   imshow(oRenkS),  title('Ortalama El Rengi');
