x=[0 1 1 4 7 7 8 8 7 4 1 0 0;
   0 0 6 0 6 0 0 8 8 2 8 8 0;
   1 1 1 1 1 1 1 1 1 1 1 1 1];

% x3축 기준으로 CW 회전.
% 회전 각도 deg는 0~360까지 1도 간격으로 커짐.
% M 시계방향으로 서서히 회전.
for deg=0:1:360
    th=deg*pi/180;
    A=[cos(th) sin(th) 0; -sin(th) cos(th) 0; 0 0 1];
    y=A*x;
    clf;
    axis([-30 30 -30 30]);
    line(y(1,:), y(2,:));
    grid on;
    text(10, 6, '202500062 / 이서진')
    pause(0.000001);
end

% x3축 기준으로 CW 회전.
% 회전 각도 deg는 360~0까지 1도 간격으로 작아짐.
% M 반시계방향으로 서서히 회전.
% deg를 0~360까지 1도씩 커지도록 하고
% 회전 방향을 CCW로 정의해도 똑같이 동작함.
for deg=360:-1:0
% for deg=0:1:360
    th=deg*pi/180;
    A=[cos(th) sin(th) 0; -sin(th) cos(th) 0; 0 0 1];
    % A=[cos(th) -sin(th) 0; sin(th) cos(th) 0; 0 0 1];
    y=A*x;
    clf;
    axis([-30 30 -30 30]);
    line(y(1,:), y(2,:));
    grid on;
    text(10, 6, '202500062 / 이서진')
    pause(0.000001);
end