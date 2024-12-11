% Interpolating the Real World Data Set 
%
% 
%
%
%


% The primary data set has been split up into device models. The first
% % question we are looking to answer is: Is battery life affected by screen on time more from device to device
function a = ScreenvBattery()
    w = readtable('datasets/Google_Pixel_5.csv'); 
    x = sort(table2array(w(:,4))); % screen on time
    y = sort(table2array(w(:,5))); % battery drain 
    eval_points = linspace(0, 15, 100)';
    plot_methods(x, y, eval_points, 'Google Pixel 5 Screen on Time v Battery');
    disp('google pixel data:')
    disp(w)

    w1 = readtable('datasets/iPhone_12.csv'); 
    x1 = sort(table2array(w1(:,4)));
    y1 = sort(table2array(w1(:,5)));
    eval_points1 = linspace(0, 15, 100)';
    plot_methods(x1, y1, eval_points1, 'Iphone 12 Screen on Time v Battery');
    disp('Iphone data:' );
    disp(w1)

    w2 = readtable('datasets/OnePlus_9.csv'); 
    x2 = sort(table2array(w2(:,4)));
    y2 = sort(table2array(w2(:,5)));
    eval_points2 = linspace(0, 15, 100)';
    plot_methods(x2, y2, eval_points2, 'one plus 9 Screen on Time v Battery');
    disp('One Plus 9 data:' );
    disp(w2)

    w3 = readtable('datasets/Samsung_Galaxy_S21.csv'); 
    x3 = sort(table2array(w3(:,4)));
    y3 = sort(table2array(w3(:,5)));
    eval_points3 = linspace(0, 15, 100)';
    plot_methods(x3, y3, eval_points3, 'Samsung Galaxy 21 Screen on Time v Battery');
    disp('Samsung Galaxy data:' );
    disp(w3)

    w4 = readtable('datasets/Xiaomi_Mi_11.csv'); 
    x4 = sort(table2array(w4(:,4)));
    y4 = sort(table2array(w4(:,5)));
    eval_points4 = linspace(0, 15, 100)';
    plot_methods(x4, y4, eval_points4, 'Xiaomi Screen on Time v Battery');
    disp('Xiaomi data:' );
    disp(w4)
end

a = ScreenvBattery();

% function b = AppUsagevBattery()
%     w = readtable('datasets/Google_Pixel_5.csv'); 
%     x = sort(table2array(w(:,3))); % screen on time
%     y = sort(table2array(w(:,5))); % battery drain 
%     eval_points = linspace(0, 15, 100)';
%     plot_methods(x, y, eval_points, 'Google Pixel 5 App Usage v Battery');
%     disp('google pixel data2:')
%     disp(w)
% 
%     w1 = readtable('datasets/iPhone_12.csv'); 
%     x1 = sort(table2array(w1(:,3)));
%     y1 = sort(table2array(w1(:,5)));
%     eval_points1 = linspace(0, 15, 100)';
%     plot_methods(x1, y1, eval_points1, 'Iphone 12 App Usage v Battery');
%     disp('Iphone data2:' );
%     disp(w1)
% 
%     w2 = readtable('datasets/OnePlus_9.csv'); 
%     x2 = sort(table2array(w2(:,3)));
%     y2 = sort(table2array(w2(:,5)));
%     eval_points2 = linspace(0, 15, 100)';
%     plot_methods(x2, y2, eval_points2, 'one plus 9 App Usage v Battery');
%     disp('One Plus 9 data2:' );
%     disp(w2)
% 
%     w3 = readtable('datasets/Samsung_Galaxy_S21.csv'); 
%     x3 = sort(table2array(w3(:,3)));
%     y3 = sort(table2array(w3(:,5)));
%     eval_points3 = linspace(0, 15, 100)';
%     plot_methods(x3, y3, eval_points3, 'Samsung Galaxy 21 App Usage v Battery');
%     disp('Samsung Galaxy data2:' );
%     disp(w3)
% 
%     w4 = readtable('datasets/Xiaomi_Mi_11.csv'); 
%     x4 = sort(table2array(w4(:,3)));
%     y4 = sort(table2array(w4(:,5)));
%     eval_points4 = linspace(0, 15, 100)';
%     plot_methods(x4, y4, eval_points4, 'Xiaomi App Usage v Battery');
%     disp('Xiaomi data2:' );
%     disp(w4)
% end
% 
% b = AppUsagevBattery();