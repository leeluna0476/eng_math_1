x=[0 5 6 6 2 6 6 5 0 0 1 5 5 1 1 1 5 5 1 1;
   0 0 1 3 4 5 7 8 8 0 1 1 2 3 1 5 6 7 7 5;
   1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1];

% pitch animation
figure(1);
for th=0:0.01:2*pi
    Apitch=[1 0 0; 0 cos(th) -sin(th); 0 sin(th) cos(th)];
    y=Apitch*x;
    clf;
    line(y(1,:), y(2,:), y(3,:));
    axis([0 10 -10 10 -10 10]);
    grid on;
    view(3);
    xlabel('x1');
    ylabel('x2');
    zlabel('x3');
    pause(0.00001);
end

% theta=pi/6;
% % yaw
% figure(1);
% Ayaw=[cos(theta) -sin(theta) 0; sin(theta) cos(theta) 0; 0 0 1];
% y=Ayaw*x;
% plot3(y(1,:), y(2,:), y(3,:));
% grid on;
% hold on;
% plot3(x(1,:), x(2,:), x(3,:));
% xlabel('x1');
% ylabel('x2');
% zlabel('x3');
% 
% % roll
% figure(2);
% Aroll=[cos(theta) 0 sin(theta); 0 1 0; -sin(theta) 0 cos(theta)];
% y=Aroll*x;
% plot3(y(1,:), y(2,:), y(3,:));
% grid on;
% hold on;
% plot3(x(1,:), x(2,:), x(3,:));
% xlabel('x1');
% ylabel('x2');
% zlabel('x3');
% 
% % pitch
% figure(3);
% Apitch=[1 0 0; 0 cos(theta) -sin(theta); 0 sin(theta) cos(theta);];
% y=Apitch*x;
% plot3(y(1,:), y(2,:), y(3,:));
% grid on;
% hold on;
% plot3(x(1,:), x(2,:), x(3,:));
% xlabel('x1');
% ylabel('x2');
% zlabel('x3');
% 
% % yaw -> pitch
% figure(4);
% y=Apitch*Ayaw*x;
% plot3(y(1,:), y(2,:), y(3,:));
% grid on;
% hold on;
% plot3(x(1,:), x(2,:), x(3,:));
% xlabel('x1');
% ylabel('x2');
% zlabel('x3');
% 
% % pitch -> yaw
% figure(5);
% y=Ayaw*Apitch*x;
% plot3(y(1,:), y(2,:), y(3,:));
% grid on;
% hold on;
% plot3(x(1,:), x(2,:), x(3,:));
% xlabel('x1');
% ylabel('x2');
% zlabel('x3');
% 
% % yaw -> roll
% figure(6)
% y=Aroll*Ayaw*x;
% plot3(y(1,:), y(2,:), y(3,:));
% grid on;
% hold on;
% plot3(x(1,:), x(2,:), x(3,:));
% xlabel('x1');
% ylabel('x2');
% zlabel('x3');