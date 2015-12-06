% Anurag Ghosh, Romil Aggarwal
%
% The function returns the Mean Overall Ratio (MOR),
% MOR(q) = 1/r \sum_{l} ( \frac{|p_l,q|}{|p^*_l,q|} )
%
% This has been written as a part of course project
% in Database Systems, Monsoon 2015, IIIT Hyderabad
function accuracy = evaluate_point(list, filename, filesize, querypoint)
r = size(list,1);
numer = pdist2(list,querypoint);
sub_full_set = zeros(filesize);
for i = 1:100:filesize
    vecs = fvecs_read(filename, [i i+99])';
    sub_full_set(i:i+99) = pdist2(vecs, querypoint);
end
sub_full_set = sort(sub_full_set);
denom = sub_full_set(1:r);
accuracy = nanmean(denom'./numer);