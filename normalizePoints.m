function normalized = normalizePoints(points_to_normalize, min, max)
% Normalizes each point within a vector of points to be within the range [-1, 1]
% INPUT:
% - points_to_normalize: a nx1 vector of points to be normalized
% - min: the minimum value of the data set we are normalizing for
% - max: the maximum value of the data set we are normalizing for
% OUTPUT:
% - normalized: A nx1 vector of points between the value [-1, 1]
normalized = (2 * (points_to_normalize - min) / (max - min)) - 1;
end