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
c1=zeros(2,3600);
c2=zeros(2,3600);
% for deg=1:1:3600
%     th=deg*pi/1800;
%     c1(1,deg)=r1*cos(th);
%     c1(2,deg)=r1*sin(th);
%     c2(1,deg)=r2*cos(th);
%     c2(2,deg)=r2*sin(th);
% end

% 좀 matlab처럼 써보기
deg=0.1:0.1:360;
th=pi/180*deg;

c1(1,:)=r1*cos(th);
c1(2,:)=r1*sin(th);

c2(1,:)=r2*cos(th);
c2(2,:)=r2*sin(th);

% make four buttons
but1=[-23 -13 -13 -23 -23;
      -35 -35 -25 -25 -35;
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
bf1=line(b1(1,:),b1(2,:), 'Color', 'black');
bf2=line(b2(1,:),b2(2,:), 'Color', 'black');
bf3=line(b3(1,:),b3(2,:), 'Color', 'black');

% draw the circles
patch(c2(1,:),c2(2,:), 'w');
patch(c1(1,:),c1(2,:), 'k');

% draw the buttons
patch(but1(1,:),but1(2,:), 'k', 'ButtonDownFcn', @(~,~) get_click(0));
patch(but2(1,:),but2(2,:), 'k', 'ButtonDownFcn', @(~,~) get_click(1));
patch(but3(1,:),but3(2,:), 'k', 'ButtonDownFcn', @(~,~) get_click(2));
patch(but4(1,:),but4(2,:), 'k', 'ButtonDownFcn', @(~,~) get_click(3));

% write the button texts
text(but1(1,1)+4, but1(2,1)+5, '00', 'Color', 'white');
text(but2(1,1)+4, but2(2,1)+5, '01', 'Color', 'white');
text(but3(1,1)+4, but3(2,1)+5, '10', 'Color', 'white');
text(but4(1,1)+4, but4(2,1)+5, '11', 'Color', 'white');

% 축 제한 거는 건 그림 다 그리고 나서.
axis([-40 40 -40 25]);

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

    % update the blade figures' datas
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

% updates trig when mouse click occurs
function get_click(level)
    global trig;
    trig=level;
end

%% 현재 버그
% - 버튼 위에 있는 텍스트 부분을 클릭하면 클릭이 안 먹는다. 서로 다른 객체여서 그런 듯.
% - 텍스트에도 콜백을 등록해야 하나? 아니면 텍스트를 뚫고 버튼에 클릭이 들어가게 할 방법은 없나?
