%Simulation Paramter Values all in terms ER (Earth's Radius)
S = transpose([1, 0, 0]);   %Position of Satellite Receiver
S_1 = transpose([3.5852, 2.07, 0]);   %Position of Satellite 1
S_2 = transpose([2.9274, 2.9274, 0]);   %Position of Satellite 2
S_3 = transpose([2.6612, 0, 3.1712]);   %Position of Satellite 3
S_4 = transpose([1.4159, 0, 3.8904]);   %Position of Satellite 4
b_not = 2.354788068*10^-3; %clock bias error

%General displacement magnitude equations

delta_S_1 = S - S_1;   %Satellite 1 to receiver distance vector
delta_S_2 = S - S_2;   %Satellite 2 to receiver distance vector
delta_S_3 = S - S_3;   %Satellite 3 to receiver distance vector
delta_S_4 = S - S_4;   %Satellite 4 to receiver distance vector

%True Range Equations for each Satellite

R_1 = ((transpose(delta_S_1)*delta_S_1)^0.5);   %true range (R_1(S)) to the receiver from Satellite 1
R_2 = ((transpose(delta_S_2)*delta_S_2)^0.5);   %true range (R_2(S)) to the receiver from Satellite 2
R_3 = ((transpose(delta_S_3)*delta_S_3)^0.5);   %true range (R_3(S)) to the receiver from Satellite 3
R_4 = ((transpose(delta_S_4)*delta_S_4)^0.5);   %true range (R_4(S)) to the receiver from Satellite 4

e = ones(4,1);
y_k = zeros(4,1);
R = [R_1, R_2, R_3, R_4]';

sigma_1 = 0;    %no noise.
sigma_2 = 0.0004;   %range error standard deviation of about 2.5km.
sigma_3 = 0.004;    %standard deviation of about 25km.

m = ([1, 4, 16, 256]);

S_hat = [0.93310, 0.25, 0.258819]';

h = R + e*b_not;
v_bar = mean(sigma_1.*randn(4,m(1)),2);
y_bar = h + v_bar;
b_hat = 0;

%Gradient Descent Algorithm

%{
for i = 1:100000;

X_j = ([S_hat', b_hat]');

DS_1 = S_hat - S_1;
DS_2 = S_hat - S_2;
DS_3 = S_hat - S_3;
DS_4 = S_hat - S_4;

True_hat_1 = ((transpose(DS_1)*DS_1)^0.5);
True_hat_2 = ((transpose(DS_2)*DS_2)^0.5);
True_hat_3 = ((transpose(DS_3)*DS_3)^0.5);
True_hat_4 = ((transpose(DS_4)*DS_4)^0.5);
True_hat = [True_hat_1, True_hat_2, True_hat_3, True_hat_4]';

h_j = (True_hat + e*b_hat);

r_hat = ([((DS_1)/(True_hat_1)), ((DS_2)/(True_hat_2)), ((DS_3)/(True_hat_3)), ((DS_4)/(True_hat_4))]);

H = ([r_hat', e]);

alpha = 0.13;


X_j_1 = X_j + alpha*H'*(y_bar - h_j);%Gradient Descent Algorithm

S_hat = X_j_1(1:3);
b_hat = X_j_1(4);

displacement = sqrt((S-S_hat)'*(S-S_hat))*6370*1000


end

plot(displacement,i)
title('Gradient Descent Graph with sigma = 0');
xlabel('number of iterations');
ylabel('Displacement between (S_hat) and (S) in meters');
%}

%Gauss-Newton Algorithm


for i = 1:4;

X_j = ([S_hat', b_hat]');

DS_1 = S_hat - S_1;
DS_2 = S_hat - S_2;
DS_3 = S_hat - S_3;
DS_4 = S_hat - S_4;

True_hat_1 = ((transpose(DS_1)*DS_1)^0.5);
True_hat_2 = ((transpose(DS_2)*DS_2)^0.5);
True_hat_3 = ((transpose(DS_3)*DS_3)^0.5);
True_hat_4 = ((transpose(DS_4)*DS_4)^0.5);
True_hat = [True_hat_1, True_hat_2, True_hat_3, True_hat_4]';

h_j = (True_hat + e*b_hat);



r_hat = ([((DS_1)/(True_hat_1)), ((DS_2)/(True_hat_2)), ((DS_3)/(True_hat_3)), ((DS_4)/(True_hat_4))]);

H = ([r_hat', e]);

H_inv = inv(H);
alpha = 1;


X_j_1 = X_j + alpha*H_inv*(y_bar - h_j);

S_hat = X_j_1(1:3);
b_hat = X_j_1(4);

displacement(i) = sqrt((S-S_hat)'*(S-S_hat))*6370*1000



end

plot(displacement)
title('Gauss-Newton Algorithm with sigma = 0.004 and measurement = 256');
xlabel('number of iterations');
ylabel('Displacement between (S_hat) and (S) in meters');
