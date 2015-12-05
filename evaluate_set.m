% Anurag Ghosh, Romil Aggarwal
%
% This has been written as a part of course project 
% in Database Systems, Monsoon 2015, IIIT Hyderabad
function accuracy = evaluate_set(list,filename, querypoint)
r = size(list,1);
numerator = bsxfun(@minus,list,querypoint);