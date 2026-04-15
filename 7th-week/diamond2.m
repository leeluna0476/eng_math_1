d=[ 0  5 5  0 -5 5   0 -5 -5   0  5 -5  0;
    0 -5 5  0  5 5   0  5 -5   0 -5 -5  0;
   20  0 0 20  0 0 -20  0  0 -20  0  0 20;
    1  1 1  1  1 1   1  1  1   1  1  1  1];

p=[1 2 3; 4 5 6; 5 6 7; 8 9 10; 9 10 11; 11 12 13; 1 8 9; 2 3 7];
c = ['b';'r';'g';'w';'k';'c';'m';'y'];

x3=0;
r_Rev=20; % Radius of revolution
orbit = [0,0,20];
orbit2 = [0,0,-20];
orbit3 = [-5 5 0];
noRot1=2; % no of 1st rotation
noRev=2;% no of revolution (공전)
noRot2=4;% no of 2nd rotation (자전)
for x1 = 0:0.15:20
    clf;
    psi = noRot1 * 2 * pi * x1/20;
    % x1축 방향으로 +20 평행이동
    Rz_u = [cos(psi) -sin(psi) 0 x1; sin(psi) cos(psi) 0 0; 0 0 1 0; 0 0 0 1];
    y = Rz_u*d;
    line([y(1,:) y(1,1)], [y(2,:) y(2,1)], [y(3,:) y(3,1)]);
    line([40 0 0], [0 0 0], [0 0 0],'Color','r');
    line([0 0 0], [0 40 0], [0 0 0],'Color','g');
    line([0 0 0], [0 0 0], [0 0 40],'Color','k');
    orbit = [orbit; y(1,1) y(2,1), y(3,1)];
    orbit2 = [orbit2; y(1,7) y(2,7), y(3,7)];
    orbit3 = [orbit3; y(1,5) y(2,5), y(3,5)];
    line(orbit(:,1), orbit(:,2), orbit(:,3), 'Color', 'b');
    line(orbit2(:,1), orbit2(:,2), orbit2(:,3), 'Color', 'r');
    line(orbit3(:,1), orbit3(:,2), orbit3(:,3), 'Color', 'k');
    for i = 1:1:8
        patch([y(1,p(i,1)) y(1,p(i,2)) y(1,p(i,3))], [y(2,p(i,1)) y(2,p(i,2)) y(2,p(i,3))], [y(3,p(i,1)) y(3,p(i,2)) y(3,p(i,3))],c(i));
    end
    xlabel('x1-axis'); ylabel('x2-axis'); zlabel('x3-axis');
    axis([-60 60 -60 60 -60 60]);
    view([60,60,60]); grid;
    pause(0.000001);
end

for deg = 0:2: noRev * 360 % Revolutional angle 공전각도 (2 Revolutions)
    clf;
    x1 = r_Rev * cos(deg*pi/180);
    x2 = r_Rev * sin(deg*pi/180);
    x3 = -deg / (noRev * 360) * 20;
    psi = deg * noRot2 * 2 * pi/180; % Rotational angle 자전각도 (8 Rotations/1 Revolution)
    Rz_round = [cos(psi) -sin(psi) 0 x1; sin(psi) cos(psi) 0 x2; 0 0 1 x3; 0 0 0 1];
    y = Rz_round*d; % Rotation 자전 계산
    line([y(1,:) y(1,1)], [y(2,:) y(2,1)], [y(3,:) y(3,1)]);
    line([60 0 0], [0 0 0], [0 0 0],'Color','r');
    line([0 0 0], [0 60 0], [0 0 0],'Color','g');
    line([0 0 0], [0 0 0], [0 0 60],'Color','k');
    orbit = [orbit; y(1,1), y(2,1), y(3,1)]; line(orbit(:,1), orbit(:,2), orbit(:,3), 'Color', 'b');
    orbit2 = [orbit2; y(1,7), y(2,7), y(3,7)]; line(orbit2(:,1), orbit2(:,2), orbit2(:,3), 'Color', 'r');
    orbit3 = [orbit3; y(1,5), y(2,5), y(3,5)]; line(orbit3(:,1), orbit3(:,2), orbit3(:,3), 'Color', 'k');
% Orbit of Revolution 공전궤도
    for i = 1:1:8
        patch([y(1,p(i,1)) y(1,p(i,2)) y(1,p(i,3))], [y(2,p(i,1)) y(2,p(i,2)) y(2,p(i,3))], [y(3,p(i,1)) y(3,p(i,2)) y(3,p(i,3))],c(i));
    end
    xlabel('x1-axis'); ylabel('x2-axis'); zlabel('x3-axis');
    axis([-60 60 -60 60 -60 60]);
    view([60,60,60]); grid;
    pause(0.000001);
end