function [list] = search_indexes(query_pts, beta, k_max, radius, indexfile)
% Loads the necessary index file to memory
load(indexfile);
