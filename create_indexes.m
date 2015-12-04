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
function create_indexes(filename,size, k_value, w, b)
vecs = fvecs_read(filename,[1 size]);
positions = 1:size(vecs,2);
% @TODO: CHECK THIS
vecs = vecs';
[idx,centroids] = kmeans(vecs, k_value);
[hash_global_func, global_key_set] = create_hash_keys(centroids, w, b);
% store actual centroids instead of positions in the file for the
% global hash table
hash_global_table = containers.Map(global_key_set, centroids);
% Create an array of cells to store the hash tables and the functions
% except for the global hash table and the global function.
% The hash tables here will store the hash key and the corresponding
% position in the file instead of the actual value 
% (later use fvecs_read to retrieve what point you wish).
hash_table_cell = {};
hash_func_cell = {};
for k = 1:k_value
    cluster_points = vecs(idx==k);
    [local_func, local_key_set] = create_hash_keys(cluster_points, w, b);
    hash_func_cell{k} = local_func;
    hash_table_cell{k} = containers.Map(local_key_set, positions(idx==k));
end
% using write to write the indexes in
% a file along with the variables load
% them later when you wish to search
write(strcat('index_',filename,'.mat'),hash_global_table,...
      hash_global_func,hash_func_cell,hash_table_cell,k_value, w, b);
% FUNCTION create_indexes END

% This function takes the set of points present in 
% the same cluster and then performs a PCA on them,
% making a function from the set of chosen vectors
% while also finding the set of keys for the points.
%
% CHECK CORRECTNESS PLZ
function[keySet, func] = create_hash_keys(valueSet, w, b)
pca_vector_num = 2;
coeff = pca(valueSet);
func = coeff(:,1:pca_vector_num);
% @TODO: CHECK THIS AND CONCATENATE THE VALUES GIVEN BY TWO VECTORS
keySet = (func*value_set + b)/w;
% FUNCTION create_hash_keys END
