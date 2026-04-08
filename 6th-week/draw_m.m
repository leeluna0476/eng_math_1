x=[0 1 1 4 7 7 8 8 7 4 1 0 0;  % x values of each point
   0 0 6 0 6 0 0 8 8 2 8 8 0;  % y values of each point
   1 1 1 1 1 1 1 1 1 1 1 1 1]; % z values of each point (assume 1 for 2D)


% figure(1);
% line(x(1,:), x(2,:));
% axis([0 14 0 11]);
% grid on;
% xlabel('x1');
% ylabel('x2');
% 
% % x1축에 대칭으로 그리기
% A=[1 0 0; 0 -1 0; 0 0 1];
% y=A*x; % [3x3][3x13]=[3x13]
% 
% plot_m(2, x, y);
% 
% % x2축에 대칭으로 그리기
% A=[-1 0 0; 0 1 0; 0 0 1];
% y=A*x;
% 
% plot_m(3, x, y);
% 
% % 원점 대칭으로 그리기
% A=[-1 0 0; 0 -1 0; 0 0 1];
% y=A*x;
% 
% plot_m(4, x, y);
% 
% % 직선 x2=x1 대칭으로 그리기
% A=[0 1 0; 1 0 0; 0 0 1];
% y=A*x;
% 
% plot_m(5, x, y);
% 
% % 기울임체로 그리기 (x1만 shear)
% k=0.5;
% A=[1 k 0; 0 1 0; 0 0 1];
% y=A*x;
% 
% plot_m(6, x, y);
% 
% % 이동하기 (x3 활용. x3 항상 1이므로 좌표 계산이 단순해짐. x1, x2 그대로 있고, 거기에 단순히 k를 더한다.)
% k1=2;
% k2=1;
% A=[1 0 k1; 0 1 k2; 0 0 1];
% y=A*x;
% 
% plot_m(7, x, y);
% 
% % 이동 + 기울임체
% A=[1 k 0; 0 1 0; 0 0 1];
% y=A*y;
% plot_m(8, x, y);
% 
% % 확대 및 축소
% k1=1.3;
% A_expand=[k1 0 0; 0 k1 0; 0 0 1];
% y_expand=A_expand*x;
% k2=0.3;
% A_shrink=[k2 0 0; 0 k2 0; 0 0 1];
% y_shrink=A_shrink*x;
% 
% plot_m(9, y_expand, y_shrink);

% 단순 확대-축소 동영상
% figure(6);
% for k=1:0.01:3
%     A=[k 0 0; 0 k 0; 0 0 1];
%     y=A*x;
%     clf;
%     axis([0 30 0 30]);
%     line(y(1,:), y(2,:))
%     pause(0.001);
% end
% for k=3:-0.01:1
%     A=[k 0 0; 0 k 0; 0 0 1];
%     y=A*x;
%     clf;
%     axis([0 30 0 30]);
%     line(y(1,:), y(2,:))
%     pause(0.001);
% end

% 단순 회전 0~2pi 동영상
% figure(7);
% for t=0:0.01:2*pi
%     A=[cos(t) sin(t) 0; -sin(t) cos(t) 0; 0 0 1];
%     y=A*x;
%     clf;
%     grid on;
%     axis([-20 20 -20 20]);
%     line(y(1,:), y(2,:));
%     pause(0.00001);
% end
% for t=2*pi:-0.01:0
%     A=[cos(t) sin(t) 0; -sin(t) cos(t) 0; 0 0 1];
%     y=A*x;
%     clf;
%     grid on;
%     axis([-20 20 -20 20]);
%     line(y(1,:), y(2,:));
%     pause(0.00001);
% end

% 2D rotation -- rotation around z-axis
% 3D rotation -- rotation around x,y,z-axis
t=pi/3;
% yaw: rotation around z-axis on x-y plane
% z성분은 변하지 않음.
% CCW
A=[cos(t) -sin(t) 0; sin(t) cos(t) 0; 0 0 1];

% pitch: rotation around y-axis on x-z plane
% y성분은 변하지 않음.
% CW
% A=[cos(t) sin(t) 0; 0 1 0; -sin(t) 0 cos(t)];

% roll: rotation around x-axis on y-z plane
% x성분은 변하지 않음.
% CCW
% A=[1 0 0; 0 cos(t) -sin(t); 0 sin(t) cos(t)];

y=A*x;
% y=x;
plot3(y(1,:),y(2,:),y(3,:));
grid on;
hold on;
axis equal;
xlabel('x1');
ylabel('x2');
zlabel('x3');
plot3(x(1,:),x(2,:),x(3,:));

function plot_m(figno, x, y)
    figure(figno);
    line(x(1,:), x(2,:)); % 원본
    line(y(1,:), y(2,:));
    axis([-15 15 -15 15]);
    grid on;
    xlabel('x1');
    ylabel('x2');
end