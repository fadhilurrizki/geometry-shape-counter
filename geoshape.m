function varargout = geoshape(varargin)
% GEOSHAPE MATLAB code for geoshape.fig
%      GEOSHAPE, by itself, creates a new GEOSHAPE or raises the existing
%      singleton*.
%
%      H = GEOSHAPE returns the handle to a new GEOSHAPE or the handle to
%      the existing singleton*.
%
%      GEOSHAPE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GEOSHAPE.M with the given input arguments.
%
%      GEOSHAPE('Property','Value',...) creates a new GEOSHAPE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before geoshape_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to geoshape_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help geoshape

% Last Modified by GUIDE v2.5 22-Feb-2015 11:06:54

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @geoshape_OpeningFcn, ...
                   'gui_OutputFcn',  @geoshape_OutputFcn, ...
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


% --- Executes just before geoshape is made visible.
function geoshape_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to geoshape (see VARARGIN)

% Choose default command line output for geoshape
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes geoshape wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = geoshape_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global image;
[namafile, formatfile] = uigetfile({'*.png'}, 'membuka gambar'); %memilih gambar
image = imread([formatfile, namafile]); %membaca gambar
handles.filename = namafile;
guidata(hObject, handles);
axes(handles.axes1); %memilih axes1 sebagai letak gambar yang dimunculkan
imshow(image); %memunculkan gambar


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
nama_model = struct('Nama',{}, 'Jumlah',{},'Warna',{},'Pattern',{});
nama_model(1).Nama = 'segiempat'; nama_model(1).Jumlah = 0; nama_model(1).Warna='unknown', nama_model(1).Pattern='unknown';
nama_model(2).Nama = 'lingkaran'; nama_model(2).Jumlah = 0; nama_model(2).Warna='unknown', nama_model(2).Pattern='unknown';
nama_model(3).Nama = 'segitiga'; nama_model(3).Jumlah = 0; nama_model(3).Warna='unknown', nama_model(3).Pattern='unknown';
nama_model(4).Nama = 'segilima'; nama_model(4).Jumlah = 0; nama_model(4).Warna='unknown', nama_model(4).Pattern='unknown';
nama_model(5).Nama = 'bintang'; nama_model(5).Jumlah = 0; nama_model(5).Warna='unknown', nama_model(5).Pattern='unknown';
nama_model(6).Nama = 'unknown'; nama_model(6).Jumlah = 0; nama_model(6).Warna='unknown', nama_model(6).Pattern='unknown';
global image;
global sizee;
sizee = size(image);
Igray= rgb2gray(image);
Ibw= im2bw(Igray, 0.9);
s = regionprops(~Ibw,'Image','BoundingBox');
jum_seg = size(s);
for i=1:jum_seg;  
    %shape
    a=imfill(s(i).Image,'holes');
    a=imresize(a,[20 20]);
    M = momentinvariant(a);
    [hasil1,hasil2] = matching(M);
    %color
    box=s(i).BoundingBox;
    Icrop = imcrop(image,box);
    disp(Icrop);
    Icropg = rgb2gray(Icrop);
    q=1;r=1;
    si=size(Icropg);
    for j=1:si(1)
        for k=1:si(2)
            if((Icropg(j,k)<190))
                q=j;
                r=k;    
                break;
            end
        end
    end  
    disp(q);
    disp(k);
    disp(si);
    img = zeros(size(Icrop));
    for j=1:si(1)
        for k=1:si(2)
                img(j,k,:)=Icrop(q,r,:);
        end
    end
    img = uint8(img);  
    cm = colorMoments(img);    
    [hasil3,hasil4] = matchColor(cm);
    %texture
    b = s(i).Image;
    si=size(b);
    x=0; y=0;
    for j=1:si(2)-1
        if(b(ceil(si(1)/2),j)~=b(ceil(si(1)/2),j+1))
            x=x+1;
        end
    end
    for j=1:si(1)-1
        if(b(j,ceil(si(2)/2))~=b(j+1,ceil(si(2)/2)))
            y=y+1;
        end
    end
    if(x<4)
        if(y<4)
            nama_model(hasil1).Pattern='solid';
        else
            nama_model(hasil1).Pattern='horizontal';
        end
    else
        if(y<4)
            nama_model(hasil1).Pattern='vertikal';
        end
    end
    nama_model(hasil1).Jumlah = nama_model(hasil1).Jumlah+1;
    nama_model(hasil1).Warna = hasil4;
end

