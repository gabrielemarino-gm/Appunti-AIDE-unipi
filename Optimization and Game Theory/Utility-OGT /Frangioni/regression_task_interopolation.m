% Given data
x = [-5 -4 -3 -2 -1 0 1 2 3 4 5];
y = [-284 -168 -88 -38 -12 -4 -8 -18 -28 -32 -24];

% Degree of the polynomial
k = 3;

% Polynomial interpolation using polyfit
coefficients = polyfit(x, y, k);

% Generate interpolated values
x_interpolated = linspace(min(x), max(x), 100);  % Adjust the number of points as needed
y_interpolated = polyval(coefficients, x_interpolated);

% Calculate Mean Square Error (MSE)
mse = mean((polyval(coefficients, x) - y).^2);

% Display the results
disp('Coefficients of the polynomial:');
disp(coefficients);

disp('Mean Square Error (MSE):');
disp(mse);

% Plot original data and interpolated polynomial
figure;
plot(x, y, 'o', x_interpolated, y_interpolated, '-');
legend('Original Data', 'Interpolated Polynomial');
xlabel('x');
ylabel('y');
title('Polynomial Interpolation');
