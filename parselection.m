function F=parselection(i)
maindir='/data/gpfs02/sjgao/MogeDu/GLUE2/test1/';
subdir=dir(maindir);
num=length(subdir)-3;
clear maindir subdir
%chose the indealized NO2, NO3 and Heterotrophic bacteria based on observation as the constrain for model calculation
name={'bo','no2','no3'};
file={'bo.txt','no2.txt','no3.txt'};
filet={'bo_f.txt','no2_f.txt','no3_f.txt'};
for i=1:78125%20 the number of random parameters selected from specific range
    for j=1:numel(name)
        temp=['/data/gpfs02/sjgao/MogeDu/GLUE/test1/',num2str(i),'/',char(filet(j))]; 
        filename{1,j}={temp}; %#ok<AGROW>
        fid=fopen([char(name(j)) '.txt'],'wt');
        temp=imsen(char(filename{j}));
        fprintf(fid,'%g\n',temp);
        fclose(fid);
        load(char(file(j)));
        delete(char(file(j)));
    end
    BHET3(:,i)=bo;
    BHETplot3=BHET3;
    BHETplot3(:,all(isnan(BHETplot3)))=[];
    NO23(:,i)=no2;
    NO2plot3=NO23;
    NO2plot3(:,all(isnan(NO2plot3)))=[];
    NO33(:,i)=no3;
    NO3plot3=NO33;
    NO3plot3(:,all(isnan(NO3plot3)))=[];
 clear bo no2 no3
end
clear fid file filename i j name temp ans

bo=bo(1:60,:);
bo=repmat(bo,1,num);

no2=no2(1:60,:);
no2=repmat(no2,1,num);

no3=no3(1:60,:);
no3=repmat(no3,1,num);

clear filet no2_f no3_f 
clear  name i fn num

depth=2:5:300;
depth=depth';

%cal BHET
BHETsquare=sum((BHET-bo).*(BHET-bo));
BHETsquare=BHETsquare./(length(depth));
BHETCV=sqrt(BHETsquare)./mean(bo,1);
clear BHETsquare

%cal NO2
NO2square=sum((NO2-no2).*(NO2-no2));
NO2square=NO2square./(length(depth));
NO2CV=sqrt(NO2square)./mean(no2,1);
clear NO2square

%cal NO3
NO3square=sum((NO3-no3).*(NO3-no3));
NO3square=NO3square./(length(depth));
NO3CV=sqrt(NO3square)./mean(no3,1);
clear NO3square

TCV=NO2CV+NO3CV+BHETCV;

clear NO2CV NO3CV BHETCV

%find the minimum CV
TCVMIN=min(TCV(:));
%show the minimum value on the screen
disp (TCVMIN)
%find the position of the minimum CV
[row,column]=find(TCV==min(TCV(:)));
disp (row)
disp (column)
value=textread(['/data/gpfs02/sjgao/MogeDu/GLUE2/Parameter/',num2str(column),'.txt']); 
str=['the value is',num2str(value)];
disp(str)
save CVanaData.mat

%[TCVsort,index]=sort(TCV,'ascend');
%TCVsortindex=cat(1,TCVsort,index);
%select=fix(0.1*numel(TCVsort));
%indexplot=index(:,1:select);
%for i=1:select
%    copyfile(['/home/ncg/MogeDu/GLUE1/Parameter/test1/',num2str(indexplot(i)),'.txt'], ...
%        '/home/ncg/MogeDu/GLUE1/CVana/')
%end
%for i=1:select
%    temp=['/home/ncg/MogeDu/GLUE1/CVana/',num2str(indexplot(i)),'.txt'];
%    data(:,i)={textread(temp)};
%end
%datamat=cell2mat(data);
%CVdata=TCVsortindex(1,1:select);
%clear TCVsort temp 

%p=size(datamat,1);
%foldername=datestr(date);
%path='/home/ncg/MogeDu/GLUE1/CVana/';
%mkdir (path,foldername)
%pathnew=[path,foldername];
%foldername1='Figures';
%foldername2='Data';
%mkdir (pathnew,foldername1)
%mkdir (pathnew,foldername2)
%figurepath=[pathnew,'/',foldername1];
%datapath=[pathnew,'/',foldername2];
%for i=1:p
%    figure
%    scatter(datamat(i,1:select),CVdata,'filled')
%    saveas(gcf,[figurepath,'/',num2str(i),'.fig']);
%end
%cd(datapath)
%clear pathnew foldername foldername1 foldername2 path figurepath i select

    