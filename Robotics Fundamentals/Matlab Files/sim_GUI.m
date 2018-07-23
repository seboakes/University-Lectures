function varargout = sim_GUI(varargin)
% SIM_GUI MATLAB code for sim_GUI.fig
%      SIM_GUI, by itself, creates a new SIM_GUI or raises the existing
%      singleton*.
%
%      H = SIM_GUI returns the handle to a new SIM_GUI or the handle to
%      the existing singleton*.
%
%      SIM_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SIM_GUI.M with the given input arguments.
%
%      SIM_GUI('Property','Value',...) creates a new SIM_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before sim_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to sim_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help sim_GUI

% Last Modified by GUIDE v2.5 29-Mar-2014 12:11:10

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @sim_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @sim_GUI_OutputFcn, ...
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
% End initialization code - DO NOT EDIT


% --- Executes just before sim_GUI is made visible.
function sim_GUI_OpeningFcn(hObject, ~, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to sim_GUI (see VARARGIN)

% Choose default command line output for sim_GUI
handles.output = hObject;
handles.L1=3;
L2=7;
handles.L3=6;
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes sim_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = sim_GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function x_position_Callback(hObject, eventdata, handles)
% hObject    handle to x_position (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of x_position as text
%        str2double(get(hObject,'String')) returns contents of x_position as a double
xpos=str2double(get(hObject,'String'));
%check for errors
if isnan(xpos)
    set(hObject, 'String', 0);
    errordlg('Input must be a number','Error');
end
% Save the new volume value
handles.xpos = xpos;
guidata(hObject,handles)


% --- Executes during object creation, after setting all properties.
function x_position_CreateFcn(hObject, eventdata, handles)
% hObject    handle to x_position (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function y_position_Callback(hObject, eventdata, handles)
% hObject    handle to y_position (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of y_position as text
%        str2double(get(hObject,'String')) returns contents of y_position as a double
ypos=str2double(get(hObject,'String'));
%check for errors
if isnan(ypos)
    set(hObject, 'String', 0);
    errordlg('Input must be a number','Error');
end
% Save the new volume value
handles.ypos = ypos;
guidata(hObject,handles)



% --- Executes during object creation, after setting all properties.
function y_position_CreateFcn(hObject, eventdata, handles)
% hObject    handle to y_position (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function z_position_Callback(hObject, eventdata, handles)
% hObject    handle to z_position (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of z_position as text
%        str2double(get(hObject,'String')) returns contents of z_position as a double

zpos=str2double(get(hObject,'String'));
%check for errors
if isnan(zpos)
    set(hObject, 'String', 0);
    errordlg('Input must be a number','Error');
end
% Save the new volume value
handles.zpos = zpos;
guidata(hObject,handles)
% --- Executes during object creation, after setting all properties.
function z_position_CreateFcn(hObject, eventdata, handles)
% hObject    handle to z_position (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in sim_button.
function sim_button_Callback(hObject, eventdata, handles)
% hObject    handle to sim_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in reset_button.
function reset_button_Callback(hObject, eventdata, handles)
% hObject    handle to reset_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with 0handles and user data (see GUIDATA)
handles.path=[0 0 0];
handles.x_current=0.0;
handles.y_current= 0.8515;
handles.z_current= 10;

xf=0.0;
yf=3;
zf=7;


path_temp=GUI_Movie(handles.path,xf,yf,zf,handles.x_current,handles.y_current, handles.z_current);

handles.path=vertcat(handles.path,path_temp);


 update(hObject, eventdata, handles);


handles.x_current=xf;
handles.y_current=yf;
handles.z_current= zf;


guidata(hObject,handles)


% --- Executes on button press in x_plus.
function x_plus_Callback(hObject, eventdata, handles)
% hObject    handle to x_plus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
xc=handles.x_current;
yc=handles.y_current;
zc=handles.z_current;
xf=xc+1.5;
yf=yc;
zf=zc;


update(hObject, eventdata, handles);

path_temp=GUI_Movie(handles.path,xf,yf,zf,handles.x_current,handles.y_current, handles.z_current);

handles.path=vertcat(handles.path,path_temp);
handles.x_current=xf;
handles.y_current=yf;
handles.z_current= zf;
guidata(hObject,handles)

% --- Executes on button press in y_plus.
function y_plus_Callback(hObject, eventdata, handles)
% hObject    handle to y_plus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
xc=handles.x_current;
yc=handles.y_current;
zc=handles.z_current;
xf=xc;
yf=yc+1.5;
zf=zc;




update(hObject, eventdata, handles);

path_temp=GUI_Movie(handles.path,xf,yf,zf,handles.x_current,handles.y_current, handles.z_current);

handles.path=vertcat(handles.path,path_temp);
handles.x_current=xf;
handles.y_current=yf;
handles.z_current= zf;
guidata(hObject,handles)

% --- Executes on button press in z_plus.
function z_plus_Callback(hObject, eventdata, handles)
% hObject    handle to z_plus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
xc=handles.x_current;
yc=handles.y_current;
zc=handles.z_current;
xf=xc;
yf=yc;
zf=zc+1.5;






update(hObject, eventdata, handles);

path_temp=GUI_Movie(handles.path,xf,yf,zf,handles.x_current,handles.y_current, handles.z_current);

handles.path=vertcat(handles.path,path_temp);
handles.x_current=xf;
handles.y_current=yf;
handles.z_current= zf;
guidata(hObject,handles)

% --- Executes on button press in x_minus.
function x_minus_Callback(hObject, eventdata, handles)
% hObject    handle to x_minus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
xc=handles.x_current;
yc=handles.y_current;
zc=handles.z_current;
xf=xc-1.5;
yf=yc;
zf=zc;



update(hObject, eventdata, handles);

path_temp=GUI_Movie(handles.path,xf,yf,zf,handles.x_current,handles.y_current, handles.z_current);

handles.path=vertcat(handles.path,path_temp);
handles.x_current=xf;
handles.y_current=yf;
handles.z_current= zf;
guidata(hObject,handles)

% --- Executes on button press in y_minus.
function y_minus_Callback(hObject, eventdata, handles)
% hObject    handle to y_minus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
xc=handles.x_current;
yc=handles.y_current;
zc=handles.z_current;
xf=xc;
yf=yc-1.5;
zf=zc;



update(hObject, eventdata, handles);

path_temp=GUI_Movie(handles.path,xf,yf,zf,handles.x_current,handles.y_current, handles.z_current);

handles.path=vertcat(handles.path,path_temp);
handles.x_current=xf;
handles.y_current=yf;
handles.z_current= zf;

guidata(hObject,handles)

% --- Executes on button press in z_minus.
function z_minus_Callback(hObject, eventdata, handles)
% hObject    handle to z_minus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
xc=handles.x_current;
yc=handles.y_current;
zc=handles.z_current;
xf=xc;
yf=yc;
zf=zc-1.5;


update(hObject, eventdata, handles);

path_temp=GUI_Movie(handles.path,xf,yf,zf,handles.x_current,handles.y_current, handles.z_current);

handles.path=vertcat(handles.path,path_temp);
handles.x_current=xf;
handles.y_current=yf;
handles.z_current= zf;



guidata(hObject,handles)




% --- Executes during object creation, after setting all properties.
function plot1_CreateFcn(hObject, eventdata, handles)

% hObject    handle to plot1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate plot1



function t1_Callback(hObject, eventdata, handles)
% hObject    handle to t1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of t1 as text
%        str2double(get(hObject,'String')) returns contents of t1 as a double


% --- Executes during object creation, after setting all properties.
function t1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to t1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function t2_Callback(hObject, eventdata, handles)
% hObject    handle to t2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of t2 as text
%        str2double(get(hObject,'String')) returns contents of t2 as a double


% --- Executes during object creation, after setting all properties.
function t2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to t2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function t3_Callback(hObject, eventdata, handles)
% hObject    handle to t3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of t3 as text
%        str2double(get(hObject,'String')) returns contents of t3 as a double


% --- Executes during object creation, after setting all properties.
function t3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to t3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function xedit_Callback(hObject, eventdata, handles)
% hObject    handle to xedit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of xedit as text
%        str2double(get(hObject,'String')) returns contents of xedit as a double


% --- Executes during object creation, after setting all properties.
function xedit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to xedit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function yedit_Callback(hObject, eventdata, handles)
% hObject    handle to yedit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of yedit as text
%        str2double(get(hObject,'String')) returns contents of yedit as a double


% --- Executes during object creation, after setting all properties.
function yedit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to yedit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function zedit_Callback(hObject, eventdata, handles)
% hObject    handle to zedit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of zedit as text
%        str2double(get(hObject,'String')) returns contents of zedit as a double


% --- Executes during object creation, after setting all properties.
function zedit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to zedit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function update(hObject, eventdata, handles)
% hObject    handle to zedit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of zedit as text
%        str2double(get(hObject,'String')) returns contents of zedit as a double
x=handles.x_current;
y=handles.y_current;
z=handles.z_current;
x_sign = x/abs(x);
a = x;
%define Y compnent variables

y_sign = y/abs(y);
b = y;
%define Z compnent variables

b2 = z;
%Define Links
L1=3;
L2=7;
L3=6;

xabs=abs(x);
yabs=abs(y);


 xy_hyp = abs(sqrt(x^2+y^2));


         t1 = asind(xabs/xy_hyp);


        if(x>0&&y>0)
         t1=(180-t1);
        end
        if(x<0&&y<0)
          t1=-t1;
        end
        if(x<0&&y>0)
         t1=-180+t1;
        end
        if(x==0&&y>0)
         t1=180;
        end
        
        
c2 = sqrt(xy_hyp^2 + b2^2);

phi1 = asind(b2/c2);
phi2 = 90 - phi1;

L_hyp = sqrt(L1^2 + c2^2 - 2*L1*c2*cosd(phi2));

phi3 = acosd((-c2^2+L1^2+L_hyp^2)/(2*L1*L_hyp));
phi4 = acosd((L2^2+L_hyp^2-L3^2)/(2*L2*L_hyp));
phi5 = acosd((-L_hyp^2+L2^2+L3^2)/(2*L2*L3));
t2 = 180 - (phi3+phi4);
t3 = 180 - phi5;

digits(2);

set(handles.xedit, 'String', num2str(handles.x_current));
set(handles.yedit, 'String', num2str(handles.y_current));
set(handles.zedit, 'String', num2str(handles.z_current));
set(handles.t1, 'String', num2str(t1));
set(handles.t2, 'String', num2str(t2));
set(handles.t3, 'String', num2str(t3));
guidata(hObject,handles)



function length_txt_Callback(hObject, eventdata, handles)
% hObject    handle to length_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of length_txt as text
%        str2double(get(hObject,'String')) returns contents of length_txt as a double


% --- Executes during object creation, after setting all properties.
function length_txt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to length_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in update_length.
function update_length_Callback(hObject, eventdata, handles)
% hObject    handle to update_length (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)