close all
clear all
clc
image_folder = 'D:\Backup\dataset'; 
filenames = dir(fullfile(image_folder, '*.png'));  
scale = 0.25;
load('cameraparams.mat');
cameraParamR = cameraParameters('IntrinsicMatrix',0.25*cameraParams.IntrinsicMatrix,'RadialDistortion',cameraParams.RadialDistortion); 
nfiles = length(filenames);    % Number of files found
 j = 1;
 tableA = cell(10,1);
 Features = [] ;
 Locations = [];
 ImageID = [];
 VPTS = [] ;
 no_feature =40;
for i=5431:10:6301  %length(filenames) 
    i1 =imread(['dataset/' num2str(i) '.png']);
    p1 = detectSURFFeatures(i1, 'MetricThreshold', 300);
    p1 = p1.selectStrongest(no_feature);
    [f1,vpts1] = extractFeatures(i1,p1);
    Features = [Features;f1] ;
    %VPTS = [VPTS;vpts1];
    Locations = [Locations; p1.Location];
    ImageID = [ImageID; i*ones(no_feature,1)];
%     figure (1)
    imshow (i1)
    hold on
    plot(p1)
    hold off
    j = j+1; 
end
 V = squareform(pdist(Features));
 for i = 1:no_feature*(j-1)
     V(i,i) = 1000000000;
 end
 
 [minimum, id] = min(V,[],2);
 
 A = V < max(minimum);
 
 m = zeros(1,no_feature*(j-1));
 
 for i =1:no_feature*(j-1)
    m(i) =length(find(A(i,:))); 
 end
 
 unique_Features = Features(m < 60,:);
 unique_Locations = Locations(m < 60);
 unique_ImageID = ImageID(m < 60);
 %unique_VPTS =   VPTS(m < 60);
 
 for i =1:no_feature*(j-1)
     if (m(i) < 60)
     i1 =imread(['dataset/' num2str(ImageID(i)) '.png']);
    i2 =imread(['dataset/' num2str(ImageID(id(i))) '.png']);
     figure(2);
    imshow([i1 i2]);
    imshow(i1)
     hold on
     plot(Locations(i,1),Locations(i,2),'ro');
    plot(Locations(id(i),1)+480,Locations(id(i),2),'go');
     pause()
     imshow(i2)
     hold off
     end
 end


 
%  
 
 