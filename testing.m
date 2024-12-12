% Dataset 1: f(x) = exp(x^2) on [0.6, 1]
x1 = linspace(0.6, 1, 5)';
y1 = exp(x1.^2);
eval_points1 = linspace(0.6, 1, 1000)';
plot_methods(x1, y1, eval_points1, 'Dataset 1: f(x) = exp(x^2)');

% Dataset 2: f(x) = 1 / (1 + 12*x^2) on [-1, 1]
x2 = linspace(-1, 1, 15)';
y2 = 1 ./ (1 + 12 * x2.^2);
eval_points2 = linspace(-1, 1, 1000)';
plot_methods(x2, y2, eval_points2, 'Dataset 2: f(x) = 1 / (1 + 12*x^2)');

% Dataset 3: Year vs. Values
x3 = [1994; 1995; 1996; 1997; 1998; 1999; 2000; 2001; 2002; 2003];
y3 = [67.052; 68.008; 69.803; 72.024; 73.400; 72.063; 74.669; 74.487; 74.065; 76.777];
eval_points3 = linspace(min(x3), max(x3), 1000)';
plot_methods(x3, y3, eval_points3, 'Dataset 3: Year vs. Values');

