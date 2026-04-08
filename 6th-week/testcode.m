% the first blade
b1=[ 0  0  2  6  8 10 16 18 20 20 19 17 15 14  8  3  0;
     0  8 12 16 17 17 14 12  8  2  0 -2 -1  0  2  2  0;
     1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1];

% make two more blades by rotating b1
th=2*pi/3;
R=[cos(th) sin(th) 0; -sin(th) cos(th) 0; 0 0 1];
% the second blade
b2=R*b1;
% the third blade
b3=R*b2;

% the pivotal circles
r1=2;
r2=4;
c1=zeros(3,3600);
c2=zeros(3,3600);
for th=1:1:3600
    rad=th*pi/1800;
    c1(1,th)=r1*cos(rad);
    c1(2,th)=r1*sin(rad);
    c2(1,th)=r2*cos(rad);
    c2(2,th)=r2*sin(rad);
end

% make four buttons
but1=[-23 -13 -13 -23 -23;
      -35 -35 -25 -25 -35;
        1   1   1   1   1];
k=12;
A=[1 0 k; 0 1 0; 0 0 1];
but2=A*but1;
but3=A*but2;
but4=A*but3;

% 문제:
% 1. 버튼 구현
%   - mlx로 한 것과 같이, 버튼 사각형 범위 내에 입력 좌표가 들어오면 해당 버튼 클릭으로 간주.
% 2. 선풍기가 돌아가는 중에도 입력을 받으려면?
%   - 인터럽트 식으로 입력을 받아야 하나? -> yes
%   - 한 cycle이 지나고 s 업데이트.

% trig:
%   0: stop
%   1: s=30
%   2: s=60
%   3: s=90



global trig;
trig=0;
th=0;

figure(1);
% 반복문 내부에서 figure 내 객체들을 계속 다시 생성하면...
% - clf가 된 후, 버튼 객체가 다시 생성되기 전에 클릭을 한다면 클릭이 씹히는 현상이 생긴다.
% => 객체들을 반복문 실행 전에 미리 만들어두고, set으로 데이터만 바꿔주기.
% clf;
% axis equal;
% grid on;
% 
% % draw the blades
% bf1=line(b1(1,:),b1(2,:), 'Color', 'black');
% bf2=line(b2(1,:),b2(2,:), 'Color', 'black');
% bf3=line(b3(1,:),b3(2,:), 'Color', 'black');
% 
% % draw the circles
% patch(c2(1,:),c2(2,:), 'w');
% patch(c1(1,:),c1(2,:), 'k');
% 
% % draw the buttons
% patch(but1(1,:),but1(2,:), 'k', 'ButtonDownFcn', @get_click);
% patch(but2(1,:),but2(2,:), 'k');
% patch(but3(1,:),but3(2,:), 'k');
% patch(but4(1,:),but4(2,:), 'k');
% 
% % write the button texts
% text(but1(1,1)+4, but1(2,1)+5, '00', 'Color', 'white', 'HitTest','off');
% text(but2(1,1)+4, but2(2,1)+5, '01', 'Color', 'white', 'HitTest','off');
% text(but3(1,1)+4, but3(2,1)+5, '10', 'Color', 'white', 'HitTest','off');
% text(but4(1,1)+4, but4(2,1)+5, '11', 'Color', 'white', 'HitTest','off');
% 
% % 축 제한 거는 건 그림 다 그리고 나서.
% axis([-40 40 -40 25]);

while true
    s=update_s();
    fprintf('s=%d\n', s);

    rad=th*pi/1800;
    R=[cos(rad) sin(rad) 0; -sin(rad) cos(rad) 0; 0 0 1];
    t1=R*b1;
    t2=R*b2;
    t3=R*b3;

    % set(bf1, 'XData', t1(1,:), 'YData', t1(2,:));
    % set(bf2, 'XData', t2(1,:), 'YData', t2(2,:));
    % set(bf3, 'XData', t3(1,:), 'YData', t3(2,:));

    clf;
    axis equal;
    grid on;

    fprintf("Cleared figures\n");
    pause(1.0);

    % draw the blades
    line(t1(1,:),t1(2,:), 'Color', 'black');
    line(t2(1,:),t2(2,:), 'Color', 'black');
    line(t3(1,:),t3(2,:), 'Color', 'black');

    % draw the circles
    patch(c2(1,:),c2(2,:), 'w');
    patch(c1(1,:),c1(2,:), 'k');

    % draw the buttons
    patch(but1(1,:),but1(2,:), 'k', 'ButtonDownFcn', @get_click);
    patch(but2(1,:),but2(2,:), 'k');
    patch(but3(1,:),but3(2,:), 'k');
    patch(but4(1,:),but4(2,:), 'k');

    % write the button texts
    text(but1(1,1)+4, but1(2,1)+5, '00', 'Color', 'white');
    text(but2(1,1)+4, but2(2,1)+5, '01', 'Color', 'white');
    text(but3(1,1)+4, but3(2,1)+5, '10', 'Color', 'white');
    text(but4(1,1)+4, but4(2,1)+5, '11', 'Color', 'white');

    % 축 제한 거는 건 그림 다 그리고 나서.
    axis([-40 40 -40 25]);

    th=mod((th+s),3600);

    % give time for cpu to rest
    % ... and to check click events and execute the callback function
    pause(2.0);
end

% update s depending on trig
function s=update_s()
    global trig;
    s=30*trig;
end

% updates trig when mouse click occurs
function get_click(~,~)
    global trig;
    trig=mod(trig + 1, 4);
    fprintf("Trigger=%d\n", trig);
end