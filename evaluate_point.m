% Anurag Ghosh, Romil Aggarwal
%
% This has been written as a part of course project 
% in Database Systems, Monsoon 2015, IIIT Hyderabad
function accuracy = evaluate_point(list, filename, file_size, querypoint)
r = size(list,1);
sub_out = bsxfun(@minus, list, querypoint);
numer = sub_out.'*sub_out;
sub_full_set = zeros(file_size);
for i = 1:100:file_size
    vecs = fvecs_read(filename, [i i+99]);
    sub_par = bsxfun(@minus, vecs.', querypoint);
    sub_full_set(i:i+99) = sub_par.'*sub_par;
end
sub_full_set = sort(sub_full_set);
denom = sub_full_set(1:r);
accuracy = sum(numer./denom)/r;