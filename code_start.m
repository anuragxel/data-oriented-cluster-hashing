% First Part
% Create the indexes for the database
% If indexes are already constructed for the set,
% You may not run this part of the code.
tic
clear
clc
addpath('libs');
filename = './../dataset/synthetic_set_060.fvecs';
filesize = 20000;
dimension = 60;
k = 40;
b = 1.95;
w = 2;
[indexfile, kmeansfile] = create_indexes(filename,filesize,k,w,b);
toc
% Second Part
% Search query points in the data set
k_max = 55;
%threshold_degree = 0.015;
radius = 1.5;
beta = 0.14; %0.14
query_pts = [];
sampling_rate = 1;
for i = 1:2500:filesize
    vecs = fvecs_read(filename, [i i+2499]);
    y = randsample(1:2500,sampling_rate);
    query_pts = [ query_pts; vecs(:,y)' ];
end
tic
list = search_indexes(query_pts, beta, k_max, radius, indexfile, kmeansfile, filename);
toc
avg = 0.0;
for i = 1:size(query_pts,1)
    avg = avg + evaluate_point(list{i}, filename, filesize, query_pts(i,:));
    fprintf('the avg value for %d query_pt => %f\n',i,avg);
end
avg = avg/size(query_pts,1);