function analyze2(sln)
q0 = [0;0;0];
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

%1
figure
plot(t,q1_total);
hold on
plot(t,q2_total);
xlabel('time(s)');
title('q1and q2 vs time');
legend('q1','q2');
%2
figure
plot(t,q3_total),title('q3 vs time');
xlabel('time(s)');
%3
figure
plot(t,dq1_total),title('dq1 vs time');
xlabel('time(s)');
%4
figure
plot(t,dq2_total),title('dq2 vs time');
xlabel('time(s)');
%5
figure
plot(t,dq3_total),title('dq3 vs time');
xlabel('time(s)');
%6
figure
plot(t,x_h_total),title('x_h vs time');
xlabel('time(s)');
%7
figure
plot(t,dx_h_total),title('dx_h vs time');
xlabel('time(s)');
%8
figure
plot(step,freq_total),title('step number vs step frequency');
xlabel('step');
%9
figure
plot(t,z_h_total),title('z_h vs time');
xlabel('time(s)');
%10
figure
plot(t,dz_h_total),title('dz_h vs time');
xlabel('time(s)');
%11
figure
plot(step,displacement_total),title('displacement in each step vs step number');
xlabel('step');
%12
figure
plot(q1_total,dq1_total),title('q1 vs dq1');
axis equal;
%13
figure
plot(q2_total,dq3_total),title('q2 vs dq2');
axis equal
%14
figure
plot(q3_total,dq3_total),title('q3 vs dq3');
axis equal;

%15
figure
plot(q1_total,dq1_total);
hold on
plot(q2_total,dq3_total);
hold on
plot(q3_total,dq3_total);
axis equal;
title('qi vs dqi');
legend('q1 vs dq1','q2 vs dq2','q3 vs dq3');

%16
figure
plot(t,u1_total);
xlabel('time(s)');
title('u1 vs time');

figure
plot(t,u2_total);
xlabel('time(s)');
title('u2 vs time');


%17
figure
plot(step,cot_total),title('CoT vs step');
xlabel('step');
end