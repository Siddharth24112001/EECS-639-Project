function interpolated_vals = Lagrange_Interpolation(data, eval_points)
% LAGRANGE_INTERPOLATION_NUMERIC Computes Lagrange interpolation
% INPUT:
% - data: A matrix of points [t1, y1; t2, y2; ...; tn, yn]
% - eval_points: Points where the interpolation is evaluated
% OUTPUT:
% - interpolated_vals: Interpolated values at eval_points

    % Extract x (t values) and y (function values)
    x = data(:, 1);
    y = data(:, 2);

    % Number of data points
    n = length(x);

    % Initialize result
    interpolated_vals = zeros(size(eval_points));

    % Loop through evaluation points
    for k = 1:length(eval_points)
        % Compute interpolation for the current evaluation point
        L_k = zeros(n, 1);
        for i = 1:n
            % Compute Lagrange basis polynomial L_i(x)
            L = 1;
            for j = 1:n
                if j ~= i
                    L = L * (eval_points(k) - x(j)) / (x(i) - x(j));
                end
            end
            L_k(i) = L;
        end
        % Sum up contributions from each Lagrange basis
        interpolated_vals(k) = sum(y .* L_k);
    end
end
