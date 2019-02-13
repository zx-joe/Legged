
clc;clear;
set_path
q0=[0;0;0];
dq0=[0.1;0;0];
num_steps = 100;
sln = solve_eqns(q0, dq0, num_steps);
animate(sln)


analyze_2(sln)
% if you want to get 18 separate figures for more intuitive observation, please
% switch to the following line of code
% analyze(sln)