function textbox_init()
    global tb
fig_cmd = figure(10);   %this is status figure
set(fig_cmd,'Name','cmd','Units','normalized','Position',[.75 .1 .25 .8]);
tb = uicontrol('style','text');
set(tb,'Units','normalized','Position',[.05 .05 .9 .9],'String','starting...',...
        'HorizontalAlignment','left','FontSize',10);



end