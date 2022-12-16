function varargout = Smithchart(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Smithchart_OpeningFcn, ...
                   'gui_OutputFcn',  @Smithchart_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end
if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
function Smithchart_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
global sm;
global object;
global alpha;
global wtg;
global wtl;
global ax;
global full_smithchart;
global sudut;

%buat lingkaran
alpha = 0:.0001:pi*2;

%buat sudut
sudut = 0:.0001:pi;
sudut = [sudut, -pi:.0001:0];

%buat nilai wtg
wtg = linspace(.25, 0, length(alpha)/2);
wtg = [wtg, linspace(.5, .25, length(alpha)/2)];

%buat nilai wtl
wtl = linspace(.25, .5, length(alpha)/2) ;
wtl = [wtl, linspace(0, .25, length(alpha)/2)];

%simpan handles & buat lingkaran smithchart
axes(handles.axes1);
object = handles.axes1;
ax = gca;
smithchart(0);
hold all;
full_smithchart = plot(ax, cos(alpha), sin(alpha),'-','LineWidth',1,'Color',[0 0 0]);
axes(handles.axes4);
ImagePath = 'cobs.png';
[imaged, map] = imread(ImagePath);
d = image(imaged);
axis off;
guidata(hObject, handles);
function varargout = Smithchart_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;
function edit_zl_Callback(hObject, eventdata, handles)
function edit_zl_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function edit_vswrl_Callback(hObject, eventdata, handles)
function edit_vswrl_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function edit_rl_Callback(hObject, eventdata, handles)
function edit_rl_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function pushbutton_zl_Callback(hObject, eventdata, handles)
global object;
global selected;
global z;
axes(object);
z0 = str2double(get(handles.edit_z0, 'string'));
l = str2double(get(handles.edit_l, 'string'));
l_copy = l;
d = str2double(get(handles.edit_d, 'string'));
d_copy = d;

%variable bernilai
if (isnan(z0))
    z0 = 50;
end
if (isnan(l))
    l = 0;
else
    if (l > 1)
        l = mod(l, 1);
    elseif (l > 0.5)
        l = l - 0.5;
    end
end
if (isnan(d))
    d = 0;
else
    if (d > 1)
        d = mod(d, 1);
    elseif (d > 0.5)
        d = d - 0.5;
    end
end
z2 = gamma2z(z, z0);
if (selected == "ZIN")
    set(handles.edit_zl, 'String', num2str(z2));
end
if (selected == "ZD")
    set(handles.edit_zl, 'String', num2str(z2));
end
function pushbutton_vswrl_Callback(hObject, eventdata, handles)
global z;
global selected;
vs = abs(vswr(z));
set(handles.edit_vswrl, 'String', num2str(vs));
axes(handles.axes2);
if (selected == "ZL")
    plot([0, vs], [0, 0],'-','LineWidth',1.0,'Color',[1 0 0]);
elseif (selected == "ZIN")
    plot([0, vs], [0, 0],'-','LineWidth',1.0,'Color',[0 0 1]);
elseif (selected == "ZD")
    plot([0, vs], [0, 0],'-','LineWidth',1.0,'Color',[0 1 0]);
end
xlim([0, 10]);
xticks([0 .5 1 1.5 2 2.5 3 3.5 4 4.5 5 5.5 6 6.5 7 7.5 8 8.5 9 9.5 10]);
function pushbutton_rl_Callback(hObject, eventdata, handles)
global g;
global sdt;
global selected;
koefis = [0,0;real(g),imag(g)];
koefis = pdist(koefis,'euclidean');
str1 = " < ";
str2 = " °";
str3 = num2str(koefis);
str4 = num2str(sdt);
newStr1 = strcat(str3, str1);
newStr2 = strcat(str4, str2);
newStr3 = strcat(newStr1, newStr2);
set(handles.edit_rl, 'String', newStr3);
axes(handles.axes3);
if (selected == "ZL")
    plot([0, koefis], [0, 0],'-','LineWidth',1.0,'Color',[1 0 0]);
elseif (selected == "ZIN")
    plot([0, koefis], [0, 0],'-','LineWidth',1.0,'Color',[0 0 1]);
elseif (selected == "ZD")
    plot([0, koefis], [0, 0],'-','LineWidth',1.0,'Color',[0 1 0]);
end
xlim([0, 10]);
xticks([0 .5 1 1.5 2 2.5 3 3.5 4 4.5 5 5.5 6 6.5 7 7.5 8 8.5 9 9.5 10]);
function edit_zin_Callback(hObject, eventdata, handles)
function edit_zin_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function edit_vswrin_Callback(hObject, eventdata, handles)
function edit_vswrin_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function edit_rin_Callback(hObject, eventdata, handles)
function edit_rin_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function pushbutton_zin_Callback(hObject, eventdata, handles)
global object;
global selected;
global z;
axes(object);
z0 = str2double(get(handles.edit_z0, 'string'));
l = str2double(get(handles.edit_l, 'string'));
l_copy = l;
d = str2double(get(handles.edit_d, 'string'));
d_copy = d;

%variable bernilai
if (isnan(z0))
    z0 = 50;
end
if (isnan(l))
    l = 0;
else
    if (l > 1)
        l = mod(l, 1);
    elseif (l > 0.5)
        l = l - 0.5;
    end
end
if (isnan(d))
    d = 0;
else
    if (d > 1)
        d = mod(d, 1);
    elseif (d > 0.5)
        d = d - 0.5;
    end
end
z2 = gamma2z(z, z0);
if (selected == "ZL")
    set(handles.edit_zin, 'String', num2str(z2));
end
if (selected == "ZD")
    set(handles.edit_zin, 'String', num2str(z2));
end
function pushbutton_vswrin_Callback(hObject, eventdata, handles)
global z;
global selected;
vs = abs(vswr(z));
set(handles.edit_vswrin, 'String', num2str(vs));
axes(handles.axes2);
if (selected == "ZL")
    plot([0, vs], [0, 0],'-','LineWidth',1.0,'Color',[1 0 0]);
elseif (selected == "ZIN")
    plot([0, vs], [0, 0],'-','LineWidth',1.0,'Color',[0 0 1]);
elseif (selected == "ZD")
    plot([0, vs], [0, 0],'-','LineWidth',1.0,'Color',[0 1 0]);
end
xlim([0, 10]);
xticks([0 .5 1 1.5 2 2.5 3 3.5 4 4.5 5 5.5 6 6.5 7 7.5 8 8.5 9 9.5 10]);
function pushbutton_rin_Callback(hObject, eventdata, handles)
global g;
global sdt;
global selected;
koefis = [0,0;real(g),imag(g)];
koefis = pdist(koefis,'euclidean');
str1 = " < ";
str2 = " °";
str3 = num2str(koefis);
str4 = num2str(sdt);
newStr1 = strcat(str3, str1);
newStr2 = strcat(str4, str2);
newStr3 = strcat(newStr1, newStr2);
set(handles.edit_rin, 'String', newStr3);
axes(handles.axes3);
if (selected == "ZL")
    plot([0, koefis], [0, 0],'-','LineWidth',1.0,'Color',[1 0 0]);
elseif (selected == "ZIN")
    plot([0, koefis], [0, 0],'-','LineWidth',1.0,'Color',[0 0 1]);
elseif (selected == "ZD")
    plot([0, koefis], [0, 0],'-','LineWidth',1.0,'Color',[0 1 0]);
end
xlim([0, 10]);
xticks([0 .5 1 1.5 2 2.5 3 3.5 4 4.5 5 5.5 6 6.5 7 7.5 8 8.5 9 9.5 10]);
function edit_zd_Callback(hObject, eventdata, handles)
function edit_zd_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function edit_vswrd_Callback(hObject, eventdata, handles)
function edit_vswrd_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_rd_Callback(hObject, eventdata, handles)
function edit_rd_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function pushbutton_zd_Callback(hObject, eventdata, handles)
global object;
global selected;
global z;
axes(object);
z0 = str2double(get(handles.edit_z0, 'string'));
l = str2double(get(handles.edit_l, 'string'));
l_copy = l;
d = str2double(get(handles.edit_d, 'string'));
d_copy = d;
%variable bernilai
if (isnan(z0))
    z0 = 50;
end
if (isnan(l))
    l = 0;
else
    if (l > 1)
        l = mod(l, 1);
    elseif (l > 0.5)
        l = l - 0.5;
    end
end
if (isnan(d))
    d = 0;
else
    if (d > 1)
        d = mod(d, 1);
    elseif (d > 0.5)
        d = d - 0.5;
    end
end

if (selected == "ZL")
    z2 = gamma2z(z, z0);
    set(handles.edit_zd, 'String', num2str(z2));
elseif (selected == "ZIN")
    z2 = gamma2z(z, z0);
    set(handles.edit_zd, 'String', num2str(z2));
end
function pushbutton_vswrd_Callback(hObject, eventdata, handles)
global z;
vs = abs(vswr(z));
set(handles.edit_vswrd, 'String', num2str(vs));
function pushbutton_rd_Callback(hObject, eventdata, handles)
global g;
global sdt;
koefis = [0,0;real(g),imag(g)];
koefis = pdist(koefis,'euclidean');
str1 = " < ";
str2 = " °";
str3 = num2str(koefis);
str4 = num2str(sdt);
newStr1 = strcat(str3, str1);
newStr2 = strcat(str4, str2);
newStr3 = strcat(newStr1, newStr2);
set(handles.edit_rd, 'String', newStr3);

function edit_z0_Callback(hObject, eventdata, handles)
function edit_z0_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function edit_l_Callback(hObject, eventdata, handles)
function edit_l_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function edit_d_Callback(hObject, eventdata, handles)
function edit_d_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function pushbutton_plot_Callback(hObject, eventdata, handles)
global sm;
global object;
global alpha;
global wtg;
global wtl;
global ax;
global full_smithchart;
global sudut;
global selected;
global sdt;
global diff_size;
global new_z;
global g;
global z;

axes(object);

z0 = str2double(get(handles.edit_z0, 'string'));
z = str2double(get(handles.edit_z, 'string'));
if (z <0)
     uiwait(msgbox('error!! bilangan real bernilai negatif','!!'));
return;
end
l = str2double(get(handles.edit_l, 'string'));
d = str2double(get(handles.edit_d, 'string'));

%variable bernilai
if (isnan(z0))
    z0 = 50;
end
if (isnan(l))
    l = 0;
else
    if (l > 1)
        l = mod(l, 1);
    elseif (l > 0.5)
        l = l - 0.5;
    end
end
if (isnan(d))
    d = 0;
else
    if (d > 1)
        d = mod(d, 1);
    elseif (d > 0.5)
        d = d - 0.5;
    end
end

g = z2gamma(z, z0);

r = abs(g);


circle_z = plot(ax, r*cos(alpha), r*sin(alpha), '-', 'LineWidth', 1.0, 'Color', [1 0 0]);
    
plot(ax, real(g), imag(g), 'ro','LineWidth', 1.0);

diff_size = full_smithchart.XData(1)/circle_z.XData(1);
    
plot(ax, [0, real(g)*diff_size], [0, imag(g)*diff_size], '-', 'LineWidth', 1.0, 'Color', [1 0 0]);

new_z = plot(ax, [real(g)*diff_size], [imag(g)*diff_size],'ro','LineWidth',1.0);

%vswr
vs = abs(vswr(g));

%koefisien pantul
koefis = [0,0; real(g),imag(g)];
koefis = pdist(koefis,'euclidean');

if (selected == "ZL")
    for n = 1 : length(alpha)
        if (round(new_z.XData(1), 4) == round(full_smithchart.XData(n), 4))
            if (imag(z) > 0)
                sdt =  -(180*sudut(n))/pi;
            else
                sdt =  (180*sudut(n))/pi;
            end
        end
    end
    
    circle_z = plot(ax, r*cos(alpha), r*sin(alpha), '-', 'LineWidth', 1.0, 'Color', [1 0 0]);
    
    plot(ax, real(g), imag(g), 'ro','LineWidth', 1.0);

    diff_size = full_smithchart.XData(1)/circle_z.XData(1);
    
    plot(ax, [0, real(g)*diff_size], [0, imag(g)*diff_size], '-', 'LineWidth', 1.0, 'Color', [1 0 0]);

    new_z = plot(ax, [real(g)*diff_size], [imag(g)*diff_size],'ro','LineWidth',1.0);
    
    zn = z/z0;
    zn = real(zn)+(imag(zn)*j);
    set(handles.edit15, 'string' ,num2str(zn));

    str1 = " < ";
    str2 = " °";
    str3 = num2str(koefis);
    str4 = num2str(sdt);
    newStr1 = strcat(str3, str1);
    newStr2 = strcat(str4, str2);
    newStr3 = strcat(newStr1, newStr2);
    set(handles.edit_zl, 'String', num2str(z));
    set(handles.edit_vswrl, 'String', num2str(vs));
    set(handles.edit_rl, 'String', newStr3);
    
    axes(handles.axes2);
    plot([0, vs], [0, 0],'-','LineWidth',1.0,'Color',[1 0 0]);
    xlim([0, 10]);
    xticks([0 .5 1 1.5 2 2.5 3 3.5 4 4.5 5 5.5 6 6.5 7 7.5 8 8.5 9 9.5 10]);
    
    axes(handles.axes3);
    plot([0, koefis], [0, 0],'-','LineWidth',1.0,'Color',[1 0 0]);
    xlim([0, 10]);
    xticks([0 .5 1 1.5 2 2.5 3 3.5 4 4.5 5 5.5 6 6.5 7 7.5 8 8.5 9 9.5 10]);
elseif (selected == "ZIN")
    for n = 1 : length(alpha)
        if (round(new_z.XData(1), 4) == round(full_smithchart.XData(n), 4))
            if (imag(z) > 0)
                sdt =  -(180*sudut(n))/pi;
            else
                sdt =  (180*sudut(n))/pi;
            end
        end
    end
    circle_z = plot(ax, r*cos(alpha), r*sin(alpha), '-', 'LineWidth', 1.0, 'Color', [0 0 1]);
    
    plot(ax, real(g), imag(g), 'bo','LineWidth', 1.0);

    diff_size = full_smithchart.XData(1)/circle_z.XData(1);
    
    plot(ax, [0, real(g)*diff_size], [0, imag(g)*diff_size], '-', 'LineWidth', 1.0, 'Color', [0 0 1]);

    new_z = plot(ax, [real(g)*diff_size], [imag(g)*diff_size],'bo','LineWidth',1.0);
    
     zn = z/z0;
     zn = real(zn)+(imag(zn)*j);
    set(handles.edit17, 'string' , num2str(zn));

    str1 = " < ";
    str2 = " °";
    str3 = num2str(koefis);
    str4 = num2str(sdt);
    newStr1 = strcat(str3, str1);
    newStr2 = strcat(str4, str2);
    newStr3 = strcat(newStr1, newStr2);
    set(handles.edit_zin, 'String', num2str(z));
    set(handles.edit_vswrin, 'String', num2str(vs));
    set(handles.edit_rin, 'String', newStr3);
    axes(handles.axes2);
    plot([0, vs], [0, 0],'-','LineWidth',1.0,'Color',[0 0 1]);
    xlim([0, 10]);
    xticks([0 .5 1 1.5 2 2.5 3 3.5 4 4.5 5 5.5 6 6.5 7 7.5 8 8.5 9 9.5 10]);
    
    axes(handles.axes3);
    plot([0, koefis], [0, 0],'-','LineWidth',1.0,'Color',[0 0 1]);
    xlim([0, 10]);
    xticks([0 .5 1 1.5 2 2.5 3 3.5 4 4.5 5 5.5 6 6.5 7 7.5 8 8.5 9 9.5 10]);
elseif (selected == "ZD")
    for n = 1 : length(alpha)
        if (round(new_z.XData(1), 4) == round(full_smithchart.XData(n), 4))
            if (imag(z) > 0)
                sdt =  -(180*sudut(n))/pi;
            else
                sdt =  (180*sudut(n))/pi;
            end
        end
    end
    circle_z = plot(ax, r*cos(alpha), r*sin(alpha), '-', 'LineWidth', 1.0, 'Color', [0 1 0]);
    
    plot(ax, real(g), imag(g), 'go','LineWidth', 1.0);

    diff_size = full_smithchart.XData(1)/circle_z.XData(1);
    
    plot(ax, [0, real(g)*diff_size], [0, imag(g)*diff_size], '-', 'LineWidth', 1.0, 'Color', [0 1 0]);

    new_z = plot(ax, [real(g)*diff_size], [imag(g)*diff_size],'go','LineWidth',1.0);
    
    
    zn = z/z0;
    zn = real(zn)+(imag(zn)*j);
    set(handles.edit16, 'string' ,num2str(zn));

    str1 = " < ";
    str2 = " °";
    str3 = num2str(koefis);
    str4 = num2str(sdt);
    newStr1 = strcat(str3, str1);
    newStr2 = strcat(str4, str2);
    newStr3 = strcat(newStr1, newStr2);
    set(handles.edit_zd, 'String', num2str(z));
    set(handles.edit_vswrd, 'String', num2str(vs));
    set(handles.edit_rd, 'String', newStr3);
    axes(handles.axes2);
    plot([0, vs], [0, 0],'-','LineWidth',1.0,'Color',[0 1 0]);
    xlim([0, 10]);
    xticks([0 .5 1 1.5 2 2.5 3 3.5 4 4.5 5 5.5 6 6.5 7 7.5 8 8.5 9 9.5 10]);
    
    axes(handles.axes3);
    plot([0, koefis], [0, 0],'-','LineWidth',1.0,'Color',[0 1 0]);
    xlim([0, 10]);
    xticks([0 .5 1 1.5 2 2.5 3 3.5 4 4.5 5 5.5 6 6.5 7 7.5 8 8.5 9 9.5 10]);
end

function axes1_CreateFcn(hObject, eventdata, handles)
function radiobutton_zl_Callback(hObject, eventdata, handles)
global selected;
selected = "ZL";
set(handles.text_z, 'String', 'ZL');
%
set(handles.edit_zl, 'Enable', 'inactive');
set(handles.edit_vswrl,  'Enable', 'inactive');
set(handles.edit_rl,  'Enable', 'inactive');
set(handles.pushbutton_zl, 'Enable', 'inactive');
set(handles.pushbutton_vswrl,  'Enable', 'inactive');
set(handles.pushbutton_rl,  'Enable', 'inactive');
set(handles.pushbutton12, 'Enable', 'inactive')
set(handles.edit15, 'Enable', 'inactive')
%
set(handles.edit_zin, 'Enable', 'on');
set(handles.edit_vswrin,  'Enable', 'on');
set(handles.edit_rin,  'Enable', 'on');
set(handles.pushbutton_zin, 'Enable', 'on');
set(handles.pushbutton_vswrin,  'Enable', 'on');
set(handles.pushbutton_rin,  'Enable', 'on');
set(handles.pushbutton11, 'Enable', 'on')
set(handles.edit17, 'Enable', 'on')
%
set(handles.edit_zd, 'Enable', 'on');
set(handles.edit_vswrd,  'Enable', 'on');
set(handles.edit_rd,  'Enable', 'on');
set(handles.pushbutton_zd, 'Enable', 'on');
set(handles.pushbutton_vswrd,  'Enable', 'on');
set(handles.pushbutton_rd,  'Enable', 'on');
set(handles.pushbutton13, 'Enable', 'on')
set(handles.edit16, 'Enable', 'on')
function uibuttongroup1_CreateFcn(hObject, eventdata, handles)
global selected;
selected = 'ZL';
function radiobutton_zin_Callback(hObject, eventdata, handles)
global selected;
selected = "ZIN";
set(handles.text_z, 'String', 'ZIN');
%
set(handles.edit_zl, 'Enable', 'on');
set(handles.edit_vswrl,  'Enable', 'on');
set(handles.edit_rl,  'Enable', 'on');
set(handles.pushbutton_zl, 'Enable', 'on');
set(handles.pushbutton_vswrl,  'Enable', 'on');
set(handles.pushbutton_rl,  'Enable', 'on');
set(handles.pushbutton12, 'Enable', 'on')
set(handles.edit15, 'Enable', 'on')
%
set(handles.edit_zin, 'Enable', 'inactive');
set(handles.edit_vswrin,  'Enable', 'inactive');
set(handles.edit_rin,  'Enable', 'inactive');
set(handles.pushbutton_zin, 'Enable', 'inactive');
set(handles.pushbutton_vswrin,  'Enable', 'inactive');
set(handles.pushbutton_rin,  'Enable', 'inactive');
set(handles.pushbutton11, 'Enable', 'inactive')
set(handles.edit17, 'Enable', 'inactive')
%
set(handles.edit_zd, 'Enable', 'on');
set(handles.edit_vswrd,  'Enable', 'on');
set(handles.edit_rd,  'Enable', 'on');
set(handles.pushbutton_zd, 'Enable', 'on');
set(handles.pushbutton_vswrd,  'Enable', 'on');
set(handles.pushbutton_rd,  'Enable', 'on');
set(handles.pushbutton13, 'Enable', 'on')
set(handles.edit16, 'Enable', 'on')
function radiobutton_zd_Callback(hObject, eventdata, handles)
global selected;
selected = "ZD";
set(handles.text_z, 'String', 'ZD');
%
set(handles.edit_zl, 'Enable', 'on');
set(handles.edit_vswrl,  'Enable', 'on');
set(handles.edit_rl,  'Enable', 'on');
set(handles.pushbutton_zl, 'Enable', 'on');
set(handles.pushbutton_vswrl,  'Enable', 'on');
set(handles.pushbutton_rl,  'Enable', 'on');
set(handles.pushbutton12, 'Enable', 'on')
set(handles.edit15, 'Enable', 'on')
%
set(handles.edit_zin, 'Enable', 'on');
set(handles.edit_vswrin,  'Enable', 'on');
set(handles.edit_rin,  'Enable', 'on');
set(handles.pushbutton_zin, 'Enable', 'on');
set(handles.pushbutton_vswrin,  'Enable', 'on');
set(handles.pushbutton_rin,  'Enable', 'on');
set(handles.pushbutton11, 'Enable', 'on')
set(handles.edit17, 'Enable', 'on')
%
set(handles.edit_zd, 'Enable', 'inactive');
set(handles.edit_vswrd,  'Enable', 'inactive');
set(handles.edit_rd,  'Enable', 'inactive');
set(handles.pushbutton_zd, 'Enable', 'inactive');
set(handles.pushbutton_vswrd,  'Enable', 'inactive');
set(handles.pushbutton_rd,  'Enable', 'inactive');
set(handles.pushbutton13, 'Enable', 'inactive')
set(handles.edit16, 'Enable', 'inactive')
function edit_z_Callback(hObject, eventdata, handles)
global z;

if(z <0)
    errordlg("bilangan real bernilai negatif","Input error !!");
end

function edit_z_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function axes4_CreateFcn(hObject, eventdata, handles)
function edit15_Callback(hObject, eventdata, handles)
function edit15_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function edit16_Callback(hObject, eventdata, handles)
function edit16_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function edit17_Callback(hObject, eventdata, handles)
function edit17_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function pushbutton11_Callback(hObject, eventdata, handles)
global sm;
global object;
global alpha;
global wtg;
global wtl;
global ax;
global full_smithchart;
global sudut;
global selected;
global sdt;
global diff_size;
global new_z;
global z;

axes(object);

z0 = str2double(get(handles.edit_z0, 'string'));
z = str2double(get(handles.edit_z, 'string'));
l = str2double(get(handles.edit_l, 'string'));
l_copy = l;
d = str2double(get(handles.edit_d, 'string'));
d_copy = d;

%variable bernilai
if (isnan(z0))
    z0 = 50;
end
if (isnan(l))
    l = 0;
else
    if (l > 1)
        l = mod(l, 1);
    elseif (l > 0.5)
        l = l - 0.5;
    end
end
if (isnan(d))
    d = 0;
else
    if (d > 1)
        d = mod(d, 1);
    elseif (d > 0.5)
        d = d - 0.5;
    end
end

if (selected == "ZL")
    for n = 1 : length(alpha)
        if(round(new_z.XData(1), 4) == round(full_smithchart.XData(n), 4))
           if(imag(z) < 0)
               d_move = wtl(n) + l;
            else
               d_move = wtg(n) + l;
           end
           break;
        end
    end
    if(d_move > 0.5)
      d_move = mod(d_move, 0.5); 
    end
    for n = 1 : length(alpha)
        if(round(d_move, 4) == round(wtg(n), 4))
                z_new = plot(ax, cos(alpha(n)),sin(alpha(n)),'ro','LineWidth',1.5, 'Color',[0 0 1]);
                sdt =  (180*sudut(n))/pi;
                a = text(cos(alpha(n)),sin(alpha(n)),'  \theta','HorizontalAlignment','right');
                a.Color = 'blue';
                a.FontSize = 14;
                break;
        end
    end
    z_plot = plot(ax,[z_new.XData(1), 0], [z_new.YData(1) , 0],'Color',[0 0 1],'LineWidth',1);
    z_point_plot = plot(ax,[z_new.XData(1)/diff_size], [z_new.YData(1)/diff_size],'bo', 'LineWidth',1.5);
    z = z_point_plot.XData(1)+(z_point_plot.YData(1)*j);
    z2 = gamma2z(z, z0);
    z2 = z2/z0;
end
if (selected == "ZD")
    temp = l_copy - d_copy;
    if (temp > 0.5)
       temp = mod(temp, 0.5);
    end
    for n = 1 : length(alpha)
        if(round(new_z.XData(1), 4) == round(full_smithchart.XData(n), 4))
           if(imag(z) < 0)
               d_move = wtl(n) + temp;
            else
               d_move = wtg(n) + temp;
           end
           break;
        end
    end
    if(d_move > 0.5)
      d_move = mod(d_move, 0.5); 
    end
    for n = 1 : length(alpha)
        if(round(d_move, 4) == round(wtg(n), 4))
                z_new = plot(ax, cos(alpha(n)),sin(alpha(n)),'ro','LineWidth',1.5, 'Color',[0 0 1]);
                sdt =  (180*sudut(n))/pi;
                a = text(cos(alpha(n)),sin(alpha(n)),'  \theta','HorizontalAlignment','right');
                a.Color = 'blue';
                a.FontSize = 14;
                break;
        end
    end
    z_plot = plot(ax,[z_new.XData(1), 0], [z_new.YData(1) , 0],'Color',[0 0 1],'LineWidth',1);
    z_point_plot = plot(ax,[z_new.XData(1)/diff_size], [z_new.YData(1)/diff_size],'bo', 'LineWidth',1.5);
    z = z_point_plot.XData(1)+(z_point_plot.YData(1)*j);
    z2 = gamma2z(z, z0);
    z2 = z2/z0;
end
disp(z_point_plot);
set(handles.edit17, 'String', num2str(z2));
function pushbutton12_Callback(hObject, eventdata, handles)
global sm;
global object;
global alpha;
global wtg;
global wtl;
global ax;
global full_smithchart;
global sudut;
global selected;
global sdt;
global diff_size;
global new_z;
global z;

axes(object);

z0 = str2double(get(handles.edit_z0, 'string'));
z = str2double(get(handles.edit_z, 'string'));
l = str2double(get(handles.edit_l, 'string'));
l_copy = l;
d = str2double(get(handles.edit_d, 'string'));
d_copy = d;

%variable bernilai
if (isnan(z0))
    z0 = 50;
end
if (isnan(l))
    l = 0;
else
    if (l > 1)
        l = mod(l, 1);
    elseif (l > 0.5)
        l = l - 0.5;
    end
end
if (isnan(d))
    d = 0;
else
    if (d > 1)
        d = mod(d, 1);
    elseif (d > 0.5)
        d = d - 0.5;
    end
end

if (selected == "ZIN")
    for n = 1 : length(alpha)
        if(round(new_z.XData(1), 4) == round(full_smithchart.XData(n), 4))
           if(imag(z) < 0)
               d_move = wtg(n) + l;
            else
               d_move = wtl(n) + l;
           end
           break;
        end
    end
    if(d_move > 0.5)
      d_move = mod(d_move, 0.5); 
    end
    for n = 1 : length(alpha)
        if(round(d_move, 4) == round(wtl(n), 4))
                z_new = plot(ax, cos(alpha(n)),sin(alpha(n)),'ro','LineWidth',1.5, 'Color',[1 0 0]);
                sdt =  (180*sudut(n))/pi;
                a = text(cos(alpha(n)),sin(alpha(n)),'  \theta','HorizontalAlignment','right');
                a.Color = 'red';
                a.FontSize = 14;
                break;
        end
    end
    z_plot = plot(ax,[z_new.XData(1), 0], [z_new.YData(1) , 0],'Color',[1 0 0],'LineWidth',1);
    z_point_plot = plot(ax,[z_new.XData(1)/diff_size], [z_new.YData(1)/diff_size],'ro', 'LineWidth',1.5);
    z = z_point_plot.XData(1)+(z_point_plot.YData(1)*j);
    z2 = gamma2z(z, z0);
    z2 = z2/z0
end
if (selected == "ZD")
    temp = l_copy - d_copy;
    disp(temp);
    temp = l_copy + temp;
    if (temp > 0.5)
        temp = mod(temp, 0.5);
    end
    for n = 1 : length(alpha)
        if(round(new_z.XData(1), 4) == round(full_smithchart.XData(n), 4))
           if(imag(z) < 0)
               d_move = wtg(n) + temp;
            else
               d_move = wtl(n) + temp;
           end
           break;
        end
    end
    if(d_move > 0.5)
      d_move = mod(d_move, 0.5); 
    end
    for n = 1 : length(alpha)
        if(round(d_move, 4) == round(wtl(n), 4))
                z_new = plot(ax, cos(alpha(n)),sin(alpha(n)),'ro','LineWidth',1.5, 'Color',[1 0 0]);
                sdt =  (180*sudut(n))/pi;
                a = text(cos(alpha(n)),sin(alpha(n)),'  \theta','HorizontalAlignment','right');
                a.Color = 'red';
                a.FontSize = 14;
                break;
        end
    end
    z_plot = plot(ax,[z_new.XData(1), 0], [z_new.YData(1) , 0],'Color',[1 0 0],'LineWidth',1);
    z_point_plot = plot(ax,[z_new.XData(1)/diff_size], [z_new.YData(1)/diff_size],'ro', 'LineWidth',1.5);
    z = z_point_plot.XData(1)+(z_point_plot.YData(1)*j);
    z2 = gamma2z(z, z0);
    z2 = z2/z0;
end
set(handles.edit15, 'String', num2str(z2));
function pushbutton13_Callback(hObject, eventdata, handles)
global sm;
global object;
global alpha;
global wtg;
global wtl;
global ax;
global full_smithchart;
global sudut;
global selected;
global sdt;
global diff_size;
global new_z;
global z;

axes(object);

z0 = str2double(get(handles.edit_z0, 'string'));
z = str2double(get(handles.edit_z, 'string'));
l = str2double(get(handles.edit_l, 'string'));
l_copy = l;
d = str2double(get(handles.edit_d, 'string'));
d_copy = d;

%variable bernilai
if (isnan(z0))
    z0 = 50;
end
if (isnan(l))
    l = 0;
else
    if (l > 1)
        l = mod(l, 1);
    elseif (l > 0.5)
        l = l - 0.5;
    end
end
if (isnan(d))
    d = 0;
else
    if (d > 1)
        d = mod(d, 1);
    elseif (d > 0.5)
        d = d - 0.5;
    end
end

if (selected == "ZL")
    for n = 1 : length(alpha)
        if(round(new_z.XData(1), 4) == round(full_smithchart.XData(n), 4))
           if(imag(z) < 0)
               d_move = wtl(n) + d;
            else
               d_move = wtg(n) + d;
           end
           break;
        end
    end
    if(d_move > 0.5)
      d_move = mod(d_move, 0.5); 
    end
    for n = 1 : length(alpha)
        if(round(d_move, 4) == round(wtg(n), 4))
                z_new = plot(ax, cos(alpha(n)),sin(alpha(n)),'ro','LineWidth',1.5, 'Color',[0 1 0]);
                sdt =  (180*sudut(n))/pi;
                a = text(cos(alpha(n)),sin(alpha(n)),'  \theta','HorizontalAlignment','right');
                a.Color = 'green';
                a.FontSize = 14;
                break;
        end
    end
    z_plot = plot(ax,[z_new.XData(1), 0], [z_new.YData(1) , 0],'Color',[0 1 0],'LineWidth',1);
    z_point_plot = plot(ax,[z_new.XData(1)/diff_size], [z_new.YData(1)/diff_size],'go', 'LineWidth',1.5);
    z = z_point_plot.XData(1)+(z_point_plot.YData(1)*j);
    z2 = gamma2z(z, z0);
    z2 = z2/z0;
    
elseif (selected == "ZIN")
    for n = 1 : length(alpha)
        if(round(new_z.XData(1), 4) == round(full_smithchart.XData(n), 4))
           if(imag(z) < 0)
               d_move = wtg(n) + d;
            else
               d_move = wtl(n) + d;
           end
           break;
        end
    end
    if(d_move > 0.5)
      d_move = mod(d_move, 0.5); 
    end
    for n = 1 : length(alpha)
        if(round(d_move, 4) == round(wtl(n), 4))
                z_new = plot(ax, cos(alpha(n)),sin(alpha(n)),'ro','LineWidth',1.5, 'Color',[0 1 0]);
                sdt =  (180*sudut(n))/pi;
                a = text(cos(alpha(n)),sin(alpha(n)),'  \theta','HorizontalAlignment','right');
                a.Color = 'green';
                a.FontSize = 14;
                break;
        end
    end
    z_plot = plot(ax,[z_new.XData(1), 0], [z_new.YData(1) , 0],'Color',[0 1 0],'LineWidth',1);
    z_point_plot = plot(ax,[z_new.XData(1)/diff_size], [z_new.YData(1)/diff_size],'go', 'LineWidth',1.5);
    z = z_point_plot.XData(1)+(z_point_plot.YData(1)*j);
    z2 = gamma2z(z, z0);
    z2 = z2/z0;
end


set(handles.edit16, 'String', num2str(z2));
function pushbutton_vswrl_CreateFcn(hObject, eventdata, handles)
function reset_Callback(hObject, eventdata, handles)
global object;
global alpha;
global full_smithchart;
global ax;
set(handles.edit_z0, 'String', '');
set(handles.edit_z, 'String', '');
set(handles.edit_l, 'String', '');
set(handles.edit_d, 'String', '');
set(handles.edit_zl, 'String', '');
set(handles.edit_zin, 'String', '');
set(handles.edit_zd, 'String', '');
set(handles.edit15, 'String', '');
set(handles.edit16, 'String', '');
set(handles.edit17, 'String', '');
set(handles.edit_vswrl, 'String', '');
set(handles.edit_vswrin, 'String', '');
set(handles.edit_vswrd, 'String', '');
set(handles.edit_rl, 'String', '');
set(handles.edit_rin, 'String', '');
set(handles.edit_rd, 'String', '');

axes(handles.axes2);
cla('reset');
axes(handles.axes3);
cla('reset');
axes(object);
cla('reset', ax);
hs = smithchart(0);
hold all;
full_smithchart= plot(ax, cos(alpha), sin(alpha),'-','LineWidth',1,'Color',[0 0 0]);
function edit18_Callback(hObject, eventdata, handles)
function edit18_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
