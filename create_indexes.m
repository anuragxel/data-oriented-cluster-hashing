% Anurag Ghosh, Romil Aggarwal
%
% Parameters to give to create_indexes are
% mentioned below.
% k_value is between 10 to 100
% w is around 5 to 20
% size is normally 250000/500000/1000000
%
% This has been written as a part of course project 
% in Database Systems, Monsoon 2015, IIIT Hyderabad
function [indexfile, kmeansfile] = create_indexes(filename, size_file, k_value, w, b)
points = fvecs_read(filename,[1, size_file]);
positions = 1:1:size(points,2);
[idx,centroids] = kmeanspp(points, k_value); % Can be replaced by a faster algorithm using KD-Trees.
idx = transpose(idx);
centroids = transpose(centroids);
points = transpose(points);
kmeansfile = strcat(filename,'_kmeans.mat');
save(kmeansfile,'idx','centroids');
[hash_global_func, global_key_set] = create_hash_keys(centroids, w, b);
% store actual centroids instead of positions in the file for the
% global hash table
% Create an array of cells to store the hash tables and the functions
% except for the global hash table and the global function.
% The hash tables here will store the hash key and the corresponding
% position in the file instead of the actual value 
% (later use fvecs_read to retrieve what point you wish).
hash_key_cell = {};
hash_func_cell = {};
hash_pos_cell = {};
for k = 1:k_value
    [local_func, local_key_set] = create_hash_keys(points(idx==k,:), w, b);
    hash_func_cell{k} = local_func;
    hash_key_cell{k}  = local_key_set;
    hash_pos_cell{k}  = positions(idx==k);
end
% using write to write the indexes in
% a file along with the variables load
% them later when you wish to search
indexfile = strcat(filename,'_indexes.mat');
save(indexfile,'global_key_set','centroids','hash_global_func',...
    'hash_func_cell','hash_key_cell','hash_pos_cell','k_value', 'w', 'b');
end