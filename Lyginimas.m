set(handles.dialog, 'ForegroundColor', 'black')
set(handles.spell, 'String', '');
ats = '';
spell = '';
if isfile('1_1.wav')
%--------------------------------------------------------------------------
%LPC auto characteristics calculation

%%Paima .wav ir isskaidzius duoda kadru savybiu vektorius

%LPCauto WINGARDIUM LEVIOSA
[ar1_1,e1_1]=v_lpcauto(audioread('1_1.wav'),12,[330,440,0],'m','j');
[ar1_2,e1_2]=v_lpcauto(audioread('1_2.wav'),12,[330,440,0],'m','j');
[ar1_3,e1_3]=v_lpcauto(audioread('1_3.wav'),12,[330,440,0],'m','j');

%LPCauto EXPECTO PATRONUM
[ar2_1,e2_1]=v_lpcauto(audioread('2_1.wav'),12,[330,440,0],'m','j');
[ar2_2,e2_2]=v_lpcauto(audioread('2_2.wav'),12,[330,440,0],'m','j');
[ar2_3,e2_3]=v_lpcauto(audioread('2_3.wav'),12,[330,440,0],'m','j');

%LPCauto AVADA KEDAVRA
[ar3_1,e3_1]=v_lpcauto(audioread('3_1.wav'),12,[330,440,0],'m','j');
[ar3_2,e3_2]=v_lpcauto(audioread('3_2.wav'),12,[330,440,0],'m','j');
[ar3_3,e3_3]=v_lpcauto(audioread('3_3.wav'),12,[330,440,0],'m','j');

%--------------------------------------------------------------------------
%Recording
Fs=11025; %diskretizavimo daznis
Rec_Duration=2.5; %sekundemis

Rec_Dabar = audiorecorder(Fs,16,1); %Disk. Dazn / Bitrate / Kanalai
disp('Prepare to CAST SPELL')
set(handles.dialog, 'String', 'Prepare to CAST SPELL');
       pause(1);
       disp('3...')
       set(handles.dialog, 'String', '3...');
       pause(1);
       disp('2...')
       set(handles.dialog, 'String', '2...');
       pause(1);
       disp('1...')
       set(handles.dialog, 'String', '1...');
       pause(1);
       disp('Start speaking') 
    set(handles.dialog, 'String', 'SPELL!');  
    recordblocking(Rec_Dabar, Rec_Duration);
    disp('End of Recording.');
    set(handles.dialog, 'String', 'End of Recording.');
    
Y_X=getaudiodata(Rec_Dabar);

audiowrite('X.wav', Y_X, Fs);
[arX,eX]=v_lpcauto(audioread('X.wav'),12,[330,440,0],'m','j');


%--------------------------------------------------------------------------
%Distance calculation

%%suskaiciuja atstumus tarp duotu vektoriu

%Distance matrix calc with WINGARDIUM LEVIOSA
d1_1=v_distisar(ar1_1,arX,'x');
d1_2=v_distisar(ar1_2,arX,'x');
d1_3=v_distisar(ar1_3,arX,'x');

%Distance matrix calc with EXPECTO PATRONUM
d2_1=v_distisar(ar2_1,arX,'x');
d2_2=v_distisar(ar2_2,arX,'x');
d2_3=v_distisar(ar2_3,arX,'x');

%Distance matrix calc with AVADA KEDAVRA
d3_1=v_distisar(ar3_1,arX,'x');
d3_2=v_distisar(ar3_2,arX,'x');
d3_3=v_distisar(ar3_3,arX,'x');

%--------------------------------------------------------------------------
%DTW coefficient

%DTW coefficient calculation with WINGARDIUM LEVIOSA
d11_DTW_Coef = aa_dtw(d1_1);
d12_DTW_Coef = aa_dtw(d1_2);
d13_DTW_Coef = aa_dtw(d1_3);

%DTW coefficient calculation with EXPECTO PATRONUM
d21_DTW_Coef = aa_dtw(d2_1);
d22_DTW_Coef = aa_dtw(d2_2);
d23_DTW_Coef = aa_dtw(d2_3);

%DTW coefficient calculation with AVADA KEDAVRA
d31_DTW_Coef = aa_dtw(d3_1);
d32_DTW_Coef = aa_dtw(d3_2);
d33_DTW_Coef = aa_dtw(d3_3);
%--------------------------------------------------------------------------
%Display coef

% disp('EXPELLIARMUS coefficients:')
% disp(d11_DTW_Coef);
% disp(d12_DTW_Coef);
% disp(d13_DTW_Coef);
% 
% disp('EXPECTO PATRONUM coefficients:')
% disp(d21_DTW_Coef);
% disp(d22_DTW_Coef);
% disp(d23_DTW_Coef);
% 
% disp('AVADA KEDAVRA coefficients:')
% disp(d31_DTW_Coef);
% disp(d32_DTW_Coef);
% disp(d33_DTW_Coef);

%--------------------------------------------------------------------------
%Best match & Text UI

min_coef=min([d11_DTW_Coef d12_DTW_Coef d13_DTW_Coef d21_DTW_Coef d22_DTW_Coef d23_DTW_Coef d31_DTW_Coef d32_DTW_Coef d33_DTW_Coef]); % randam maziausia is gautu koeficientu


if min_coef >= 6.0000e+03 % nustatomas ribine panasumo reiksme, kurios nepasiekus zodis laikomas neatpazintu
    %Ribos koeficientas yra jautrus mikrofono kokybei
    ats = 'Given word is unrecognised (the minimal similarity coeficient was not reached)';
elseif min_coef == d11_DTW_Coef || min_coef == d12_DTW_Coef || min_coef == d13_DTW_Coef % jei zodis atpazintas, patikriname ir isvedame, kkuris tai zodis
    spell = 'EXPELLIARMUS';
    set(handles.spell, 'ForegroundColor', '#FC6042'); %red
elseif min_coef == d21_DTW_Coef || min_coef == d22_DTW_Coef || min_coef == d23_DTW_Coef
    spell = 'EXPECTO PATRONUM';
    set(handles.spell, 'ForegroundColor', '#2C82C9'); %blue
else
    spell = 'AVADA KEDAVRA';
    set(handles.spell, 'ForegroundColor', '#2CC990'); %green
end
else
    ats = 'Record samples first';
end

disp(ats);
disp(spell);
set(handles.dialog, 'String', ats);
set(handles.spell, 'String', spell);