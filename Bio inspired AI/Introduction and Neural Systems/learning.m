function [weights] = learning (teachinginputs,teachingoutputs)

weights = 2*rand(1,size(teachinginputs,2))-1;

eta = 0.001;

for i=1:size(teachinginputs,1)
    output=neuron(teachinginputs(i,:),weights);
    delta = teachingoutputs(i)-output;
    for j = 1:size(weights,2)
        weights(j)=weights(j)+eta*delta*teachinginputs(i,j);
    end
end
