function [] = AccPlot(t,x,eta,M,eng,sus,t_step)

[acc_e1, acc_b1, acc_e2, acc_b2, acc_e3, acc_b3, ~] =  acc_cal(x,eta,M,eng,sus,t_step,t(end));
% Create figure
figure11 = figure;

% Create axes
axes1 = axes('Parent',figure11);
hold(axes1,'on');

acc_1 = acc_e1(2:end,3) - acc_b1(2:end,3);
acc_2 = acc_e2(2:end,3) - acc_b2(2:end,3);
acc_3 = acc_e3(2:end,3) - acc_b3(2:end,3);

acc1 = rms(acc_1)*ones(length(t),1);
acc2 = rms(acc_2)*ones(length(t),1);
acc3 = rms(acc_3)*ones(length(t),1);

plot1 = plot(t,acc1, t,acc2, t,acc3, 'linewidth', 3, 'Parent',axes1);
set(plot1(1),'DisplayName','1 (First Mount)');
set(plot1(2),'DisplayName','2 (Second Mount)');
set(plot1(3),'DisplayName','3 (Third Mount)');

% Create xlabel
xlabel('Time (s)','FontAngle','italic','FontSize',14,...
    'FontName','Times New Roman');

% Create ylabel
ylabel('Amp Decreasent (dB)','FontAngle','italic','FontSize',14);

% Create title
title('Transmitted Vibration', 'FontSize',18, 'FontName','Times New Roman');

xlim([0 t(end)]);
ylim([10 65]);
box('on');

% Set the remaining axes properties
set(axes1,'FontAngle','italic');
set(axes1,'FontAngle','italic','FontSize',14);

% Create legend
legend('show');
end