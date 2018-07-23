function [teachinginputs, teachingoutputs] = generatedata(n)

teachinginputs = [];
for i = 1:n
    x1=rand;
    x2=rand;
    teachinginputs=[teachinginputs; -1 x1 x2];
end

teachingoutputs = (0.2*teachinginputs(:,2)+0.3*teachinginputs(:,3));
%teachingoutputs = (5*teachinginputs(:,2)+3*teachinginputs(:,3));