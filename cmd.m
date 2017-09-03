function cmd(text)
global tb
temp = string(get(tb,'String'));
figure(10);
if isnumeric(text)
    set(tb,'String',[temp;'>> ',num2str(text)]);
else

    set(tb,'String',[temp;'>> ',text]);

end




end