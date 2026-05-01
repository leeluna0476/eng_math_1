%   1  2 3  4  5 6   7  8  9  10 11 12 13
d=[ 0  5 5  0 -5 5   0 -5 -5   0  5 -5  0;
    0 -5 5  0  5 5   0  5 -5   0 -5 -5  0;
   20  0 0 20  0 0 -20  0  0 -20  0  0 20;
    1  1 1  1  1 1   1  1  1   1  1  1  1];

p = [1 2 3; 4 5 6; 5 6 7; 8 9 10; 9 10 11; 11 12 13; 1 8 9; 2 3 7];
c = ['b';'r';'g';'w';'k';'c';'m';'y'];



% 팔면체 상부 꼭지점의 좌표.
% 궤도를 부분적으로 그리기 위해 좌표 40개만 저장한다.
orbit = zeros(40,3);

% 궤적을 나타낼 RGB 색상 정의.
% 1,1,1 (흰색)부터 0,0,1(파란색)까지 그라데이션.
linc = [linspace(1,0,size(orbit,1)); linspace(1,0,size(orbit,1)); linspace(1,1,size(orbit,1))]';

orbit(end,:) = [0,0,20];

x3=0;
el = 45;

r_Rev=20; % Radius of revolution
noRot1=2; % no of 1st rotation
noRev=2;% no of revolution (공전)
noRot2=4;% no of 2nd rotation (자전)

for x1 = 0:0.3:20
    clf;
    psi = 4*pi*x1/20;
    Rz_u = [cos(psi) -sin(psi) 0 x1; sin(psi) cos(psi) 0 0; 0 0 1 0; 0 0 0 1];
    y = Rz_u * d;

    line([y(1,:) y(1,1)], [y(2,:) y(2,1)], [y(3,:) y(3,1)])
    line([40 0 0], [0 0 0], [0 0 0], 'Color','r');
    line([0 0 0], [0 40 0], [0 0 0], 'Color','g');
    line([0 0 0], [0 0 0], [0 0 40], 'Color','k');

    % 상부 꼭지점의 최근 40개 좌표만 저장.
    % 가장 최신 좌표를 맨 마지막 행에 저장.
    orbit = circshift(orbit,-1);
    orbit(end,:) = [y(1,1) y(2,1) y(3,1)];


    % 꼭지점에 가까운 데이터일수록 진한 파란색으로 표시.
    for j = 1: size(orbit,1)-1
        line([orbit(j,1) orbit(j+1,1)],[orbit(j,2) orbit(j+1,2)], [orbit(j,3) orbit(j+1,3)], ...
            'Color',linc(j,:),'LineWidth',2);
    end
    
    for i = 1:1:8
        patch([y(1,p(i,1)) y(1,p(i,2)) y(1,p(i,3))], [y(2,p(i,1)) y(2,p(i,2)) y(2,p(i,3))], ...
            [y(3,p(i,1)) y(3,p(i,2)) y(3,p(i,3))],c(i));
    end

    xlabel('x1-axis'); ylabel('x2-axis'); zlabel(';x3-axis');
    % 직선운동하는 동안 az angle은 0부터 90도까지 변화한다. 20*4.5=90.
    az = x1*4.5;
    % viewpoint 좌표 계산하여 학번 이름 고정.
    text(cosd(el)*sind(az),cosd(el)*cosd(az),sind(el), '이서진 202500062');
    axis([-60 60 -60 60 -60 60]); grid;
    view(az,el)
    pause(0.0000001);
end

for deg = 0:4:720
    clf;
    x1 = 20 * cos(deg*pi/180); x2 = 20 * sin(deg*pi/180); x3 = -deg / (noRev * 360) * 20;
    psi = deg *4 * pi/180;
    Rz_round = [cos(psi) -sin(psi) 0 x1; sin(psi) cos(psi) 0 x2; 0 0 1 x3; 0 0 0 1];
    y = Rz_round * d;
    line([y(1,:) y(1,1)], [y(2,:) y(2,1)], [y(3,:) y(3,1)])
    line([40 0 0], [0 0 0], [0 0 0], 'Color','r');
    line([0 0 0], [0 40 0], [0 0 0], 'Color','g');
    line([0 0 0], [0 0 0], [0 0 40], 'Color','k');
    orbit = circshift(orbit,-1);
    orbit(end,:) = [y(1,1) y(2,1) y(3,1)];
    for j = 1: size(orbit,1)-1
        line([orbit(j,1) orbit(j+1,1)],[orbit(j,2) orbit(j+1,2)], [orbit(j,3) orbit(j+1,3)], ...
            'Color',linc(j,:),'LineWidth',2);
    end
    for i = 1:1:8
        patch([y(1,p(i,1)) y(1,p(i,2)) y(1,p(i,3))], [y(2,p(i,1)) y(2,p(i,2)) y(2,p(i,3))], ...
            [y(3,p(i,1)) y(3,p(i,2)) y(3,p(i,3))],c(i));
    end
    xlabel('x1-axis'); ylabel('x2-axis'); zlabel(';x3-axis');
    
    % 나선운동하는 동안 90도부터 450도까지 변화. 90+720/2=450
    az2 = az + deg/2;
    % 나선운동하는 동안 45도부터 -30도까지 두번 반복.
    % 75*sind(360)=75*sind(720)=75
    % 45-75=-30.. el2가 가장 작은 값을 가질 때 -30이 되도록 세팅.
    % 주기가 2pi인 sine함수를 사용하여 팔면체가 720도 공전하는 동안
    %     el2가 45도부터 -30도까지 두번 변화하도록 함.
    el2 = el - 75*sind(deg);
    % viewpoint 좌표 계산하여 학번 이름 고정.
    text(cosd(el2)*sind(az2),cosd(el2)*cosd(az2),sind(el2), '이서진 202500062');
    axis([-60 60 -60 60 -60 60]); grid;
    view(az2,el2);
    pause(0.0000001);
end