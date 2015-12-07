function [list] = search_indexes(query_pts, beta, k_max, radius, indexfile, kmeansfile, input)
% Anurag Ghosh, Romil Aggarwal
%
% This has been written as a part of course project 
% in Database Systems, Monsoon 2015, IIIT Hyderabad
% 

% Loads the necessary index file to memory
load(indexfile);
load(kmeansfile);
% query_pts -> mXn where n is the dimension of each pt so m points
list = {};
for i = 1:size(query_pts,1)
    disp(i);
    results = [];
    query_pt = query_pts(i,:);
    if k_value <= k_max
        dist = pdist2(centroids,query_pt);
        dist = dist/sum(dist);
        c = find(dist < beta);
        centers = centroids(c,:);
    else
        new_value = hash_point(query_pt, w, b, hash_global_func);
        c = find(global_key_set == new_value);
        centers = centroids(c,:);
    end
    for center = c'
        new_value = hash_point(query_pt, w, b, cell2mat(hash_func_cell(center)));
        cc = find(hash_key_cell{center} == new_value); %finding the bucket
        idx_pts = hash_pos_cell{center}(cc);
        points = [];
        for kk = idx_pts
            points = [ points; fvecs_read(input, [kk kk])' ];
        end
        qq = pdist2(points,query_pt);
        result = find(qq < radius);
%         results = [results; result];
        results = [ results;  points(result,:) ];
        %results(end+1:end+length(result),:) = points(result,:);
    end
    list{i} = results;
end