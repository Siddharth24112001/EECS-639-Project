function interpolated_vals = Vandermonde_Interpolation(data, eval_points)
%VANDERMONDE_POLY Computes the coefficients of the Vandermonde polynomial.
% INPUT:
% - data: A matrix of points [t1, y1; t2, y2; ...; tn, yn]
% - eval_points: Points where the interpolation is evaluated
% OUTPUT:
% - interpolated_vals: Interpolated values at eval_points

    x = data(:,1);
    y = data(:,2);

    % Validate inputs
    if length(x) ~= length(y)
        error('x and y must have the same length.');
    end
    if size(unique(x), 1) ~= size(x, 1)
        error('x is not a function; has more than one input with the same value')
    end
    
    n = length(x); % Number of data points
    
    % Construct the Vandermonde matrix
    V = zeros(n, n);
    for i = 1:n
        for j = 1:n
            V(i, j) = x(i)^(j-1); % Column-wise powers of x
        end
    end
    
    % Solve the linear system V * coeff = y
    coeff = V \ y(:); % Use backslash for numerical stability

    interpolated_vals = polyval(coeff(end:-1:1), eval_points);    
end



