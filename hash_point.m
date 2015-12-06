function key = hash_point(value, w, b, func)
set_val = (value*func + b)/w;
key = byte_concat(set_val(:,1),set_val(:,2));

function [z] = byte_concat(h1,h2)
x=uint16(h1); % first byte
y=uint16(h2); % second byte
bytepack=uint32(x);
bytepack=bitshift(bytepack,16);
z=bitor(bytepack,uint32(y));