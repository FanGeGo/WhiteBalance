 clc;   
close all;  
clear;  
workspace; 
format longg;
format compact;
fontSize = 15;

[rgbImage colorMap] = imread('C:\Users\Esra ERDEN\Desktop\10.jpg');
[rows columns numberOfColorBands] = size(rgbImage);
% İmge  indexed image rgbImage'e dönüştürülür;
if numberOfColorBands == 1
	rgbImage = ind2rgb(rgbImage, colorMap); % Will be in the 0-1 range.
	rgbImage = uint8(255*rgbImage); % Convert to the 0-255 range.
end

% Orjinal fotoğrafın tam ekran gösterimi
imshow(rgbImage);
title('Resmi çizin ve çift tıklayın', 'FontSize', fontSize);
% İmgeyi tam ekran yap.
set(gcf, 'units','normalized','outerposition', [0 0 1 1]);
promptMessage = sprintf('Resmin crop edeceğiniz kısmını seçiniz.');
titleBarCaption = 'Devam Etmek İster misiniz ?';
button = questdlg(promptMessage, titleBarCaption, 'Çiz', 'Çıkış', 'Çiz');
if strcmpi(button, 'Çıkış')
	return;
end
hBox = imrect;
roiPosition = wait(hBox);
roiPosition 
% Fotoğrafta crop edilecek  koordinatların  bulunması.
xCoords = [roiPosition(1), roiPosition(1)+roiPosition(3), roiPosition(1)+roiPosition(3), roiPosition(1), roiPosition(1)];
yCoords = [roiPosition(2), roiPosition(2), roiPosition(2)+roiPosition(4), roiPosition(2)+roiPosition(4), roiPosition(2)];

croppingRectangle = roiPosition;
subplot(2, 2, 1);
imshow(rgbImage);
title('Orjinal Fotoğraf', 'FontSize', fontSize);

% ROI ile crop
whitePortion = imcrop(rgbImage, croppingRectangle);
subplot(2, 2, 2);
imshow(whitePortion);
caption = sprintf('ROI Uygulanmış Fotoğraf');
title(caption, 'FontSize', fontSize);

% RGB Uzayına Göre Paletteki Renklerin Ayıklanması
redChannel = whitePortion(:, :, 1);
greenChannel = whitePortion(:, :, 2);
blueChannel = whitePortion(:, :, 3);

% R,G,B ortalamaları bulunması
meanR = mean2(redChannel);
meanG = mean2(greenChannel);
meanB = mean2(blueChannel);

% Ortalamaların Belirlenmesi
desiredMean = mean([meanR, meanG, meanB])
message = sprintf('Red mean = %.1f\nGreen mean = %.1f\nBlue mean = %.1f\nTüm ortalamalar alınacak %.1f',...
	meanR, meanG, meanB, desiredMean);
uiwait(helpdlg(message));

% ROI ile crop edilen resmin üzerinde lineer ölçeklendirme yapılması.
correctionFactorR = desiredMean / meanR;
correctionFactorG = desiredMean / meanG;
correctionFactorB = desiredMean / meanB;
redChannel = uint8(single(redChannel) * correctionFactorR);
greenChannel = uint8(single(greenChannel) * correctionFactorG);
blueChannel = uint8(single(blueChannel) * correctionFactorB);
correctedRgbImage = cat(3, redChannel, greenChannel, blueChannel);
figure;
subplot(2, 2, 3);
imshow(correctedRgbImage);
title('Renk Dengesi -ROI', 'FontSize', fontSize);
set(gcf, 'units','normalized','outerposition',[0 0 1 1])
meanR = mean2(redChannel);
meanG = mean2(greenChannel);
meanB = mean2(blueChannel);
correctedMean = mean([meanR, meanG, meanB])
message = sprintf('Now, the\nCorrected Red mean = %.1f\nCorrected Green mean = %.1f\nCorrected Blue mean = %.1f\n',...
	meanR, meanG, meanB);
uiwait(helpdlg(message));
redChannel = rgbImage(:, :, 1);
greenChannel = rgbImage(:, :, 2);
blueChannel = rgbImage(:, :, 3);

% Crop edilmemiş resme lineer ölçeklendirme yapılması
redChannelC = uint8(single(redChannel) * correctionFactorR);
greenChannelC = uint8(single(greenChannel) * correctionFactorG);
blueChannelC = uint8(single(blueChannel) * correctionFactorB);

% Gerçek renklerin uygulandığı resim
correctedRGBImage = cat(3, redChannelC, greenChannelC, blueChannelC);
subplot(2, 2,4);
imshow(correctedRGBImage);
title('Düzeltilmiş Orjinal Boyutlu Fotoğraf', 'FontSize', fontSize);
message = sprintf('BAŞARILI');
uiwait(helpdlg(message));
