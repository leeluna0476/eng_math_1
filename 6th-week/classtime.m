x=[0 1 1 4 7 7 8 8 7 4 1 0 0;
   0 0 6 0 6 0 0 8 8 2 8 8 0;
   1 1 1 1 1 1 1 1 1 1 1 1 1]; % 테두리 전부 감싸려면 마지막에 첫번째 좌표를 다시 넣어야 함.

% draw M
figure(1);
line(x(1,:),x(2,:))
axis([0 14 0 11]);
grid on;
text(10, 5, '202500062 / 이서진')

% symmetric to x1 axis
figure(2);
A=[1 0 0; 0 -1 0; 0 0 1];
y=A*x;
line(x(1,:), x(2,:)); % 원본
line(y(1,:), y(2,:));
axis([-10 10 -10 10]);
grid on;
text(-8, 2, '202500062 / 이서진')

% symmetric to x2 axis
figure(3);
A=[-1 0 0; 0 1 0; 0 0 1];
y=A*x;
line(x(1,:), x(2,:)); % 원본
line(y(1,:), y(2,:));
axis([-10 10 -10 10]);
grid on;
text(-2, 6, '202500062 / 이서진')

figure(4);
A=[-1 0 0; 0 -1 0; 0 0 1];
y=A*x;
line(x(1,:), x(2,:)); % 원본
line(y(1,:), y(2,:));
axis([-10 10 -10 10]);
grid on;
text(2, -6, '202500062 / 이서진')

figure(5);
A=[0 1 0; 1 0 0; 0 0 1];
y=A*x;
line(x(1,:), x(2,:)); % 원본
line(y(1,:), y(2,:));
axis([-10 10 -10 10]);
grid on;
text(2, -6, '202500062 / 이서진')

% italic
figure(6);
k=0.2;
A=[1 k 0; 0 1 0; 0 0 1];
y1=A*x;
k=0.5;
A=[1 k 0; 0 1 0; 0 0 1];
y2=A*x;
k=0.7;
A=[1 k 0; 0 1 0; 0 0 1];
y3=A*x;
line(x(1,:), x(2,:)); % 원본
line(y1(1,:), y1(2,:));
line(y2(1,:), y2(2,:));
line(y3(1,:), y3(2,:));
axis([-10 14 -10 10]);
grid on;
text(2, -6, '202500062 / 이서진')

% 이동
figure(7);
A=[1 0 2; 0 1 3; 0 0 1];
y=A*x;
line(x(1,:), x(2,:)); % 원본
line(y(1,:), y(2,:));
axis([-10 14 -10 14]);
grid on;
text(2, -6, '202500062 / 이서진')

% 기울임 -> 이동
figure(8);
A=[1 0 2; 0 1 3; 0 0 1];
B=[1 k 0; 0 1 0; 0 0 1];
y=A*B*x;
line(x(1,:), x(2,:)); % 원본
line(y(1,:), y(2,:));
axis([-10 18 -10 14]);
grid on;
text(2, -6, '202500062 / 이서진')

% 확대 + 축소
figure(9);
k=1.42;
A=[k 0 0; 0 k 0; 0 0 1];
y1=A*x;
k=0.42;
A=[k 0 0; 0 k 0; 0 0 1];
y2=A*x;
line(x(1,:), x(2,:)); % 원본
line(y1(1,:), y1(2,:));
line(y2(1,:), y2(2,:));
axis([-10 18 -10 14]);
grid on;
text(2, -6, '202500062 / 이서진')

motion: expand - shrink
figure(10);
for h=0.1:0.01:3
    A=[h 0 0; 0 h 0; 0 0 1];
    y=A*x;
    clf;
    axis([0 30 0 30]);
    line(y(1,:), y(2,:));
    grid on;
    text(20, 6, '202500062 / 이서진')
    pause(0.001);
end
for h=3:-0.01:0.01
    A=[h 0 0; 0 h 0; 0 0 1];
    y=A*x;
    clf;
    axis([0 30 0 30]);
    line(y(1,:), y(2,:));
    grid on;
    text(20, 6, '202500062 / 이서진')
    pause(0.001);
end

motion: rotation
figure(11);
for s=0:1:360
    th=s*pi/180;
    A=[cos(th) sin(th) 0; -sin(th) cos(th) 0; 0 0 1];
    y=A*x;
    clf;
    axis([-30 30 -30 30]);
    line(y(1,:), y(2,:));
    grid on;
    text(10, 6, '202500062 / 이서진')
    pause(0.000001);
end
% for s=0:0.5:360
for s=360:-1:0
    th=s*pi/180;
    % A=[cos(th) -sin(th) 0; sin(th) cos(th) 0; 0 0 1];
    A=[cos(th) sin(th) 0; -sin(th) cos(th) 0; 0 0 1];
    y=A*x;
    clf;
    axis([-30 30 -30 30]);
    line(y(1,:), y(2,:));
    grid on;
    text(10, 6, '202500062 / 이서진')
    pause(0.000001);
end

% example
x=[3; 2];
