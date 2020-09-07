
function out=readotx(Data_otx)
file=fopen(Data_otx,'rt');                          % OTX file for reading text
otx.titel=fgetl(file);                              % read part of line
streak=fgetl(file);
otx.anzm=sscanf(streak,'%d');    % Read in the number of feature
for i=1:otx.anzm
streak=fgetl(file);
otx.Merk.name(1,i)=string(char(sscanf(streak,'%s')'));    
end
streak=fgetl(file);

k=1;
while 1       % loop for calculate
     streak=fgetl(file);
    if isempty(streak)==1 |  streak==-1 | isempty(find(~isspace(streak)))==1 

        break
    end    
    otx.input(k,:)=sscanf(streak,'%d%f %f %f %f %f %f')';
    k=k+1;
 end
    out=otx;
% global option
% for i=1:otx.anzm
%     option(i)=otx.Merk.name(i);
% end
% assignin('base','option',option)
end