function DTW_Coef = aa_dtw(D)
% function [DTW_Coef, dtw_matrix] = aa_dtw(D) % testavimo versija
    % AA_DTW                Create a matrix for speech recognition using Marcinkonis fast DTW
    %
    % Input:
    % D                     is a distance matrix
    %
    % Output:
    % DTW_Coef              is the coeficient of similarity between two
    %                       data sets, measured using Dynamic Time Warping
    
    % dtw_matrix is a recalculated distance matrix, adapted for DTW
    dtw_matrix(1:83,1:83)=99999; % sau reikalingai 83x83 matricai priskiriam maksimalias reiksmes, kuriu neimanoma virsyti
    % toliau savo priskirtas reiksmes keiciame
    
    dtw_matrix(1,1)=D(1,1); % pirma reiksme visada bus lygi atstumo matricos pirmai reiksmei
    
    % kvieciami du for ciklai, kadangi reiksmes gaunamos dviem skirtingais metodais
    % pirmas metodas reiksmems gauti naudoja eilutes, antras 'dvigubas' eilutes
    
    for di=2:1:28 % einam pagal istrizaine (di - diagonal index) ir pildom matrica liniju principu
        for i = di:1:di*2-1
            dtw_matrix(i,di) = D(i,di)+min([dtw_matrix(i-1,di-1) dtw_matrix(i,di-1) dtw_matrix(i-1,di)]);
        end
        
        for j = di+1:1:di*2-1
            dtw_matrix(di,j) = D(di,j)+min([dtw_matrix(di-1,j-1) dtw_matrix(di,j-1) dtw_matrix(di-1,j)]);
        end
    end
    
    for i=29:1:55
        for j=29:1:55
            dtw_matrix(i,j) = D(i,j)+min([dtw_matrix(i-1,j-1) dtw_matrix(i,j-1) dtw_matrix(i-1,j)]);
        end
    end
    
    reduction=27; % skaiciuojamu eiluciu skirtumas su istrizaines indeksu
    for di=56:1:82
        i=di-reduction;
        j=di;
        while(i<di)
            dtw_matrix(i,j) = D(i,j)+min([dtw_matrix(i-1,j-1) dtw_matrix(i,j-1) dtw_matrix(i-1,j)]);
            i=i+1;
        end
        % pabaigus sita while cikla gaunama 
        i=di;
        j=di-reduction;
        while(j<=di)
            dtw_matrix(i,j) = D(i,j)+min([dtw_matrix(i-1,j-1) dtw_matrix(i,j-1) dtw_matrix(i-1,j)]);
            j=j+1;
        end
        reduction=reduction-1;
    end
%     steps=28;
%     
%     for di=29:1:81 % einam pagal istrizaine ir pildom matrica dvigubu eiluciu principu
%         
%         for i = 0:1:steps
%             dtw_matrix(i+steps,di) = D(i+steps,di)+min([dtw_matrix(i+steps-1,di-1) dtw_matrix(i+steps,di-1) dtw_matrix(i+steps-1,di)]);
%         end
%         
%         for j = 0:1:steps
%             dtw_matrix(di,j+steps) = D(di,j+steps)+min([dtw_matrix(di-1,j+steps-1) dtw_matrix(di,j+steps-1) dtw_matrix(di-1,j+steps)]);
%         end
%         
%         steps=steps-1;
%         di=di+1;
%         
%         for i = 0:1:steps
%             dtw_matrix(i+steps,di) = D(i+steps,di)+min([dtw_matrix(i+steps-1,di-1) dtw_matrix(i+steps,di-1) dtw_matrix(i+steps-1,di)]);
%         end
%         
%         for j = 0:1:steps
%             dtw_matrix(di,j+steps) = D(di,j+steps)+min([dtw_matrix(di-1,j+steps-1) dtw_matrix(di,j+steps-1) dtw_matrix(di-1,j+steps)]);
%         end
%     
%     end
    
    dtw_matrix(83,83)=D(83,83)+dtw_matrix(82,82);
    
    i=1;
    j=1;
    DTW_Coef=dtw_matrix(1,1); % panasumo rodiklis (koeficientas)
    while i<83 && j<83
        minimumas=min([dtw_matrix(i+1,j+1) dtw_matrix(i,j+1) dtw_matrix(i+1,j)]);
        if minimumas == dtw_matrix(i+1,j+1)
            i=i+1;
            j=j+1;
        elseif minimumas == dtw_matrix(i,j+1)
            j=j+1;
        else
            i=i+1;
        end
        DTW_Coef=DTW_Coef+minimumas;
        %disp(['i = ' num2str(i) ';'])
        %disp(['j = ' num2str(j) ';'])
    end
    
    while i==83 && j<83
        DTW_Coef=DTW_Coef+dtw_matrix(i,j+1);
        j=j+1;
        %disp(['i = ' num2str(i) ';'])
        %disp(['j = ' num2str(j) ';'])
    end
    
    while i<83 && j==83
        DTW_Coef=DTW_Coef+dtw_matrix(i+1,j);
        i=i+1;
        %disp(['i = ' num2str(i) ';'])
        %disp(['j = ' num2str(j) ';'])
    end
    
end