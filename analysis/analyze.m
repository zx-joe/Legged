%% Read the README_ASSIGN4.pdf to see what results you need to analyze here. 
function analyze(sln)
q0 = [0;0; 0];
dq0 = [0;0;0];
% angles vs time
figure();
num_steps = length(sln.T);
skip=5;
count=0;
r0=[0;0];
q1_total=[];
q2_total=[];
q3_total=[];
dq1_total=[];
dq2_total=[];
dq3_total=[];
x_h_total=[];
z_h_total=[];
dx_h_total=[];
dz_h_total=[];
u1_total=[];
u2_total=[];
cot_total=[];
freq_total=[];energy_total=[];
x_swf_total=[];
displacement_total=[];
cot_total=[];
[T, V] = eval_energy([0;0;0], [0;0;0]);
temp_E=T+V;
t_total=[];
temp_t=0;
v_total=[];
x_h=0;%%%cuimingbo
r0 = [0; 0];
k=0.001* 22.7419/4.58;
temp_x_h=0;
v=0;
for j = 1:num_steps
    Y = sln.Y{j};
    [N, ~] = size(Y);

    temp_count=0;
    for i = 1:skip:N
        q = Y(i, 1:3)';
        dq= Y(i, 4:6)';
        
        %pause(0.002);
        temp_q1=[q(1)];
        temp_q2=[q(2)];
        temp_q3=[q(3)];
        q1_total=[q1_total;temp_q1];
        q2_total=[q2_total;temp_q2];
        q3_total=[q3_total;temp_q3];
        temp_dq1=[dq(1)];
        temp_dq2=[dq(2)];
        temp_dq3=[dq(3)];
        dq1_total=[dq1_total;temp_dq1];
        dq2_total=[dq2_total;temp_dq2];
        dq3_total=[dq3_total;temp_dq3];
        [x_h1, z_h, dx_h, dz_h] = kin_hip(q, dq);
        
        x_h = r0(1) + x_h1;%%%%%%%%%%%%% cmb
 
        x_h_total=[x_h_total;[x_h]];
        dx_h_total=[dx_h_total;[dx_h]];
        z_h_total=[z_h_total;[z_h]];
        dz_h_total=[dz_h_total;[dz_h]];
        u = control(count*k, q, dq, q0, dq0,num_steps);
        u1_total=[u1_total;[u(1)]];
        u2_total=[u2_total;[u(2)]];
        temp_count=temp_count+1;
        

        count=count+1;
        v_total=[v_total,[v]];
    end
    
    step_distance=x_h-temp_x_h;
    temp_x_h=x_h;
    step_time=temp_count* k;
    step_v=step_distance/step_time
    v_total=[v_total,[step_v]];
    freq=1/(step_time);
    freq_total=[freq_total;[freq]];
    
    dist=x_h-temp_x_h;
    tempx_h=x_h;
    v=dist/step_time;

    [x_swf, z_swf, dx_swf, dz_swf] = kin_swf(q, dq);
    displacement_total=[displacement_total,[x_swf]];
    x_swf_total=[x_swf_total,x_swf];
    [x0, ~, ~, ~] = kin_swf(q);
    r0 = r0 + [x0; 0];
    
end

[cot_total]=COT(sln,displacement_total);

t=k :k :count*k ;
step=1:1:num_steps;
subplot(6,3,1),plot(t,q1_total),title('q1 vs time'),
subplot(6,3,2),plot(t,q2_total),title('q2 vs time'),
subplot(6,3,3),plot(t,q3_total),title('q3 vs time'),
subplot(6,3,4),plot(t,dq1_total),title('dq1 vs time'),
subplot(6,3,5),plot(t,dq2_total),title('dq2 vs time'),
subplot(6,3,6),plot(t,dq3_total),title('dq3 vs time'),
subplot(6,3,7),plot(t,x_h_total),title('x_h vs time'),
subplot(6,3,8),plot(t,dx_h_total),title('dx_h vs time'),
% hold on
% subplot(6,3,8),plot(t,v_total,'color', 'r')
subplot(6,3,9),plot(step,freq_total),title('step frequency  vs  step number'),
subplot(6,3,10),plot(t,z_h_total),title('z_h vs time'),
subplot(6,3,11),plot(t,dz_h_total),title('dz_h vs time'),
subplot(6,3,12),plot(step,displacement_total),title('displacement in each step vs step number'),
subplot(6,3,13),plot(q1_total,dq1_total),title('q1 vs dq1')
axis equal;
subplot(6,3,14),plot(q2_total,dq3_total),title('q2 vs dq2')
axis equal;
subplot(6,3,15),plot(q3_total,dq3_total),title('q3 vs dq3')
axis equal;
subplot(6,3,16),plot(t,u1_total),title('u1 vs time'),
subplot(6,3,17),plot(t,u2_total),title('u2 vs time'),
subplot(6,3,18),plot(step,cot_total),title('CoT vs step'),
%subplot(6,3,18),plot(step,v_total),title('Average Velocity in each step vs step number')
end