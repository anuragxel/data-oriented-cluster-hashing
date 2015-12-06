function [func, keySet] = create_hash_keys(valueSet, w, b)
%
% This function takes the set of points present in 
% the same cluster and then performs a PCA on them,
% making a function from the set of chosen vectors
% while also finding the set of keys for the points.
%
pca_vector_num = 2;
func = pcasecon(valueSet.',pca_vector_num);
set_val = floor((valueSet*func + b)/w) + 1;
keySet = byte_concat(set_val(:,1),set_val(:,2));
% FUNCTION create_hash_keys END

function [z] = byte_concat(h1,h2)
x=uint16(h1); % first byte
y=uint16(h2); % second byte
bytepack=uint32(x);
bytepack=bitshift(bytepack,16);
z=bitor(bytepack,uint32(y));
