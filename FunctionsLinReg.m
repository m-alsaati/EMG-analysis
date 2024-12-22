function [m, b, y_est, residual, mse, rsq] = FunctionsLinReg(force, parameter)

%Polynomial curve fitting for line of best fit
Polyfit1 = polyfit(force, parameter,1);
m = Polyfit1(:,1);
b = Polyfit1(:,2);
y_est = polyval(Polyfit1, force);

% figure()
% scatter(force, parameter);
% hold on;

for i = 1 : length(force)
x = parameter(i);
bestline = y_est(i);
num = force(i);
line([num,num],[bestline,x])
end

% plot(force, y_est);
% title('Force Linear Regression'); 
% legend({['y=', num2str(Polyfit1(1)),'*x +', '(',num2str(Polyfit1(2)),')']}, 'Fontsize', 14, 'Location', 'southeast');
% xlabel('Force (N)');
% ylabel('Volts(V)');
% hold off;

%calcuates and stores residual values for each variable, along with its
%mean square error and correlation coefficients
residual = x - y_est;
mse = immse(force, parameter);
rsq = corrcoef(force, parameter);
% scatter(force, residual)
end