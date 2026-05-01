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
noRot2=8;% no of 2nd rotation (자전)
vpoint = [60,60,60]; % 내가 바라보는 시점의 좌표 (viewpoint)
vgain = 8000; % 원근감 조절을 위한 사용자 설정 계수

for x1=0:0.15:20
    clf;
    % ex4와 동일하게 변수를 사용하는 방식으로 바꿨음.
    psi = noRot1*2*pi*x1/20;
    Rz_u = [cos(psi) -sin(psi) 0 x1; sin(psi) cos(psi) 0 0; 0 0 1 0; 0 0 0 1];

    % 회전 좌표 계산.
    y_before = Rz_u*d;
    % viewpoint와 회전된 8면체 꼭대기 꼭지점 간의 거리 계산.
    % => euclidean distance 계산.
    dist_vpoint = sqrt((y_before(1,1)-vpoint(1))^2 + (y_before(2,1)-vpoint(2))^2 + (y_before(3,1)-vpoint(3))^2);
    % 도형의 크기가 거리에 반비례하도록 설정한다.
    % vgain으로 도형이 어느 정도로 커지고 작아질 것인지 조절할 수 있다.
    % 기존 vgain=10000으로는 너무 과하게 커지는 것 같아서 8000으로 줄였다.
    y = y_before./(dist_vpoint.^2).* vgain;

    line([y(1,:) y(1,1)], [y(2,:) y(2,1)], [y(3,:) y(3,1)]);
    line([40 0 0], [0 0 0], [0 0 0],'Color','r');
    line([0 0 0], [0 40 0], [0 0 0],'Color','g');
    line([0 0 0], [0 0 0], [0 0 40],'Color','k');
    
    orbit = [orbit; y(1,1) y(2,1), y(3,1)];
    line(orbit(:,1), orbit(:,2), orbit(:,3));
    
    for i = 1:1:8
        patch([y(1,p(i,1)) y(1,p(i,2)) y(1,p(i,3))], ...
            [y(2,p(i,1)) y(2,p(i,2)) y(2,p(i,3))], ...
            [y(3,p(i,1)) y(3,p(i,2)) y(3,p(i,3))], ...
            c(i));
    end

    xlabel('x1-axis'); ylabel('x2-axis'); zlabel('x3-axis');
    text(20, 60, 60, '이서진 202500062');
    axis([-60 60 -60 60 -60 60]);
    view([60,60,60]); grid;
    pause(0.000001);
end

for deg=0:2:720
    clf;
    x1 = 20 * cos(deg*pi/180);
    x2 = 20 * sin(deg*pi/180);
    x3 = -deg / (noRev * 360) * 20;
    psi = deg*4 * pi/180;
    Rz_round = [cos(psi) -sin(psi) 0 x1; sin(psi) cos(psi) 0 x2; 0 0 1 x3; 0 0 0 1];
    y_before = Rz_round*d;

    % 앞선 내용과 동일하다.
    dist_vpoint = sqrt((y_before(1,1)-vpoint(1))^2 + (y_before(2,1)-vpoint(2))^2 + (y_before(3,1)-vpoint(3))^2);
    y = y_before./(dist_vpoint.^2).* vgain;

    line([y(1,:) y(1,1)], [y(2,:) y(2,1)], [y(3,:) y(3,1)]);
    line([60 0 0], [0 0 0], [0 0 0],'Color','r');
    line([0 0 0], [0 60 0], [0 0 0],'Color','g');
    line([0 0 0], [0 0 0], [0 0 60],'Color','k');

    orbit = [orbit; y(1,1), y(2,1), y(3,1)];
    line(orbit(:,1), orbit(:,2), orbit(:,3));

    for i = 1:1:8
        patch([y(1,p(i,1)) y(1,p(i,2)) y(1,p(i,3))], ...
            [y(2,p(i,1)) y(2,p(i,2)) y(2,p(i,3))], ...
            [y(3,p(i,1)) y(3,p(i,2)), y(3,p(i,3))], ...
            c(i));
    end

    xlabel('x1-axis'); ylabel('x2-axis'); zlabel('x3-axis');
    text(20, 60, 60, '이서진 202500062');
    axis([-60 60 -60 60 -60 60]);
    view([60,60,60]); grid;
    pause(0.000001);
end