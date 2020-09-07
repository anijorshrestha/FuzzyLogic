function out=readktx(Data_ktx)

file=fopen(Data_ktx,'rt');                          % KTX file for reading text
ktx.titel=fgetl(file);                              % read part of line
streak=fgetl(file);ktx.anzk=sscanf(streak,'%d');    % Read in the number of classes
streak=fgetl(file);ktx.anzm=sscanf(streak,'%d');    % Read in the number of feature
streak=fgetl(file);

for k=1:ktx.anzk           % loop for classes 
    streak=fgetl(file);
    ktx.Klassen(k).name=string(char(sscanf(streak,'%*d%s')'));
    

for m=1:ktx.anzm          % loop for feature
    streak=fgetl(file);
    TEST=sscanf(streak,'%d %f %f %f %f %f %f %f %f');
    
for t=3:9
     if  TEST(3,1)<1 && m==1  
    f = msgbox(sprintf('Invalid Value for Parameter "a" in\n  Class  = %2.3g \nFeature = %2.3g',k,m), 'Error','error'); 
    return
    elseif TEST(4,1)<=0 || TEST(4,1)>1
     f = msgbox(sprintf('Invalid Value for Parameter "BL" in\n  Class  = %2.3g \nFeature = %2.3g',k,m), 'Error','error'); 
    return
    elseif TEST(5,1)<=0 || TEST(5,1)>1
     f = msgbox(sprintf('Invalid Value for Parameter "BR" in\n  Class  = %2.3g \nFeature = %2.3g',k,m), 'Error','error'); 
    return
        elseif TEST(6,1)<=0 
     f = msgbox(sprintf('Invalid Value for Parameter "CL" in\n  Class  = %2.3g \nFeature = %2.3g',k,m), 'Error','error'); 
    return
    elseif TEST(7,1)<=0 
     f = msgbox(sprintf('Invalid Value for Parameter "CR" in\n  Class  = %2.3g \nFeature = %2.3g',k,m), 'Error','error'); 
    return
    elseif TEST(8,1)<2 
     f = msgbox(sprintf('Invalid Value for Parameter "DL" in\n  Class  = %2.3g \nFeature = %2.3g',k,m), 'Error','error'); 
    return
        elseif TEST(9,1)<2 
     f = msgbox(sprintf('Invalid Value for Parameter "DR" in\n  Class  = %2.3g \nFeature = %2.3g',k,m), 'Error','error'); 
    return
        end       
%      ktx.Klassen(k).parameters(m,1)=compose("Merkmal%d",m);  two write name of feature in data
     ktx.Klassen(k).parameters(m,:)=TEST(2:end,:);
end

end
end

    out=ktx;


for i=1:ktx.anzk
    syms x
    for j=1:ktx.anzm
         mu(i,j) = ktx.Klassen(i).parameters(1,2)*...
             ((1+(((0.5*(1+sign(ktx.Klassen(i).parameters(j,1)-x)))*...
             ((1/ktx.Klassen(i).parameters(j,3))-1)*...
             ((abs(x-ktx.Klassen(i).parameters(j,1))/ktx.Klassen(i).parameters(j,5)))^ktx.Klassen(i).parameters(j,7))+...
             ((0.5*(1+sign(x-ktx.Klassen(i).parameters(j,1))))*((1/ktx.Klassen(i).parameters(j,4))-1)*...
             ((abs(x-ktx.Klassen(i).parameters(j,1))/ktx.Klassen(i).parameters(j,6)))^ktx.Klassen(i).parameters(j,8))))^-1);
    end
end
%%%%% R - CL %%%%%%%%%%%%%%%

for i=1:ktx.anzk
    for j=1:ktx.anzm
        cl(i,j)=ktx.Klassen(i).parameters(j,1)-(20*(ktx.Klassen(i).parameters(j,5)))
    end
end   

%%%% R +Cr %%%%%%%
for i=1:ktx.anzk
    for j=1:ktx.anzm
        cr(i,j)=ktx.Klassen(i).parameters(j,1)+ (20*(ktx.Klassen(i).parameters(j,6)))
    end
end 

min_cl=  min(cl,[],1);
max_cr=  max(cr,[],1);
assignin('base','min_cl',min_cl)
assignin('base','max_cr',max_cr)
assignin('base','mu',mu)
assignin('base','x',x)
end
