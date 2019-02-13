% If you are using the virtual constraints or trajectory based control
% methods, then you may cosider using a function such as this. 
% function [hd, dhd] = desired_outputs(s, ds, q0, dq0, step_number)
function [desired_q2, desired_q3] = desired_outputs(q0,q)


desired_q2_final = -pi/19;
desired_q3_final = pi/32;
initial_2 = q0(2);
initial_3 = q0(3);
% desired_q2 = initial_2 + (desired_q2_final - initial_2) * sigmoid(q(1));
% desired_q3 = initial_3 + (desired_q3_final - initial_3) * sigmoid(q(1));

desired_q2 = desired_q2_final;
desired_q3 = desired_q3_final;
% hd = initial + (desired - initial) * (1+sin(q(1)));

% dhd = (desired_q2 - initial) * (cos(q(1)/2) * dq(1));



end