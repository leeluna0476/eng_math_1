clear;
a1=[1 1 0]';
a2=[2 2 0]'; % a2 is dependent to a1. it does not reduce the span. it is in the span.
a3=[0 0 0]';

n=5;
for a=-n:1:n
    for b=-n:1:n
        for c=-n:1:n
            s=[a; b; c];
            v=(a1+a2+a3).*s; % give a scale
            plotVec(v);
        end
    end
end



function plotVec(vec)
    % plotVec(vec) takes a 3x1 or 1x3 vector and plots it as a point
    % Using '.' makes it render significantly faster than arrows
    quiver3(0,0,0,vec(1),vec(2),vec(3));
    %plot3(vec(1), vec(2), vec(3), '.', 'MarkerSize', 5);
    xlabel('X'), ylabel('Y'), zlabel('Z')
    grid on;
    hold on;
    axis equal;
end