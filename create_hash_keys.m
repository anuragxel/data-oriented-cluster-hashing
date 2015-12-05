% This function takes the set of points present in 
% the same cluster and then performs a PCA on them,
% making a function from the set of chosen vectors
% while also finding the set of keys for the points.
function [func, keySet] = create_hash_keys(valueSet, w, b)
pca_vector_num = 2;
func = pcasecon(valueSet.',pca_vector_num);
set_val = (valueSet*func + b)/w;
keySet = byte_concat(1/set_val(:,1),1/set_val(:,2));
% FUNCTION create_hash_keys END

function [z] = byte_concat(h1,h2)
x=uint8(h1); % first byte
y=uint8(h2); % second byte
bytepack=uint16(x);
bytepack=bitshift(bytepack,8);
z=bitor(bytepack,uint16(y));
