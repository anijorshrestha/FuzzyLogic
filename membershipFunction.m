function membershipFunction(x,mu,min_cl,max_cr,ktx,option,handles,linewidth)
for i=1:ktx.anzm
if option == i
     hold off
     for j=1:ktx.anzk
         plot=fplot(handles.axes1,x,mu(j,i),[min_cl(i),max_cr(i)],'LineWidth',linewidth)           
         hold on
         grid on
         set (get (handles.axes1, 'xlabel' ), 'string' , 'Feature')
         set (get (handles.axes1, 'ylabel' ), 'string' , 'µ')
         l=legend(ktx.Klassen.name);
         
         
         
     end
     assignin('base','legend',l)
end
end



