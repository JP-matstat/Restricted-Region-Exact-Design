%
%  DUI.m
%  DUI
%
%  Created by Johan Persson on 2017-06-19.
%  Copyright © 2017 Johan Persson. All rights reserved.
%

function [varargout] = DUI(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @DUI_OpeningFcn, ...
                   'gui_OutputFcn',  @DUI_OutputFcn, ...
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

function DUI_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);

function varargout = DUI_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

function lstDimension_Callback(hObject, eventdata, handles)
dim = get(hObject, 'Value');
switch dim
    case 1
        set(handles.txtS1, 'visible', 'on')
        set(handles.txtS2, 'visible', 'off')
        set(handles.txtS3, 'visible', 'off')
    case 2
        set(handles.txtS1, 'visible', 'on')
        set(handles.txtS2, 'visible', 'on')
        set(handles.txtS3, 'visible', 'off')
    case 3
        set(handles.txtS1, 'visible', 'on')
        set(handles.txtS2, 'visible', 'on')
        set(handles.txtS3, 'visible', 'on')
end

function lstDimension_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function txtS1_Callback(hObject, eventdata, handles)

function txtS1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function txtS2_Callback(hObject, eventdata, handles)

function txtS2_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function txtS3_Callback(hObject, eventdata, handles)

function [C] = txtS3_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function cmdRun_Callback(hObject, eventdata, handles)
clc;
tic
dim = get(handles.lstDimension, 'value')
switch dim
    case 1
        s(1) = str2num(get(handles.txtS1, 'string'))
    case 2
        s(1) = str2num(get(handles.txtS1, 'string'));
        s(2) = str2num(get(handles.txtS2, 'string'))
        
    case 3
        s(1) = str2num(get(handles.txtS1, 'string'));
        s(2) = str2num(get(handles.txtS2, 'string'));
        s(3) = str2num(get(handles.txtS3, 'string'))
end
S = space(s);
shp = get(handles.lstRegion, 'value');
switch shp
    case 1
        disp('Full space design')
    case 2
        disp('Cut-out design')
    case 3
        disp('Cut-off design')
end
N = str2num(get(handles.txtRuns, 'string'))
mdl = get(handles.lstModel, 'value');
switch mdl
    case 1
        disp('Linear model')
    case 2
        disp('Affine model')
    case 3
        disp('Interaction model')
    case 4
        disp('Quadratic model')
    case 5
        disp('Cubic model')
end
if length(s) == 1 && mdl == 3
    disp('It is not possible to have interaction for one factor.')
    return
end
sim = str2num(get(handles.txtSimulations, 'string'));
Simulations = sim
pro = str2num(get(handles.txtProspects, 'string'));
Prospects = pro
[R, r] = region(S, shp);
P = zeros(pro, N+1);
for i = 1:pro
    [C, D] = design(N, r);
    M = matrix(D, R);
    [I, M] = information(M, mdl);
    P(i,:)=[I, D'];
end
for i = pro+1:sim
    [chg, row]=min(P(:,1));
    [C, D] = design(N, r);
    M = matrix(D, R);
    [I, M] = information(M, mdl);
    tmp = [I,D'];
    if (I > chg)
        P(row,:)= tmp;
    end
end
%P = sort(P,1,'descend');
for row = 1:pro
    for j = 2:N
        for k = 1:r
            D = P(row,2:end);
            D(j)=k;
            M = matrix(D,R);
            [I, M] = information(M, mdl);            
            if (I > P(row,1))
                P(row,:) = [I, D];
            end
        end
    end
end
info = P(:,1)';
DMat = P(:,2:end);
[maxI index] = max(info);
Dmax = DMat(index,:);
D = sort(Dmax);
DtoC = zeros(r,1);
for i = 1:N
   DtoC(D(i)) = DtoC(D(i))+1;
end
[M, i] = manual(s, shp, N, DtoC, mdl);
Information = maxI
[V] = show(M,s)
ShowMatrix = get(handles.chckbx,'Value');
if ShowMatrix
    M
end

% for i = 1:pro
% D = DMat(i,:);
% D = sort(D);
% DtoC = zeros(r,1);
% for i = 1:N
%    DtoC(D(i)) = DtoC(D(i))+1;
% end
% [M, i] = manual(s, shp, N, DtoC, mdl);
% [V] = show(M,s)
toc

% [Imax, index] = max(I_vec);
% info = [Imax, index];
% Mmax = M_vec{index};
% V = show(M_vec{index},s);

function lstRegion_Callback(hObject, eventdata, handles)

function lstRegion_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function txtRuns_Callback(hObject, eventdata, handles)

function txtRuns_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function lstModel_Callback(hObject, eventdata, handles)

function lstModel_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function txtSimulations_Callback(hObject, eventdata, handles)

function txtSimulations_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function txtProspects_Callback(hObject, eventdata, handles)

function txtProspects_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function chckbx_Callback(hObject, eventdata, handles)

function cmdhelp_Callback(hObject, eventdata, handles)
% hObject    handle to cmdhelp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
hlp = get(handles.cmdhelp, 'value');
if hlp
    if isunix
    system(['evince ' 'manual.pdf' ' &']);
    else open('manual.pdf');
    end
end
