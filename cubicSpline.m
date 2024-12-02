function [Xout,Yout] = cubicSpline(Xin,Yin,splineType, num)
% Creates the cubic spline from the given data
%
%   Input: Xin - x-values of the data
%          Yin - corresponding y-values of the data
%          splineType - type of cubic spline to use
%               + 'natural' for natural cubic spline
%               + 'complete' for complete cubic spline
%               + 'not-a-knot' for not-a-knot cubic spline
%          num - The amount of points for the output
%
%   Output : Xout - The x-values of the computed data
%            Yout - The y-values of the computed data
%
% Calculate the coeffecients for the spline equations
%

n = length(Xin); % Length of the data
A = zeros((n-1)*4); % Holds the system of equations
b = zeros((n-1)*4,1); % Holds the y values

% Populate A with P1(t), P2(t), ..., Pn-1(t)
for i=1:(n-1)
    P = [1 Xin(i) Xin(i).^2 Xin(i).^3
         1 Xin(i+1) Xin(i+1).^2 Xin(i+1).^3]; % Pi(t)
    A(i*2-1:i*2,i*4-3:i*4) = P;
end

% Populate A with first & second derivative of P(t)
off1 = (n-1)*2; % Offset for P'(t)
off2 = off1 + (n-2); % Offset for P''(t)
for i=1:(n-2)
    P1 = [0 1 2*Xin(i+1) 3*Xin(i+1).^2]; % First derivative of Pi(t)
    P2 = [0 0 2 6*Xin(i+1)]; % Second derivative of Pi(t)
    A(i+off1,i*4-3:i*4) = P1;
    A(i+off1,(i+1)*4-3:(i+1)*4) = -P1;
    A(i+off2,i*4-3:i*4) = P2;
    A(i+off2,(i+1)*4-3:(i+1)*4) = -P2;
end

% Populate b with its y values
for i=1:(n-1)
    b(i*2-1) = Yin(i);
    b(i*2) = Yin(i+1);
end

% SPLINE CALCULATIONS:

splineCalcRow = (n-1)*4;
if isequal(splineType, 'natural') % Natural Cubic Spline
    A(splineCalcRow-1,3:4) = [2 6*Xin(1)];
    A(splineCalcRow,(n-1)*4-1:(n-1)*4) = [2 6*Xin(n)];
    % Keep b values equal to 0
elseif isequal(splineType, 'complete') % Complete Cubic Spline
    A(splineCalcRow-1,2:4) = [1 2*Xin(1) 3*Xin(1).^2];
    A(splineCalcRow,(n-1)*4-2:(n-1)*4) = [1 2*Xin(1) 3*Xin(1).^2];
    % Sets first derivate equal to the slope at the endpoints
    b(splineCalcRow-1) = ((Yin(2)-Yin(1))/(Xin(2)-Xin(1)));
    b(splineCalcRow) = ((Yin(n)-Yin(n-1))/(Xin(n)-Xin(n-1)));
elseif isequal(splineType, 'not-a-knot') % Not-a-Knot Cubic Spline
    A(splineCalcRow-1,4) = 1;
    A(splineCalcRow-1,8) = -1;
    A(splineCalcRow,(n-1)*4) = 1;
    A(splineCalcRow,(n-2)*4) = -1;
else % Error
    error("splineType is not recognized!")
end

% Calculate coeffecients using Gaussian Elmination w/ Partial Pivoting
%   and Backwards Substitution
coef = linsolve(A, b);

%
% Calculate the spline
%

% step tells how many points in each p(x)
step = fix(num / (n-1)); % Need an integer value,
Xout = zeros((n-1) * step, 1);
Yout = zeros((n-1) * step, 1);
% Calculate values of Yout from pi(x)
for i=1:(n-1)
    x = linspace(Xin(i),Xin(i+1),step);
    y = coef(i*4-3) + coef(i*4-2)*x + coef(i*4-1)*(x.^2) + coef(i*4)*(x.^3);
    Xout((i-1) * step + 1:i*step) = x;
    Yout((i-1) * step + 1:i*step) = y;
end

end