h1=strcat(nama_model(1).Nama,'-',num2str(nama_model(1).Warna),'-',num2str(nama_model(1).Pattern),'=',num2str(nama_model(1).Jumlah));
h2=strcat(nama_model(2).Nama,'-',num2str(nama_model(2).Warna),'-',num2str(nama_model(2).Pattern),'=',num2str(nama_model(2).Jumlah));
h3=strcat(nama_model(3).Nama,'-',num2str(nama_model(3).Warna),'-',num2str(nama_model(3).Pattern),'=',num2str(nama_model(3).Jumlah));
h4=strcat(nama_model(4).Nama,'-',num2str(nama_model(4).Warna),'-',num2str(nama_model(4).Pattern),'=',num2str(nama_model(4).Jumlah));
h5=strcat(nama_model(5).Nama,'-',num2str(nama_model(5).Warna),'-',num2str(nama_model(5).Pattern),'=',num2str(nama_model(5).Jumlah));
h6=strcat(nama_model(6).Nama,'-',num2str(nama_model(6).Warna),'-',num2str(nama_model(6).Pattern),'=',num2str(nama_model(6).Jumlah));
set(handles.txt7,'string',{h1;h2;h3;h4;h5;h6});

function txt1_Callback(hObject, eventdata, handles)
% hObject    handle to txt1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txt1 as text
%        str2double(get(hObject,'String')) returns contents of txt1 as a double


% --- Executes during object creation, after setting all properties.
function txt1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txt1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txt2_Callback(hObject, eventdata, handles)
% hObject    handle to txt2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txt2 as text
%        str2double(get(hObject,'String')) returns contents of txt2 as a double


% --- Executes during object creation, after setting all properties.
function txt2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txt2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txt3_Callback(hObject, eventdata, handles)
% hObject    handle to txt3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txt3 as text
%        str2double(get(hObject,'String')) returns contents of txt3 as a double


% --- Executes during object creation, after setting all properties.
function txt3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txt3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txt4_Callback(hObject, eventdata, handles)
% hObject    handle to txt4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txt4 as text
%        str2double(get(hObject,'String')) returns contents of txt4 as a double


% --- Executes during object creation, after setting all properties.
function txt4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txt4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txt5_Callback(hObject, eventdata, handles)
% hObject    handle to txt5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txt5 as text
%        str2double(get(hObject,'String')) returns contents of txt5 as a double


% --- Executes during object creation, after setting all properties.
function txt5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txt5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txt6_Callback(hObject, eventdata, handles)
% hObject    handle to txt6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txt6 as text
%        str2double(get(hObject,'String')) returns contents of txt6 as a double


% --- Executes during object creation, after setting all properties.
function txt6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txt6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

I = imread('segiempat.png');
Ibw = im2bw(I);
s = regionprops(~Ibw,'Image');
a=s(1).Image;
a=imresize(a,[20 20]);
M = momentinvariant(a);
save('segiempat.mat','M');

I = imread('segitiga.png');
Ibw = im2bw(I);
s = regionprops(~Ibw,'Image');
a=imresize(a,[20 20]);
a=s(1).Image;
M = momentinvariant(a);
save('segitiga.mat','M');

I = imread('lingkaran.png');
Ibw = im2bw(I);
s = regionprops(~Ibw,'Image');
a=s(1).Image;
a=imresize(a,[20 20]);
M = momentinvariant(a);
save('lingkaran.mat','M');

I = imread('segilima.png');
Ibw = im2bw(I);
s = regionprops(~Ibw,'Image');
a=s(1).Image;
a=imresize(a,[20 20]);
M = momentinvariant(a);
save('segilima.mat','M');

I = imread('bintang.png');
Ibw = im2bw(I);
s = regionprops(~Ibw,'Image');
a=s(1).Image;
a=imresize(a,[20 20]);
M = momentinvariant(a);
save('bintang.mat','M');

img = imread('red.png');
cm = colorMoments(img);
save('red.mat','cm');

img = imread('green.png');
cm = colorMoments(img);
save('green.mat','cm');

img = imread('blue.png');
cm = colorMoments(img);
save('blue.mat','cm');

img = imread('yellow.png');
cm = colorMoments(img);
save('yellow.mat','cm');

 



function txt7_Callback(hObject, eventdata, handles)
% hObject    handle to txt7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txt7 as text
%        str2double(get(hObject,'String')) returns contents of txt7 as a double


% --- Executes during object creation, after setting all properties.
function txt7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txt7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
