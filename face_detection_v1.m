
function adjustedImage = whitebalance(imageData, imageDataOriginal)
    imageData = imcrop(imageData, [450 250 3330 2330]);
    pageSize = size(imageData,1) * size(imageData,2);
    avg_rgb = mean( reshape(imageData, [pageSize,3]) );
    avg_all = mean(avg_rgb);
    scaleArray = max(avg_all, 128)./avg_rgb;
    scaleArray = reshape(scaleArray,1,1,3);
    adjustedImage = uint8(bsxfun(@times,double(imageData),scaleArray));
    %figure, imshow(adjustedImage);
    % figure, imshow(imageDataOriginal);  FDetect = vision.CascadeObjectDetector();

    %<!--Bu kod 200x200 altındaki her nesneyi ihmal edecek-->
    FDetect.MinSize = [200 200];
    %Read the input image
    I = adjustedImage;
    %Returns Bounding Box values based on number of objects
    BB = step(FDetect,I);
    figure,
    imshow(I); hold on
    %Eger boş değilse BB buradan yuzu çevreleyecek
    if ~isempty(BB)
        rectangle('Position',bbox(:),'LineWidth',5,'LineStyle','-','EdgeColor','r');
    end
    title('Face Detection');
    hold off;
end

