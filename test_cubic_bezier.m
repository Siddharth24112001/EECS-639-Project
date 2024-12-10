function test_cubic_bezier()
    % Define parametric curves and their ranges
    t = linspace(0, 2*pi, 500); % Parameter for curves

    % Ellipse Curve
    ellipse_x = 5 * cos(3*t);
    ellipse_y = 2 * sin(3*t);
    plot_bezier_interpolation(t, ellipse_x, ellipse_y, 'Ellipse Curve', 20);

    % Hypotrochoid Curve
    hypotrochoid_x = 2 * cos(t) + 5 * cos(2*t/3);
    hypotrochoid_y = 2 * sin(t) - 5 * sin(2*t/3);
    plot_bezier_interpolation(t, hypotrochoid_x, hypotrochoid_y, 'Hypotrochoid Curve', 20);

    % Wavy Curve
    t_wavy = linspace(0, 80*pi, 1000);
    wavy_x = 20 * t_wavy .* cos(0.2 * t_wavy);
    wavy_y = 10 * sin(t_wavy);
    plot_bezier_interpolation(t_wavy, wavy_x, wavy_y, 'Wavy Curve',200);

    % Butterfly Curve
    butterfly_x = sin(t) .* (exp(cos(t)) - 2 * cos(4*t) - sin(t/12).^5);
    butterfly_y = cos(t) .* (exp(cos(t)) - 2 * cos(4*t) - sin(t/12).^5);
    plot_bezier_interpolation(t, butterfly_x, butterfly_y, 'Butterfly Curve', 20);

    % Rose Curve
    a = 1; k = 7; % Example parameters
    theta = linspace(0, 2*pi, 500);
    rose_x = a * cos(k*theta) .* cos(theta);
    rose_y = a * cos(k*theta) .* sin(theta);
    plot_bezier_interpolation(theta, rose_x, rose_y, 'Rose Curve', 30); % Increased segments to 16
end

function plot_bezier_interpolation(t, x, y, curve_name, n_segments)
    % Plot the original curve
    figure; hold on;
    plot(x, y, 'r-', 'LineWidth', 1.5, 'DisplayName', 'Original Curve');
    
    % Compute derivatives for control point adjustment
    dx = diff(x)./diff(t); % Approximate x-derivative
    dy = diff(y)./diff(t); % Approximate y-derivative
    dx = [dx, dx(end)]; % Extend derivative for the last point
    dy = [dy, dy(end)]; % Extend derivative for the last point
    
    % Subdivide the curve into segments for Bézier interpolation
    segment_length = floor(length(t) / n_segments);
    for i = 1:n_segments
        % Determine start and end indices for the segment
        start_idx = (i-1)*segment_length + 1;
        end_idx = min(i*segment_length + 1, length(t));
        
        % Define control points
        p1 = [x(start_idx), y(start_idx)];
        p4 = [x(end_idx), y(end_idx)];
        
        % Use derivatives to calculate intermediate control points
        dt = t(end_idx) - t(start_idx);
        p2 = [x(start_idx) + dx(start_idx) * dt / 3, ...
              y(start_idx) + dy(start_idx) * dt / 3];
        p3 = [x(end_idx) - dx(end_idx) * dt / 3, ...
              y(end_idx) - dy(end_idx) * dt / 3];
        
        % Compute Bézier curve for this segment
        [Bx, By] = cubic_Bezier_curve(p1, p2, p3, p4);
        plot(Bx, By, 'b--', 'LineWidth', 1.0);
        
        % Visualize control points (optional)
        % plot([p1(1), p2(1), p3(1), p4(1)], [p1(2), p2(2), p3(2), p4(2)], 'ko-', 'LineWidth', 1.0);
    end
    
    % Plot settings
    title(curve_name);
    xlabel('X'); ylabel('Y');
    legend('show');
    grid on;
end

function [Bx, By] = cubic_Bezier_curve(p1, p2, p3, p4)
    % Cubic Bézier curve implementation
    t = linspace(0, 1, 100); % Higher resolution for Bézier curve
    x = 1; y = 2; % Coordinate indices
    Bx = ((1-t).^3).*p1(x) + 3*((1-t).^2).*t.*p2(x) + 3*(1-t).*(t.^2).*p3(x) + t.^3.*p4(x);
    By = ((1-t).^3).*p1(y) + 3*((1-t).^2).*t.*p2(y) + 3*(1-t).*(t.^2).*p3(y) + t.^3.*p4(y);
end
