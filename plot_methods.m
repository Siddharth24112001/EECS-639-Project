function plot_methods(x, y, eval_points, dataset_name)
    % Generate the spline outputs using the cubicSpline function
    [Xout1, Yout1] = cubicSpline(x, y, 'natural', length(eval_points));
    [Xout2, Yout2] = cubicSpline(x, y, 'complete', length(eval_points));
    [Xout3, Yout3] = cubicSpline(x, y, 'not-a-knot', length(eval_points));

    % Evaluate Lagrange interpolation
    lagrange_vals = Lagrange_Interpolation([x, y], eval_points);

    % Evaluate Newton interpolation
    newton_vals = Newton_Interpolation([x, y], eval_points);

    % Evaluate Vandermonde interpolation
    vandermonde_vals = Vandermonde_Interpolation([x, y], eval_points);

    % Plot original data and each spline method
    figure;
    sgtitle(dataset_name, 'FontSize', 16);

    % Natural Spline
    subplot(2, 3, 1);
    plot(Xout1, Yout1, 'r-', 'LineWidth', 2);
    hold on;
    plot(x, y, 'bo', 'MarkerSize', 8);
    title('Natural Spline');
    xlabel('x');
    ylabel('y');
    grid on;

    % Complete Spline
    subplot(2, 3, 2);
    plot(Xout2, Yout2, 'g-', 'LineWidth', 2);
    hold on;
    plot(x, y, 'bo', 'MarkerSize', 8);
    title('Complete Spline');
    xlabel('x');
    ylabel('y');
    grid on;

    % Not-a-Knot Spline
    subplot(2, 3, 3);
    plot(Xout3, Yout3, 'b-', 'LineWidth', 2);
    hold on;
    plot(x, y, 'bo', 'MarkerSize', 8);
    title('Not-a-Knot Spline');
    xlabel('x');
    ylabel('y');
    grid on;

    % Lagrange Interpolation
    subplot(2, 3, 4);
    plot(eval_points, lagrange_vals, 'm-', 'LineWidth', 2);
    hold on;
    plot(x, y, 'bo', 'MarkerSize', 8);
    title('Lagrange Interpolation');
    xlabel('x');
    ylabel('y');
    grid on;

    % Newton Interpolation
    subplot(2, 3, 5);
    plot(eval_points, newton_vals, 'c-', 'LineWidth', 2);
    hold on;
    plot(x, y, 'bo', 'MarkerSize', 8);
    title('Newton Interpolation');
    xlabel('x');
    ylabel('y');
    grid on;

    % Vandermonde Interpolation
    subplot(2, 3, 6);
    plot(eval_points, vandermonde_vals, 'k-', 'LineWidth', 2);
    hold on;
    plot(x, y, 'bo', 'MarkerSize', 8);
    title('Vandermonde Interpolation');
    xlabel('x');
    ylabel('y');
    grid on;
end
