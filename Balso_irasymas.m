Fs=11025; %diskretizavimo daznis
Rec_Duration=2.5; %sekundemis
Hz_virs = 300;%da??niai kurie vir??ys ???? skai??i?? bus praleid??iami
Hz_po= 3400;%da??niai kurie bus ??emiau ??io skai??iaus bus praleid??iami %%jei bus daugiau nei FS/2 naudos all filter

Rec_1 = audiorecorder(Fs,16,1);%Disk. Dazn / Bitrate / Kanalai

set(handles.dialog, 'String', 'Recording SPELLS. Pay attention. We will record 3 spell 3 times.');
pause(5)
for i=1:1:3
    for j=1:1:3
        FileName = sprintf('%d_%d.wav', i, j);
        if i==1
            if j==1
                disp('Prepare to record: EXPELLIARMUS' )
                set(handles.dialog, 'String', 'Prepare to record: EXPELLIARMUS' );
                pause(3);
            end
        disp('3...')
        set(handles.dialog, 'String', '3...');
        pause(1);
        disp('2...')
        set(handles.dialog, 'String', '2...');
        pause(1);
        disp('1...')
        set(handles.dialog, 'String', '1...');
        pause(1);
        set(handles.dialog, 'String', 'Say: EXPELLIARMUS' );
        Sample_Nr=['Samle NR.:',num2str(j)];
        disp(Sample_Nr);
        end
        
        if i==2 
            if j==1
                disp('Prepare to record: EXPECTO PATRONUM')
                set(handles.dialog, 'String', 'Prepare to record: EXPECTO PATRONUM');
                pause(3);
            end
        disp('3...')
        set(handles.dialog, 'String', '3...');
        pause(1);
        disp('2...')
        set(handles.dialog, 'String', '2...');
        pause(1);
        disp('1...')
        set(handles.dialog, 'String', '1...');
        pause(1);
        set(handles.dialog, 'String', 'Say: EXPECTO PATRONUM' );
        Sample_Nr=['Samle NR.:',num2str(j)];
        disp(Sample_Nr);
        end
        
        if i==3 
            if j==1
                disp('Prepare to record: AVADA KEDAVRA')
                set(handles.dialog, 'String', 'Prepare to record: AVADA KEDAVRA');
                pause(3);
            end
        disp('3...')
        set(handles.dialog, 'String', '3...');
        pause(1);
        disp('2...')
        set(handles.dialog, 'String', '2...');
        pause(1);
        disp('1...')
        set(handles.dialog, 'String', '1...');
        pause(1);
        set(handles.dialog, 'String', 'Say: AVADA KEDAVRA' );
        Sample_Nr=['Samle NR.:',num2str(j)];
        disp(Sample_Nr);
        end
        
        disp(FileName);
%         pause(1);
%         disp('3...')
%         pause(1);
%         disp('2...')
%         pause(1);
%         disp('1...')
%         pause(1);
        disp('Start speaking')
        %set(handles.dialog, 'String', 'Start speaking');
        recordblocking(Rec_1, Rec_Duration); %Pradeda irasineti
        disp('Recorded!');
        set(handles.dialog, 'String', 'Recorded!');
        pause(1)
        if j<3
            disp('Repeat.');
            set(handles.dialog, 'String', 'Repeat.');
            pause(1);
        end

        Y = getaudiodata(Rec_1);
        %Y = highpass (Y, Hz_virs, Fs);
        %Y = lowpass (Y, Hz_po, Fs);

        %soundsc(Y,Fs);
        %pause(Rec_Duration);

        audiowrite(FileName, Y, Fs);
        pause(1);
    end
end
set(handles.dialog, 'String', 'Samples recorded successfully!');
pause(3)
set(handles.dialog, 'String', '');