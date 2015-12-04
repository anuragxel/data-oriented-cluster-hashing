% Anurag Ghosh, Romil Aggarwal
%
% This has been written as a part of course project 
% in Database Systems, Monsoon 2015, IIIT Hyderabad
function make_dataset()
input = 'gist/gist_base.fvecs';
inter = 'synthetic_set.fvecs';
%make_synthetic_set(input);
%create_diff_dim_sets(inter);

% This function creates the dataset of different dimensions.
% Handle carefully.
function create_diff_dim_sets(filename)
y1 = randsample(1:960,60);
y2 = randsample(1:960,360);
y3 = randsample(1:960,760);
for i = 1:100:250000
    vecs = fvecs_read(filename, [i i+99]);
    x1 = vecs(y1,:);
    x2 = vecs(y2,:);
    x3 = vecs(y3,:);
    fvecs_write('synthetic_set_060', x1);
    fvecs_write('synthetic_set_360', x2);
    fvecs_write('synthetic_set_760', x3);
end

% This function creates the synthetic dataset from the GIST Set
% of 250000 points, 960 dimensions.
function make_synthetic_set(input, output)
for i = 1:100:1000000
    vecs = fvecs_read(input, [i i+99]);
    y = randsample(1:100,25);
    x = vecs(:,y);
    fvecs_write(output, x);
end


% This function creates the synthetic dataset from the GIST Set
% of 500000 points, 960 dimensions.
function make_synthetic_set2(input, output)
for i = 1:100:1000000
    vecs = fvecs_read(input, [i i+99]);
    y = randsample(1:100,50);
    x = vecs(:,y);
    fvecs_write(output, x);
end