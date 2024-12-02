function coeff = Vandermonde_Interpolation(x, y)
%VANDERMONDE_POLY Computes the coefficients of the Vandermonde polynomial.
%   coeff = vandermonde_poly(x, y) returns the coefficients of the 
%   polynomial that passes through the given data points (x, y).

    % Validate inputs
    if length(x) ~= length(y)
        error('x and y must have the same length.');
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
    
end



