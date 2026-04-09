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

% make the circles
r1=2;
r2=4;
r3=25;
deg=0.1:0.1:360;
th=pi/180*deg;
c1=ones(3,3600);
c2=ones(3,3600);
c3=ones(3,3600);

c1(1,:)=r1*cos(th);
c1(2,:)=r1*sin(th);

c2(1,:)=r2*cos(th);
c2(2,:)=r2*sin(th);

c3(1,:)=r3*cos(th);
c3(2,:)=r3*sin(th);

% make 80 lines that cover c3
% 26 dots on a line
l=ones(3,4162);
l(1,1:26)=0;
l(2,1:26)=0:1:25;
l(3,1:26)=fancover_curve(l(2,1:26));
th=pi/40;
for i=27:26:2054
    R=[cos(th) sin(th) 0; -sin(th) cos(th) 0; 0 0 1];
    l(:,i:i+25)=R*l(:,i-26:i-1);
end
l(:,2081)=[0,0,1];
l(1:2,2082:4162)=l(1:2,1:2081);
l(3,2082:4162)=-l(3,1:2081)+2;

% make four buttons
but1=[-23 -13 -13 -23 -23;
      -40 -40 -30 -30 -40;
        1   1   1   1   1];
k=12;
A=[1 0 k; 0 1 0; 0 0 1];
but2=A*but1;
but3=A*but2;
but4=A*but3;

% 버튼 구현:
% - 전에 mlx로 한 것과 같이, 버튼 사각형 범위 내에 입력 좌표가 들어오면 해당 버튼 클릭으로 간주.
% - 한 cycle이 지날 때마다 pause 호출하여 클릭 이벤트 처리.
% - 회전 속도를 조절하는 변수 s의 값을 3*trig로 정의하고, (trig=1, cycle마다 3도씩 회전.)
% - 각 버튼 클릭할 때마다 전역변수 trig에 0, 1, 2, 3을 써서,
% - 다음 cycle에서의 s의 값에 변화를 준다. (버튼1 기준으로 1배, 2배, 3배 속도.)

figure(1);
% 반복문 내부에서 figure 내 객체들을 계속 다시 생성하면...
% - clf가 실행된 후, 버튼 객체가 다시 생성되기 전에 클릭을 한다면 이벤트가 씹히는 현상이 생긴다.
% => 객체들을 반복문 실행 전에 미리 만들어두고, set으로 데이터만 바꿔주기.
clf;
axis equal;
grid on;

% draw the blades
% keep the blade figures to update their coordinates later
bf1=patch(b1(1,:),b1(2,:),b1(3,:), 'w');
bf2=patch(b2(1,:),b2(2,:),b2(3,:), 'w');
bf3=patch(b3(1,:),b3(2,:),b3(3,:), 'w');

% draw the circles
patch(c2(1,:),c2(2,:),c2(3,:), 'w');
patch(c1(1,:),c1(2,:),c1(3,:), 'k');
line(c3(1,:),c3(2,:),c3(3,:), 'Color', 'black', 'LineWidth', 1);

% draw the lines
line(l(1,:),l(2,:),l(3,:), 'Color', 'black', 'LineWidth', 0.7);

% draw the buttons
patch(but1(1,:),but1(2,:),but1(3,:), 'k', 'ButtonDownFcn', @(~,~) get_click(0));
patch(but2(1,:),but2(2,:),but2(3,:), 'k', 'ButtonDownFcn', @(~,~) get_click(1));
patch(but3(1,:),but3(2,:),but2(3,:), 'k', 'ButtonDownFcn', @(~,~) get_click(2));
patch(but4(1,:),but4(2,:),but2(3,:), 'k', 'ButtonDownFcn', @(~,~) get_click(3));

% write the button texts
text(but1(1,1)+4, but1(2,1)+5, 1, '00', 'Color', 'white', 'PickableParts', 'none');
text(but2(1,1)+4, but2(2,1)+5, 1, '01', 'Color', 'white', 'PickableParts', 'none');
text(but3(1,1)+4, but3(2,1)+5, 1, '10', 'Color', 'white', 'PickableParts', 'none');
text(but4(1,1)+4, but4(2,1)+5, 1, '11', 'Color', 'white', 'PickableParts', 'none');

view(3);

% 축 제한 거는 건 그림 다 그리고 나서.
xlabel('x');
ylabel('y');
zlabel('z');
axis([-40 40 -45 30 -30 30]);

global trig;
trig=0;
deg=0;
while true
    % update s by trig
    s=update_s();

    % calculate the new coordinates of the blades by the new deg
    th=deg*pi/180;
    R=[cos(th) sin(th) 0; -sin(th) cos(th) 0; 0 0 1];
    t1=R*b1;
    t2=R*b2;
    t3=R*b3;

    % update the blade figure data
    set(bf1, 'XData', t1(1,:), 'YData', t1(2,:));
    set(bf2, 'XData', t2(1,:), 'YData', t2(2,:));
    set(bf3, 'XData', t3(1,:), 'YData', t3(2,:));

    % update the rotation degree
    deg=mod((deg+s),360);

    % according to matlab pause manual:
    % pause(n) gives cpu some time to rest for n seconds
    % ... and checks events and executes the callback function
    pause(0.01);
end

% update s depending on trig
function s=update_s()
    global trig;
    s=3*trig;
end

% update trig when a mouse click occurs
function get_click(level)
    global trig;
    trig=level;
end

function z=fancover_curve(y)
    z=3*sin((pi/25)*y)+1;
end

%% 현재 문제
%  - fan line이 원점에서 radius만큼 y축 방향으로 올라갔다가 다시 원점으로 돌아오고 있음(z=1로..).
%  - 그래서 볼록한 곡선 아래 직선이 깔림. line이 인접한 좌표들을 모두 직선으로 연결하기 때문임.
%  - 곡선 아래 아무것도 없도록 하고 싶음. 방법이?
%  - 아랫단도 곡선을 만들어주면 괜찮을 것 같음.
%  - 근데 윗단 아랫단 곡선을 한번에 만들면...
%    - 선풍기 날이 커버 내부에 있는 게 아니라 커버가 날 위에 둥둥 떠있는 모양이 된다.
%  - 커버 z 중간값을 0으로 두면 된다.
%  - 그럼 커버 아랫단이 날 아래를 지나간다. 해결.

% - 지금 커버 끝이 너무 뾰족한 게 마음에 안 든다.