close all
clear all
clc
imagefiles = dir('dataset/*.png');   
scale = 0.25;
load('cameraparams.mat');
cameraParamR = cameraParameters('IntrinsicMatrix',0.25*cameraParams.IntrinsicMatrix,'RadialDistortion',cameraParams.RadialDistortion); 
nfiles = length(imagefiles);    % Number of files found
i1 =imread(['dataset/' num2str(5071) '.png']);
p1 = detectSURFFeatures(i1, 'MetricThreshold', 300);
[f1,vpts1] = extractFeatures(i1,p1);
locT = [0,0,0];
orientT = eye(3);
for i= 5101:10:6301
    i2 =imread(['dataset/' num2str(i) '.png']);
    p2 = detectSURFFeatures(i2, 'MetricThreshold', 300);
    [f2,vpts2] = extractFeatures(i2,p2);
    indexPairs  = matchFeatures(f1,f2);
    matchedPoints1 = vpts1(indexPairs(:,1),:);
    matchedPoints2 = vpts2(indexPairs(:,2),:);
    [F,inliersIndex] = estimateFundamentalMatrix(matchedPoints1,matchedPoints2,'Method','RANSAC', 'NumTrials',800,'DistanceThreshold',5e-4);
    figure(1); 
    showMatchedFeatures(i1,i2,matchedPoints1(inliersIndex),matchedPoints2(inliersIndex));
    i1 = i2; p1 = p2; f1 = f2; vpts1 = vpts2;
    [orient, loc, inlierIdx] = relativeCameraPose(F, cameraParamR, matchedPoints1(inliersIndex),matchedPoints2(inliersIndex));
    orientT = orient*orientT;
    locT = locT + orientT*loc';

%     figure(2); plot3(locT(1),locT(2),locT(3),'r'); hold on
    cameraSize = 2;
    grid on
xlabel('X (m)');
ylabel('Y (m)');
zlabel('Z (m)');
figure(2)
hold on
% grid on
% plotCamera('Location', locT, 'Orientation', orientT, 'Size', cameraSize, ...
%     'Color', 'b', 'Label', '2', 'Opacity', 0);
plot3(locT(1),locT(2),locT(3),'r.'); hold off
title('Camera Trajectory');
end
