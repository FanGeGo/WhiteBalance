srcFiles = dir('C:\Users\Esra ERDEN\Desktop\foto\*.jpg');  % the folder in which ur images exists
for i = 1 : length(srcFiles)
    filename = strcat('C:\Users\Esra ERDEN\Desktop\foto\*.jpg',srcFiles(i).name);
%    imageData = imread(filename);
    imageData = imcrop(imageData, [450 250 3330 2330]);   %Otomatik crop;
    FDetect = vision.CascadeObjectDetector;
    
    imageDataOriginal = imageData;          %resmin orijinali de dursun;
    
    BB = step(FDetect, imageData);   %kırmızı şeritler için BB matrisi oluştur. (Nerede başlayıp nerede biteceğini söylemek)
    
    for j=1:size(BB,1)
        face = imcrop(imageData, BB(j,:));
        
    end
    imwrite(face, ['C:\Users\Esra ERDEN\Desktop\crop_hand\.jpg', num2str(i), '.jpg']);
end
