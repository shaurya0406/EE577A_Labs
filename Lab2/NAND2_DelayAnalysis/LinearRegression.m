function LinearRegression(filename)
% Define the row indices for the desired cells
row_indices = 5:5:55;  % This covers D5, D10, D15, and D20
num_values = length(row_indices);

% Loop through the row indices and read the corresponding cells
cell_address = sprintf('D%d', 1);
delayValues = readmatrix(filename, 'Range', cell_address);
WorstRiseDelay = delayValues(row_indices);
WorstFallDelay = delayValues(row_indices+1);

% Define corresponding Cz values (as per the image)
CapOut = 0:100:1000;

% Perform linear regression
pR = polyfit(CapOut, WorstRiseDelay, 1);
pF = polyfit(CapOut, WorstFallDelay, 1);

% Display the linear regression coefficients
fprintf('Linear regression formula for worst-case rising: Delay = %.15f * CapOut + %.15f\n', pR(1), pR(2));
fprintf('Linear regression formula for worst-case falling: Delay = %.15f * CapOut + %.15f\n', pF(1), pF(2));

% plot the data and the linear fit
figure;
subplot(2,1,1)
plot(CapOut, WorstRiseDelay, 'bo', 'MarkerSize', 10, 'DisplayName', 'Data Points');
hold on;
plot(CapOut, polyval(pR, CapOut), 'r-', 'LineWidth', 2, 'DisplayName', 'Linear Fit');
xlabel('CapOut Values');
ylabel('Delay Values');
title('Linear Regression of Rise values vs. CapOut values');
legend show;
grid on;

subplot(2,1,2)
plot(CapOut, WorstFallDelay, 'bo', 'MarkerSize', 10, 'DisplayName', 'Data Points');
hold on;
plot(CapOut, polyval(pF, CapOut), 'r-', 'LineWidth', 2, 'DisplayName', 'Linear Fit');
xlabel('CapOut Values');
ylabel('Delay Values');
title('Linear Regression of Fall values vs. CapOut values');
legend show;
grid on;
end