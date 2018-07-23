%run init path just to get everything in the right place
init_path

%learning_Volterra, learning_NARMA and learning_quad_generator go through 
%go through the following steps:
% 1) use init_ms_sys_data followed by init_ms_sys_net to produce an initial
% random mass spring network as described on simulation setup slides 1-12
% 2) prepare learning data based on the function we want to emulate
% 3) use simulate_ms_sys to simulate the mass-spring damper system
% representing our morphology (i.e. see what outputs we get from our
% randomly initialised network)
% 4) use supervised learning (comparison of actual output to desired output
% from that learning data we prepared earlier) to adjust our ouput
% weights as described on simulation setup slides 13+
% 5) again simulates the mass-spring damper system using simulate_ms_sys on
% our the test data we seperated out in 2) with our newly adjusted output 
% weights 
% 6) plot the actual test data against the output produced by our
% mass-spring damper and trained output weights (you can see it's a very
% close match, backed up by the low MSE which is printed) and plot the
% mass spring network we've been using 

% pick desired function to emulate
%
learning_Volterra
%learning_NARMA
%learning_quad_generator

%look at high dimensional response of final (optimised) network
% Observation: Responses are quite different and it they converge (fading memory property)

step_response(net_test_out)
plot_graph(net_test_out)


% compare the performance of our morphology system to standard linear
% regression learning
% using function learn_linear_model 
% The linear model is not able to capture any kind of dynamics (memory)
% It's output will only a scaled version of the input with an offset
% Note that a linear, static model is the output we get if we don't have the computational
$ power of the morphology 