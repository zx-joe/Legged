% You can set any hyper parameters of the control function here; you may or
% may not want to use the step_number as the input of the function. 
function [Kd_torso, Kp_torso, Kd_swing, Kp_swing, desired_q1,desired_q2, desired_q3,k,switch_model,threshold] = control_hyper_parameters(step_number)
%parameters for v=0.4
Kp_swing = 30;
Kd_swing = 2.9;
Kp_torso = 1.5;
Kd_torso = 600;
desired_q1=pi/25;
desired_q2 = -pi/35;
desired_q3 = pi/30;
k=0.0025;
switch_model=0;
threshold=pi/3;


% %parameters for v=1.5
% Kp_swing = 75;
% Kd_swing = 1;
% Kp_torso = 2;
% Kd_torso = 400;
% desired_q1=pi/15;
% desired_q2 = -pi/35;
% desired_q3 = pi/20;
% k=0.03;
% switch_model=1;
% threshold=pi/3;


% %parameters for v=0.6
% Kp_swing = 100;
% Kd_swing = 2;
% Kp_torso = 1;
% Kd_torso = 1500;
% desired_q1=pi/15;
% desired_q2 = -pi/35;
% desired_q3 = pi/20;
% k=0.03;
% switch_model=1;
% threshold=pi/70;


% %parameters for v=0.8
% Kp_swing = 100;
% Kd_swing = 2;
% Kp_torso = 1;
% Kd_torso = 1500;
% desired_q1=pi/15;
% desired_q2 = -pi/35;
% desired_q3 = pi/20;
% k=0.03;
% switch_model=1;
% threshold=pi/25;


% %parameters for v=1.0
% Kp_swing = 100;
% Kd_swing = 2;
% Kp_torso = 1;
% Kd_torso = 1500;
% desired_q1=pi/15;
% desired_q2 = -pi/35;
% desired_q3 = pi/20;
% k=0.03;
% switch_model=1;
% threshold=pi/12;


% %parameters for v=1.2
% Kp_swing = 150;
% Kd_swing = 2;
% Kp_torso = 1;
% Kd_torso = 1500;
% desired_q1=pi/15;
% desired_q2 = -pi/35;
% desired_q3 = pi/20;
% k=0.03;
% switch_model=1;
% threshold=pi/8;


end
