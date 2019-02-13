% function [cot_total]=COT(num_steps,dq1_total,dq2_total,dq3_total,u1_total,u2_total,x_swf_total,x_h_total)
function [cot_total]=COT(sln,displacement_total)
k=0.001* 22.7419/4.58;
count=0;
q0 = [0;0;0];
dq0 = [0;0;0];
num_steps = length(sln.T);
x=abs(displacement_total);


%每一步的
for j = 1:num_steps
    Y = sln.Y{j};
    T=  sln.T{j};
    [N, ~] = size(Y);  %每一步分成N小段
    
     q = Y(:, 1:3)';
     q1=q(1,:);
     q2=q(2,:);
     q3=q(3,:);
     dq=Y(:, 4:6)';
     dq1=dq(1,:);
     dq2=dq(2,:);
     dq3=dq(3,:);
     
     for i=1:N-1
            dt(i)=abs(T(i+1)-T(i));
     end
     
     B1=dq3-dq1;
     B2=dq3-dq2;

     for i=1:N
        Q=[q(1,i),q(2,i),q(3,i)];
        DQ=[dq(1,i),dq(2,i),dq(3,i)];
        u(:,i) = control(count*k, Q,DQ, q0, dq0,num_steps);
        count=count+1;
     end
        u1=u(1,:)';
        u2=u(2,:)';

for i=1:N-1   
    shang1(i)=max(0,u1(i)*B1(i))*dt(i);
    shang2(i)=max(0,u2(i)*B2(i))*dt(i);
end

COT1(j)=sum(shang1)/x(j);
COT2(j)=sum(shang2)/x(j);

end

cot_total=COT1+COT2;
% step=1:1:num_steps;
% plot(step,cot_total),title('CoT vs step');
end

