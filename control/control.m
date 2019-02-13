function u = control(t, q, dq, q0, dq0, step_number)

[Kd_torso, Kp_torso, Kd_swing, Kp_swing, desired_q1,desired_q2, desired_q3,k,switch_model,threshold] = control_hyper_parameters(step_number);


u1 = Kp_torso * (q(3) - desired_q3-k*(q(1)-desired_q1)) + Kd_torso * (dq(3)-k*dq(1));
u2 = -Kp_swing * (q(2) + q(1)) - Kd_swing * (dq(2)+dq(1));
if (u1 > 30)
    u1 = 30;
end
if (u1 < -30)
    u1 = -30;
end
if (u2 > 30)
    u2 = 30;
end
if (u2 < -30)
    u2 = -30;
end
if switch_model ==1
    u1 = Kp_torso * (q(3) - desired_q3-k*(q(1)-desired_q1)) + Kd_torso * (dq(3)-k*dq(1));
    u2 = -Kp_swing * ((q(2) - desired_q2)) - Kd_swing * (dq(2));
    if q(3)>threshold
        u1 = Kp_torso * (q(3)) + Kd_torso * (dq(3));
    end
end
u_ext = [0;0];    
% if you want to add perturbation to the robot, just remove the comment of
% the following line of code

% u_ext = perturbation(q, step_number);
u=[u1;u2] + u_ext;
end