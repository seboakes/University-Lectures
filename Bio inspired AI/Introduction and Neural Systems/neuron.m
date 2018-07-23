function [output] = neuron(inputs,weights)

output = 0;
OutputResults = [];

for i = 1:size(inputs,2)
    x=inputs(i);
    w=weights(i);
    output=output+x*w;
    OutputResults(i)= output;
end
output = tanh(output)