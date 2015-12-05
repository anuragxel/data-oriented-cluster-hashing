% First Part
% Create the indexes for the database
% If indexes are already constructed for the set,
% You may not run this part of the code.
tic
addpath('libs');
filename = 'dataset/synthetic_set_060.fvecs';
filesize = 20000;
dimension = 60;
k = 40;
b = 3;
w = 6;
[indexfile, kmeansfile] = create_indexes(filename,filesize,k,w,b);
toc
% %% Second Part
% %Search query points in the data set
% k_max = 55;
% threshold_degree = 0.015;
% radius = 1.5;
% %%%%%%%%%%%%%beta = 0.14;
% query_pts = []
% for i = 1:2500:250000
%     vecs = fvecs_read(input, [i i+2499]);
%     y = randsample(1:100,10);
%     query_pts = [ query_pts; vecs(:,y) ];
%     
% end
% list = search_indexes(query_pts, beta, k_max, radius, indexfile)