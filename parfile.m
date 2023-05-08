%produce the parameter combination files including the selected sensitive parameter 
counts=0;
for i=1:5
    for j=1:5
        for m=1:5
            for n=1:5
                for a=1:5
                    for b=1:5
                        for c=1:5
                            counts=counts+1;
                            temp=[gam(i);gmax(j);kd(m);pnmax(n);pnmaxnoo(a);ynh4bnh4(b);yno2bno2(c)];
                            par(:,counts)=temp;
                        end
                    end
                end
            end
        end
    end
end

% remember to filtrate the unreasonable combination
% save the files named after numbers
for i=1:78125
    fid=fopen([num2str(i) '.txt'],'wt'); 
    Temp = par(:,i);
    fprintf(fid,'%.6f\n',Temp); 
    fclose(fid);
end
clear 
clc
