function varargout = dof(varargin)
% DOF M-file for dof.fig
%      DOF, by itself, creates a new DOF or raises the existing
%      singleton*.
%
%      H = DOF returns the handle to a new DOF or the handle to
%      the existing singleton*.
%
%      DOF('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DOF.M with the given input arguments.
%
%      DOF('Property','Value',...) creates a new DOF or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before dof_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to dof_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help dof

% Last Modified by GUIDE v2.5 05-Oct-2011 02:24:01

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @dof_OpeningFcn, ...
    'gui_OutputFcn',  @dof_OutputFcn, ...
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


% --- Executes just before dof is made visible.
function dof_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to dof (see VARARGIN)

% Choose default command line output for dof
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes dof wait for user response (see UIRESUME)
% uiwait(handles.figure1);
clear all;
global l1;
global l11;
global l12;
global l2;
global l3;
global l31;
global l32;
global x1;
global x2;
global x3;
global y1;
global y2;
global y3;
global z1;
global z2;
global z3;
global X;
global Y;
global Z;
global q1;
global q2;
global q3;
global q11;
global q31;
global q12;
global q32;
global h;

a = [0,0,6,6,0,3]; %common normals intitial values when arm is straight
alpha = zeros(6); %angles between adjacent z axes
d = zeros(6); %distance between origin i.e. x axis and intersection of comman normal at z axis
theta = zeros(6); %angle between two adjacent x axes

% lenght of each component of arm
% shoulder to albow
l1 = 6;
% ablbow to wrist
l2 = 6;
% wrist lentgth
l3 = 3;

% initial values given to each part is maximum possible value

q1 = 0; %('pitch shoulder by angle');
q2 = 0; %('pitch albow by angle'
q3 = 0; %('pitch wrist by angle');

q11 = 0; %('yaw shoulder by angle');
q31 = 0; %('yaw wrist by angle');

q12 = 0; %('roll shoulder by angle');
q32 = 0; %('roll wrist by angle'); doesn't make a differences

%roll shoulder 0 length 
 theta(1) = q12;
 alpha(1) = 0;
 a(1) = 0;
 d(1) = 0;
 %yaw shoulder 0 length
 theta(2) = q11;
 alpha(2) = 90;
 a(2) = 0;
 d(2) = 0;
 
 %pitch shoulder 6 length
 theta(3) = q1;
 alpha(3) = 90;
 a(3) = 0;
 d(3) = 0;
 % if we yaw 6 length, result will be same. If we roll 6 length, a will
 % become 0 as both z axes will intersect but d will become 6, distance
 % between two x axes or two origins. 
 
 %pitch albow 6 length
 theta(4) = q2;
 alpha(4) = 0;
 a(4) = l1;
 
 %pitch wrist 0 legth
 theta(5) = q3;
 alpha(5) = 0;
 a(5) = l2;
 d(5) = 0;
 
 %yaw wrist 3 length
 theta(6) = q31;
 alpha(6) = 90;
 a(6) = 0;
 
%  % end effector frame
 theta(7) = 0;
 alpha(7) = 0;
 a(7) = l3;
 d(7) = 0;

% A10 = [cosd(theta(1)),-sind(theta(1))*cosd(alpha(1)),sind(theta(1))*sind(alpha(1)),a(1)*cosd(theta(1));
%      sind(theta(1)),cosd(theta(1))*cosd(alpha(1)),-cosd(theta(1))*sind(alpha(1)),a(1)*sind(theta(1));
%      0,sind(alpha(1)),cosd(alpha(1)),d(1);      0,0,0,1];
%  
% A21 = [cosd(theta(2)),-sind(theta(2))*cosd(alpha(2)),sind(theta(2))*sind(alpha(2)),a(2)*cosd(theta(2));
%      sind(theta(2)),cosd(theta(2))*cosd(alpha(2)),-cosd(theta(2))*sind(alpha(2)),a(2)*sind(theta(2));
%      0,sind(alpha(2)),cosd(alpha(2)),d(2);      0,0,0,1];
%  
% A32 = [cosd(theta(3)),-sind(theta(3))*cosd(alpha(3)),sind(theta(3))*sind(alpha(3)),a(3)*cosd(theta(3));
%      sind(theta(3)),cosd(theta(3))*cosd(alpha(3)),-cosd(theta(3))*sind(alpha(3)),a(3)*sind(theta(3));
%      0,sind(alpha(3)),cosd(alpha(3)),d(3);      0,0,0,1];
%  
% A43 = [cosd(theta(4)),-sind(theta(4))*cosd(alpha(4)),sind(theta(4))*sind(alpha(4)),a(4)*cosd(theta(4));
%      sind(theta(4)),cosd(theta(4))*cosd(alpha(4)),-cosd(theta(4))*sind(alpha(4)),a(4)*sind(theta(4));
%      0,sind(alpha(4)),cosd(alpha(4)),d(4);      0,0,0,1];
%  
% A54 = [cosd(theta(5)),-sind(theta(5))*cosd(alpha(5)),sind(theta(5))*sind(alpha(5)),a(5)*cosd(theta(5));
%      sind(theta(5)),cosd(theta(5))*cosd(alpha(5)),-cosd(theta(5))*sind(alpha(5)),a(5)*sind(theta(5));
%      0,sind(alpha(5)),cosd(alpha(5)),d(5);      0,0,0,1];
%  
% A65 = [cosd(theta(6)),-sind(theta(6))*cosd(alpha(6)),sind(theta(6))*sind(alpha(6)),a(6)*cosd(theta(6));
%      sind(theta(6)),cosd(theta(6))*cosd(alpha(6)),-cosd(theta(6))*sind(alpha(6)),a(6)*sind(theta(6));
%      0,sind(alpha(6)),cosd(alpha(6)),d(6);      0,0,0,1];
%  
%  A76 = [cosd(theta(7)),-sind(theta(7))*cosd(alpha(7)),sind(theta(7))*sind(alpha(7)),a(7)*cosd(theta(7));
%      sind(theta(7)),cosd(theta(7))*cosd(alpha(7)),-cosd(theta(7))*sind(alpha(7)),a(7)*sind(theta(7));
%      0,sind(alpha(7)),cosd(alpha(7)),d(7);      0,0,0,1];
 
  A10 = [cosd(theta(1)),-sind(theta(1)),0,a(1);
     sind(theta(1))*cosd(alpha(1)),cosd(theta(1))*cosd(alpha(1)),-sind(alpha(1)),-sind(alpha(1))*d(1);
     sind(theta(1))*sind(alpha(1)),cosd(theta(1))*sind(alpha(1)),cosd(alpha(1)), cosd(alpha(1))*d(1); 
     0,0,0,1];
 A21 = [cosd(theta(2)),-sind(theta(2)),0,a(2);
     sind(theta(2))*cosd(alpha(2)),cosd(theta(2))*cosd(alpha(2)),-sind(alpha(2)),-sind(alpha(2))*d(2);
     sind(theta(2))*sind(alpha(2)),cosd(theta(2))*sind(alpha(2)),cosd(alpha(2)), cosd(alpha(2))*d(2); 
     0,0,0,1];
 A32 = [cosd(theta(3)),-sind(theta(3)),0,a(3);
     sind(theta(3))*cosd(alpha(3)),cosd(theta(3))*cosd(alpha(3)),-sind(alpha(3)),-sind(alpha(3))*d(3);
     sind(theta(3))*sind(alpha(3)),cosd(theta(3))*sind(alpha(3)),cosd(alpha(3)), cosd(alpha(3))*d(3); 
     0,0,0,1];
  A43 = [cosd(theta(4)),-sind(theta(4)),0,a(4);
     sind(theta(4))*cosd(alpha(4)),cosd(theta(4))*cosd(alpha(4)),-sind(alpha(4)),-sind(alpha(4))*d(4);
     sind(theta(4))*sind(alpha(4)),cosd(theta(4))*sind(alpha(4)),cosd(alpha(4)), cosd(alpha(4))*d(4); 
     0,0,0,1];
  A54 = [cosd(theta(5)),-sind(theta(5)),0,a(5);
     sind(theta(5))*cosd(alpha(5)),cosd(theta(5))*cosd(alpha(5)),-sind(alpha(5)),-sind(alpha(5))*d(5);
     sind(theta(5))*sind(alpha(5)),cosd(theta(5))*sind(alpha(5)),cosd(alpha(5)), cosd(alpha(5))*d(5); 
     0,0,0,1];
  A65 = [cosd(theta(6)),-sind(theta(6)),0,a(6);
     sind(theta(6))*cosd(alpha(6)),cosd(theta(6))*cosd(alpha(6)),-sind(alpha(6)),-sind(alpha(6))*d(6);
     sind(theta(6))*sind(alpha(6)),cosd(theta(6))*sind(alpha(6)),cosd(alpha(6)), cosd(alpha(6))*d(6); 
     0,0,0,1];
  A76 = [cosd(theta(7)),-sind(theta(7)),0,a(7);
     sind(theta(7))*cosd(alpha(7)),cosd(theta(7))*cosd(alpha(7)),-sind(alpha(7)),-sind(alpha(7))*d(7);
     sind(theta(7))*sind(alpha(7)),cosd(theta(7))*sind(alpha(7)),cosd(alpha(7)), cosd(alpha(7))*d(7); 
     0,0,0,1];
 
 T = A10*A21*A32*A43*A54*A65*A76;
 TS = A10*A21*A32*A43;
 TA = TS*A54;
 

% x1 =  0+l1*cosd(q1)*cosd(q11);
% x2 = x1+l2*cosd(q2+q1)*cosd(q11);
% x3 = x2+l3*cosd(q1+q2+q3)*cosd(q31+q11);
% 
% y1 = 0+l1*sind(q1);
% y2 = y1+l2*sind(q2+q1)*cosd(q12);
% y3 = y2+l3*sind(q3+q2+q1)*cosd(q12);
% 
% z1 = 0+l1*sind(q11);
% z2 = z1+l2*sind(q11)*sind(q12);
% z3 = z2+l3*sind(q12+q11)*sind(q12);

x1 = TS(1,4);
y1 = TS(2,4);
z1 = TS(3,4);

x2 = TA(1,4);
y2 = TA(2,4);
z2 = TA(3,4);

x3 = T(1,4);
y3 = T(2,4);
z3 = T(3,4);


X = [0 x1 x2 x3];
Y = [0 y1 y2 y3];
Z = [0 z1 z2 z3];

axis([0 20 0 20 0 20]);
grid on
hold on

h = plot3(X,Y,Z, 'LineWidth', 10, 'Marker','o');
% --- Outputs from this function are returned to the command line.
function varargout = dof_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in pop.
function pop_Callback(hObject, eventdata, handles)
% hObject    handle to pop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pop contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pop



% --- Executes during object creation, after setting all properties.
function pop_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function angle_Callback(hObject, eventdata, handles)
% hObject    handle to angle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of angle as text
%        str2double(get(hObject,'String')) returns contents of angle as a double


% --- Executes during object creation, after setting all properties.
function angle_CreateFcn(hObject, eventdata, handles)
% hObject    handle to angle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in push.
function push_Callback(hObject, eventdata, handles)
% hObject    handle to push (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

a = [0,0,6,6,0,3,0]; %common normals intitial values when arm is straight
alpha = zeros(7); %angles between adjacent z axes
d = zeros(7); %distance between origin i.e. x axis and intersection of comman normal at z axis
theta = zeros(7); %angle between two adjacent x axes

global l1;
global l2;
global l3;
global x1;
global x2;
global x3;
global y1;
global y2;
global y3;
global z1;
global z2;
global z3;
global X;
global Y;
global Z;
global q1;
global q2;
global q3;
global q11;
global q31;
global q12;
global h;
switch get(handles.pop,'Value')
    case 1
        q12 = str2double(get(handles.angle,'String'));
    case 2
        q11 =  str2double(get(handles.angle,'String'));
    case 3
        q31 = str2double(get(handles.angle,'String'));      
    case 4
        q1 = str2double(get(handles.angle,'String'));       
    case 5
        q2 = str2double(get(handles.angle,'String'));
       
%         if q1 ~= 0
%             a(3) = 6;
%             alpha(1) = 0;
%             theta(1) = q2;
%         end
%         if q11 ~= 0
%             a(3) = 6;
%             alpha(1) = 90;
%             theta(1) = q2;
%         end
%         if q12 ~= 0
%             a(3) = 0;
%             alpha(1) = 90;
%             theta(1) = 90;
%         end
    otherwise
        q3 = str2double(get(handles.angle,'String'));
end

%roll shoulder 0 length 
 theta(1) = q12;
 alpha(1) = 0;
 a(1) = 0;
 d(1) = 0;
 %yaw shoulder 0 length
 theta(2) = q11;
 alpha(2) = 90;
 a(2) = 0;
 d(2) = 0;
 
 %pitch shoulder 6 length
 theta(3) = q1;
 alpha(3) = 90;
 a(3) = 0;
 d(3) = 0;
 % if we yaw 6 length, result will be same. If we roll 6 length, a will
 % become 0 as both z axes will intersect but d will become 6, distance
 % between two x axes or two origins. 
 
 %pitch albow 6 length
 theta(4) = q2;
 alpha(4) = 0;
 a(4) = l1;
 
 %pitch wrist 0 legth
 theta(5) = q3;
 alpha(5) = 0;
 a(5) = l2;
 d(5) = 0;
 
 %yaw wrist 3 length
 theta(6) = q31;
 alpha(6) = 90;
 a(6) = 0;
 
%  % end effector frame
 theta(7) = 0;
 alpha(7) = 0;
 a(7) = l3;
 d(7) = 0;

  
% A10 = [cosd(theta(1)),-sind(theta(1))*cosd(alpha(1)),sind(theta(1))*sind(alpha(1)),a(1)*cosd(theta(1));
%      sind(theta(1)),cosd(theta(1))*cosd(alpha(1)),-cosd(theta(1))*sind(alpha(1)),a(1)*sind(theta(1));
%      0,sind(alpha(1)),cosd(alpha(1)),d(1);      0,0,0,1];
%  
% A21 = [cosd(theta(2)),-sind(theta(2))*cosd(alpha(2)),sind(theta(2))*sind(alpha(2)),a(2)*cosd(theta(2));
%      sind(theta(2)),cosd(theta(2))*cosd(alpha(2)),-cosd(theta(2))*sind(alpha(2)),a(2)*sind(theta(2));
%      0,sind(alpha(2)),cosd(alpha(2)),d(2);      0,0,0,1];
%  
% A32 = [cosd(theta(3)),-sind(theta(3))*cosd(alpha(3)),sind(theta(3))*sind(alpha(3)),a(3)*cosd(theta(3));
%      sind(theta(3)),cosd(theta(3))*cosd(alpha(3)),-cosd(theta(3))*sind(alpha(3)),a(3)*sind(theta(3));
%      0,sind(alpha(3)),cosd(alpha(3)),d(3);      0,0,0,1];
%  
% A43 = [cosd(theta(4)),-sind(theta(4))*cosd(alpha(4)),sind(theta(4))*sind(alpha(4)),a(4)*cosd(theta(4));
%      sind(theta(4)),cosd(theta(4))*cosd(alpha(4)),-cosd(theta(4))*sind(alpha(4)),a(4)*sind(theta(4));
%      0,sind(alpha(4)),cosd(alpha(4)),d(4);      0,0,0,1];
%  
% A54 = [cosd(theta(5)),-sind(theta(5))*cosd(alpha(5)),sind(theta(5))*sind(alpha(5)),a(5)*cosd(theta(5));
%      sind(theta(5)),cosd(theta(5))*cosd(alpha(5)),-cosd(theta(5))*sind(alpha(5)),a(5)*sind(theta(5));
%      0,sind(alpha(5)),cosd(alpha(5)),d(5);      0,0,0,1];
%  
% A65 = [cosd(theta(6)),-sind(theta(6))*cosd(alpha(6)),sind(theta(6))*sind(alpha(6)),a(6)*cosd(theta(6));
%      sind(theta(6)),cosd(theta(6))*cosd(alpha(6)),-cosd(theta(6))*sind(alpha(6)),a(6)*sind(theta(6));
%      0,sind(alpha(6)),cosd(alpha(6)),d(6);      0,0,0,1];
%  
%  A76 = [cosd(theta(7)),-sind(theta(7))*cosd(alpha(7)),sind(theta(7))*sind(alpha(7)),a(7)*cosd(theta(7));
%      sind(theta(7)),cosd(theta(7))*cosd(alpha(7)),-cosd(theta(7))*sind(alpha(7)),a(7)*sind(theta(7));
%      0,sind(alpha(7)),cosd(alpha(7)),d(7);      0,0,0,1];
 
 A10 = [cosd(theta(1)),-sind(theta(1)),0,a(1);
     sind(theta(1))*cosd(alpha(1)),cosd(theta(1))*cosd(alpha(1)),-sind(alpha(1)),-sind(alpha(1))*d(1);
     sind(theta(1))*sind(alpha(1)),cosd(theta(1))*sind(alpha(1)),cosd(alpha(1)), cosd(alpha(1))*d(1); 
     0,0,0,1];
 A21 = [cosd(theta(2)),-sind(theta(2)),0,a(2);
     sind(theta(2))*cosd(alpha(2)),cosd(theta(2))*cosd(alpha(2)),-sind(alpha(2)),-sind(alpha(2))*d(2);
     sind(theta(2))*sind(alpha(2)),cosd(theta(2))*sind(alpha(2)),cosd(alpha(2)), cosd(alpha(2))*d(2); 
     0,0,0,1];
 A32 = [cosd(theta(3)),-sind(theta(3)),0,a(3);
     sind(theta(3))*cosd(alpha(3)),cosd(theta(3))*cosd(alpha(3)),-sind(alpha(3)),-sind(alpha(3))*d(3);
     sind(theta(3))*sind(alpha(3)),cosd(theta(3))*sind(alpha(3)),cosd(alpha(3)), cosd(alpha(3))*d(3); 
     0,0,0,1];
  A43 = [cosd(theta(4)),-sind(theta(4)),0,a(4);
     sind(theta(4))*cosd(alpha(4)),cosd(theta(4))*cosd(alpha(4)),-sind(alpha(4)),-sind(alpha(4))*d(4);
     sind(theta(4))*sind(alpha(4)),cosd(theta(4))*sind(alpha(4)),cosd(alpha(4)), cosd(alpha(4))*d(4); 
     0,0,0,1];
  A54 = [cosd(theta(5)),-sind(theta(5)),0,a(5);
     sind(theta(5))*cosd(alpha(5)),cosd(theta(5))*cosd(alpha(5)),-sind(alpha(5)),-sind(alpha(5))*d(5);
     sind(theta(5))*sind(alpha(5)),cosd(theta(5))*sind(alpha(5)),cosd(alpha(5)), cosd(alpha(5))*d(5); 
     0,0,0,1];
  A65 = [cosd(theta(6)),-sind(theta(6)),0,a(6);
     sind(theta(6))*cosd(alpha(6)),cosd(theta(6))*cosd(alpha(6)),-sind(alpha(6)),-sind(alpha(6))*d(6);
     sind(theta(6))*sind(alpha(6)),cosd(theta(6))*sind(alpha(6)),cosd(alpha(6)), cosd(alpha(6))*d(6); 
     0,0,0,1];
  A76 = [cosd(theta(7)),-sind(theta(7)),0,a(7);
     sind(theta(7))*cosd(alpha(7)),cosd(theta(7))*cosd(alpha(7)),-sind(alpha(7)),-sind(alpha(7))*d(7);
     sind(theta(7))*sind(alpha(7)),cosd(theta(7))*sind(alpha(7)),cosd(alpha(7)), cosd(alpha(7))*d(7); 
     0,0,0,1];
 
 T = A10*A21*A32*A43*A54*A65*A76;
 TS = A10*A21*A32*A43;
 TA = TS*A54;
 
X = [0 x1 x2 x3];
Y = [0 y1 y2 y3];
Z = [0 z1 z2 z3];

%  h = plot3(X,Y,Z, 'LineWidth', 10, 'Marker','o');
% x11 =  0+l1*cosd(q1)*cosd(q11);
% x21 = (x11+l2*cosd(q1+q2))*cosd(q11);
% x31 = x21+l3*cosd(q1+q2+q3)*cosd(q11+q31);
% 
% y11 = 0+l1*sind(q1);
% if q2 ~= 0
%     y21 = (y11+l2*sind(q1+q2))*cosd(q12);
% else
%     y21 = y11+l2*sind(q1+q2);
% end
% 
% if q2 ~= 0 || q3 ~= 0 || q31 ~= 0
%     y31 = (y21+l3*sind(q1+q2+q3))*cosd(q12);
%     
% else
%     y31 = y21+l3*sind(q1+q2+q3);
% end
% 
% z11 = 0+l1*sind(q11);
% if q2 ~= 0
%     z21 = z11+l2*sind(q11)+l2*sind(q12);
% else
%     z21 = z11+l2*sind(q11);
% end
% if q2 ~= 0 || q3 ~= 0 || q31 ~= 0
%     z31 = z21+l3*sind(q11+q31)+l3*sind(q12);
% else
%     z31 = z21+l3*sind(q11);
% end

x11 = TS(1,4);
y11 = TS(2,4);
z11 = TS(3,4);

x21 = TA(1,4);
y21 = TA(2,4);
z21 = TA(3,4);

x31 = T(1,4);
y31 = T(2,4);
z31 = T(3,4);

set(h,'XDataSource','X');
set(h,'YDataSource','Y');
set(h,'ZDataSource','Z');
X(2) = x11;
Y(2) = y11;
Z(2) = z11;
X(3) = x21;
Y(3) = y21;
Z(3) = z21;
X(4) = x31;
Y(4) = y31;
Z(4) = z31;
%text(x31+1,y31+1,z31+1,'position of end effector');
refreshdata(h,'caller');
drawnow();

disp('end effector transofmration matrix is')
disp(T);
disp('albow end transofmration matrix is')
disp(TA);
disp('shoulder end transofmration matrix is')
disp(TS);


% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)