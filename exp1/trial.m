

% Load an image 
%I = imread('F:\Minor Project\2nd Review Data\MY CODE\matlab_code\dataset\6151.png');

% Perform OCR
results = ocr(I);

% Display one of the recognized words
word = results.Words{1};
% Location of the word in I
wordBBox = results.WordBoundingBoxes(1,:);

% Show the location of the word in the original image
figure;
Iname = insertObjectAnnotation(I, 'rectangle', wordBBox, word);
imshow(Iname);
imagefiles = dir('dataset/*.png'); 
for i=5101:10:10*nfiles
    i2 =imread(['dataset/' num2str(i) '.png']);
    results = ocr(i2);
    word = results.Words{i};
    wordBBox = results.WordBoundingBoxes(i,:);
    figure;
i2name = insertObjectAnnotation(i2, 'rectangle', wordBBox, word);
imshow(iname);
end