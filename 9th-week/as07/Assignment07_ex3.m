%   1  2 3  4  5 6   7  8  9  10 11 12 13
d=[ 0  5 5  0 -5 5   0 -5 -5   0  5 -5  0;
    0 -5 5  0  5 5   0  5 -5   0 -5 -5  0;
   20  0 0 20  0 0 -20  0  0 -20  0  0 20;
    1  1 1  1  1 1   1  1  1   1  1  1  1];

p = [1 2 3; 4 5 6; 5 6 7; 8 9 10; 9 10 11; 11 12 13; 1 8 9; 2 3 7];
c = ['b';'r';'g';'w';'k';'c';'m';'y'];


x3=0;
r_Rev=20; % Radius of revolution

% 팔면체 상부 꼭지점의 좌표.
orbit=[0,0,20];

noRot1=2; % no of 1st rotation
noRev=2;% no of revolution (공전)
noRot2=4;% no of 2nd rotation (자전)

% x3축 기준으로 ccw로 2바퀴 등속도 회전하며 x1축 따라 +20 평행이동.
for x1=0:0.15:20
    % 회전각 계산.
    % x1이 20이 될 때까지 2바퀴 회전하도록 한다.
    % x1=0, psi=noRot1*2*pi*0=0
    % x1=20, psi=noRot1*2*pi*1=4*pi
    psi=noRot1*2*pi*x1/20;

    % x3축 기준 psi만큼 ccw 회전하도록 회전행렬 정의.
    Rz_u=[cos(psi) -sin(psi) 0 x1; sin(psi) cos(psi) 0 0; 0 0 1 0; 0 0 0 1];
    % 회전된 좌표 y 계산.
    y=Rz_u*d;

    clf;

    line([y(1,:) y(1,1)], [y(2,:) y(2,1)], [y(3,:) y(3,1)]);

    line([40 0 0], [0 0 0], [0 0 0],'Color','r');
    line([0 0 0], [0 40 0], [0 0 0],'Color','g');
    line([0 0 0], [0 0 0], [0 0 40],'Color','k');

    % 원본 데이터부터, loop 단계별로 변환된 모든 상부 꼭지점 좌표를 저장.
    % 이동궤적을 기록.
    orbit=[orbit; y(1,1) y(2,1), y(3,1)];
    % 기록된 이동 궤적을 매번 새로 그린다.
    line(orbit(:,1), orbit(:,2), orbit(:,3));

    for i=1:1:8
        patch([y(1,p(i,1)) y(1,p(i,2)) y(1,p(i,3))], ...
            [y(2,p(i,1)) y(2,p(i,2)) y(2,p(i,3))], ...
            [y(3,p(i,1)) y(3,p(i,2)) y(3,p(i,3))],c(i));
    end

    xlabel('x1-axis'); ylabel('x2-axis'); zlabel('x3-axis');
    text(20, 60, 60, '이서진 202500062');
    axis([-60 60 -60 60 -60 60]);
    view([60,60,60]); grid;
    pause(0.000001);
end

% x3축을 기준으로 반지름이 20인 ccw로 등속도로 돌면서 하강. 공전 및 자전.
% 총 noRev=2바퀴 공전.
% 하강 거리는 20. 하강한 지점 x3좌표 팔면체 하부 꼭지점 기준 -40.
for deg=0:2:noRev*360 % Revolutional angle 공전각도 (2 Revolutions)
    clf;
    % x3축 기준으로 반지름 r_Rev=20의 원운동을 하도록 이동 좌표 계산.
    % => 공전.
    x1=r_Rev*cos(deg*pi/180);
    x2=r_Rev*sin(deg*pi/180);
    % 하강 좌표 계산. 2바퀴 공전하는 동안 x3축 따라 20만큼 하강.
    % deg=0, x3=0. deg=noRev*360, x3=-20
    x3=-deg/(noRev*360)*20;
    % 자전 각 계산. 2바퀴 공전(deg*pi/180)하는 동안 16바퀴 자전.
    % => 8 rotations per revolution
    % 원래 noRot2=4로 설정하고, psi 계산할 때 2를 곱하는 방식이었는데
    % noRot2 자체가 공전 1회당 자전 횟수를 나타내도록 noRot2를 8로 바꿔주었다.
    % 그 후 noRot2를 4로 바꿔보니 자전을 두배 천천히 하더라.
    psi=noRot2*deg*pi/180;
    
    % x1, x2좌표는 원운동을 하도록, x3좌표는 하강하도록 하고, (평행이동)
    % 평행이동과 동시에 x3축을 기준 ccw로 psi만큼 회전하도록 (자전) 변환행렬 정의.
    Rz_round=[cos(psi) -sin(psi) 0 x1; sin(psi) cos(psi) 0 x2; 0 0 1 x3; 0 0 0 1];
    % 변환 좌표 계산.
    y=Rz_round*d;
    
    line([y(1,:) y(1,1)], [y(2,:) y(2,1)], [y(3,:) y(3,1)]);

    line([60 0 0], [0 0 0], [0 0 0],'Color','r');
    line([0 0 0], [0 60 0], [0 0 0],'Color','g');
    line([0 0 0], [0 0 0], [0 0 60],'Color','k');

    orbit=[orbit; y(1,1), y(2,1), y(3,1)]; % Orbit of Revolution 공전궤도
    line(orbit(:,1), orbit(:,2), orbit(:,3));
    for i=1:1:8
        patch([y(1,p(i,1)) y(1,p(i,2)) y(1,p(i,3))], [y(2,p(i,1)) y(2,p(i,2)) ...
            y(2,p(i,3))], [y(3,p(i,1)) y(3,p(i,2)) y(3,p(i,3))],c(i));
    end

    xlabel('x1-axis'); ylabel('x2-axis'); zlabel('x3-axis');
    text(20, 60, 60, '이서진 202500062');
    axis([-60 60 -60 60 -60 60]);
    view([60,60,60]);
    grid;
    pause(0.000001);
end