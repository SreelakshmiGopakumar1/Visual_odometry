clc
close all
imagefiles = dir('E:\Backup\TrialFrames\1.jpg'); 
scale = 0.25;
load('cameraparams.mat');

cameraParamR = cameraParameters('IntrinsicMatrix',0.25*cameraParams.IntrinsicMatrix,'RadialDistortion',cameraParams.RadialDistortion); 
nfiles = length(imagefiles);    % Number of files found

  	r1 =imread('E:\Backup\TrialFrames\1.jpg');              
    r2 = imresize(rgb2gray(r1),scale);
    t1 = detectSURFFeatures(r2, 'MetricThreshold', 300);
    [N1,v1] = extractFeatures(r2,t1);
    
[matchpoints]= matchFeatures(N1,Features);
image_candidates = ImageID(matchpoints(:,2));
[a,b]=hist(image_candidates,unique(image_candidates));
[mx,id]=max(a);
i1 =imread(['dataset/' num2str(b(id)) '.png']);
imshow (i2)
subplot(1,2,1)
imshow(r2)
subplot(1,2,2)
imshow(i1)

