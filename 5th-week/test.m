clear; clc;

theta=-1:0.001:1;
figure(1);
plot(theta, asin(theta));
grid on;
axis equal;
hold on;

plot(theta, acos(theta));
legend('asin', 'acos')

a=[-2; 1; -1];
b=[1 -2 3];

cn=norm(cross(a, b));
sy=cn/(norm(a)*norm(b));
figure(2);
plot_vec(a);
plot_vec(b);

function plot_vec(v)
    quiver(0, 0, v(1), v(2));
    grid on;
    axis equal
    hold on;
end