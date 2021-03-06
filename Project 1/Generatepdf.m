function [ N ] = Generatepdf(b)
% Using folder of sample jpegs, generate a rough frequency distribution for
% jpg encoded byte data
% Uses bytetream size b as reference for whether or not to include image in
% average

filenames = dir('sample_images');
filenames = filenames(3:end);
loopsize = size(filenames);
% Use size to remove some less reliable jpg info
for i = loopsize:1
    low = b - 8000;
    high = b + 8000;
    if (filenames(i).bytes < low)||(filenames(i).bytes > high)
        filenames(i,:) = [];
    end
end

for i = 1:size(filenames)
    f = [pwd '/sample_images/' filenames(i).name]; % filepath
    file = fopen(f, 'r');
    bytestream = fread(file);
    fclose(file);
    [N(i,:), edges] = histcounts(bytestream, 256, 'Normalization', 'probability');
end

N = mean(N); % mean of all probabilities




