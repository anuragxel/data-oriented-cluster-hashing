function [results] = search_indexes(query_pts, beta, k_max, radius, indexfile, input)
% Loads the necessary index file to memory
load(indexfile);
load(kmeansfile);

% query_pts -> mXn where n is the dimension of each pt so m points
results = 0;
for i = 1:size(query_pts,1)
    query_pt = query_pts(i,:);
    if k_value <= k_max
        dist = pdist2(centroids,query_pt);
        dist = dist/sum(dist);
        c = find(dist < beta);
        centers = centroids(c,:);
    else
        new_value = (query_pt*hash_global_func + b)/w;
        c = 1:size(global_key_set,1);
        for j = 1:length(new_value)
            c = find(global_key_set(c,j) == new_value(j)); %finding the bucket
        end
        centers = centroids(c,:);
    end
    for center = c
        new_value = (query_pt*hash_global_func + b)/w;
        cc = 1:size(hash_key_cell{center},1);
        for j = 1:length(new_value)
            cc = find(hash_key_cell{center}(cc,j) == new_value(j)); %finding the bucket
        end
        idx_pts = hash_pos_cell{center}(cc);
        for kk = 1:size(idx_pts)
            points(kk,:) = fvecs_read(input, idx_pts(kk));
        end
        qq = pdist2(points,query_pt);
        result = find(qq < radius);
        results(end+1:end+length(result),:) = points(result,:);
    end
end