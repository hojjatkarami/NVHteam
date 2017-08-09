function [] = ForcePlot(t,F_1,F_2,F_3)

% Create figure
figure10 = figure;

% Create axes
axes1 = axes('Parent',figure10);
hold(axes1,'on');

F1 = rms(F_1)*ones(length(t),1);
F2 = rms(F_2)*ones(length(t),1);
F3 = rms(F_3)*ones(length(t),1);

plot1 = plot(t,F1, t,F2, t,F3, 'linewidth', 3, 'Parent',axes1);
set(plot1(1),'DisplayName','F1 (First Mount)');
set(plot1(2),'DisplayName','F2 (Second Mount)');
set(plot1(3),'DisplayName','F3 (Third Mount)');

% Create xlabel
xlabel('Time (s)','FontAngle','italic','FontSize',14,...
    'FontName','Times New Roman');

% Create ylabel
ylabel('Amplitude (N)','FontAngle','italic','FontSize',14);

% Create title
title('Transmitted Force', 'FontSize',18, 'FontName','Times New Roman');

xlim([0 t(end)]);
ylim([0 200]);
box('on');

% Set the remaining axes properties
set(axes1,'FontAngle','italic');
set(axes1,'FontAngle','italic','FontSize',14);

% Create legend
legend('show');
end