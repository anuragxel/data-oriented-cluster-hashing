% This function takes the set of points present in 
% the same cluster and then performs a PCA on them,
% making a function from the set of chosen vectors
% while also finding the set of keys for the points.
function [func, keySet] = create_hash_keys(valueSet, w, b)
pca_vector_num = 2;
func = pcasecon(valueSet.',pca_vector_num); 
keySet = (valueSet*func + b)/w;
% FUNCTION create_hash_keys END
