clear;clc;

% base
[X, Y, Z] = sphere(20);
Xc = reshape(X, 1, []);
Yc = reshape(Y, 1, []);
Zc = reshape(Z, 1, []);
orbit_size=160;

% galaxy
rev_gal=1;
rev_gal_radius=2000;
orbit_gal=zeros(orbit_size,3);
line_gal=gobjects(1,orbit_size-1);
linecolor_gal=[linspace(1,1,size(orbit_gal,1)); linspace(1,0,size(orbit_gal,1)); linspace(1,0,size(orbit_gal,1))]';
% linecolor_gal='b';
gal_sway_scale=50;

% sun
radius_sun=100;
sun=radius_sun*[Xc; Yc; Zc; zeros(size(Xc))];
sun(end,:)=sun(end,:)+1;
rev_sun=rev_gal*2;
rev_sun_radius=rev_gal_radius/2;
rot_sun=rev_sun*20;
orbit_sun=zeros(orbit_size,3);
line_sun=gobjects(1,orbit_size-1);
linecolor_sun=[linspace(1,0,size(orbit_sun,1)); linspace(1,0,size(orbit_sun,1)); linspace(1,1,size(orbit_sun,1))]';
% linecolor_sun='r';

% earth
radius_earth=radius_sun/2;
earth=radius_earth*[Xc; Yc; Zc; zeros(size(Xc))];
earth(end,:)=earth(end,:)+1;
rev_earth=rev_sun*16;
rev_earth_radius=radius_sun+1000;
rot_earth=rev_earth*365;
orbit_earth=zeros(orbit_size,3);
line_earth=gobjects(1,orbit_size-1);
linecolor_earth=[linspace(1,0,size(orbit_earth,1)); linspace(1,1,size(orbit_earth,1)); linspace(1,0,size(orbit_earth,1))]';
% linecolor_earth='g';

% mercury
radius_mercury=radius_earth/2;
mercury=radius_mercury*[Xc; Yc; Zc; zeros(size(Xc))];
mercury(end,:)=mercury(end,:)+1;
rev_mercury=rev_earth*4.15;
rev_mercury_radius=rev_earth_radius*0.4;
rot_mercury=rev_mercury*3;
orbit_mercury=zeros(orbit_size,3);
line_mercury=gobjects(1,orbit_size-1);
linecolor_mercury=[linspace(1,1,size(orbit_earth,1)); linspace(1,0,size(orbit_earth,1)); linspace(1,0,size(orbit_earth,1))]';

% venus
radius_venus=radius_earth/1.5;
venus=radius_venus*[Xc; Yc; Zc; zeros(size(Xc))];
venus(end,:)=venus(end,:)+1;
rev_venus=rev_earth*1.62;
rev_venus_radius=rev_earth_radius*0.7;
rot_venus=rev_venus*3;
orbit_venus=zeros(orbit_size,3);
line_venus=gobjects(1,orbit_size-1);
linecolor_venus=[linspace(1,1,size(orbit_earth,1)); linspace(1,1,size(orbit_earth,1)); linspace(1,0,size(orbit_earth,1))]';


axis_x=3500;
axis_y=3500;
axis_z=3500;
prev_G=zeros(0,0);

% figures
figure(1);
clf;
hold on;
sunfig=surf(X,Y,Z);
earthfig=surf(X,Y,Z);
mercuryfig=surf(X,Y,Z);
venusfig=surf(X,Y,Z);

for i=1:orbit_size-1
    line_gal(i)=line([orbit_gal(i,1),orbit_gal(i+1,1)], ...
        [orbit_gal(i,2),orbit_gal(i+1,2)], ...
        [orbit_gal(i,3),orbit_gal(i+1,3)]);
    line_sun(i)=line([orbit_sun(i,1),orbit_sun(i+1,1)], ...
        [orbit_sun(i,2),orbit_sun(i+1,2)], ...
        [orbit_sun(i,3),orbit_sun(i+1,3)]);
    line_earth(i)=line([orbit_earth(i,1),orbit_earth(i+1,1)], ...
        [orbit_earth(i,2),orbit_earth(i+1,2)], ...
        [orbit_earth(i,3),orbit_earth(i+1,3)]);
    line_mercury(i)=line([orbit_mercury(i,1),orbit_mercury(i+1,1)], ...
        [orbit_mercury(i,2),orbit_mercury(i+1,2)], ...
        [orbit_mercury(i,3),orbit_mercury(i+1,3)]);
    line_venus(i)=line([orbit_venus(i,1),orbit_venus(i+1,1)], ...
        [orbit_venus(i,2),orbit_venus(i+1,2)], ...
        [orbit_venus(i,3),orbit_venus(i+1,3)]);

end

for i=0:0.005:5
    [rev_gal_phi,gu,gv,gw]=cal_revolution(rev_gal,rev_gal_radius,i,20,gal_sway_scale);
    [rev_sun_phi,su,sv,sw]=cal_revolution(rev_sun,rev_sun_radius,i,20,0);
    [rev_earth_phi,ev,eu,ew]=cal_revolution(rev_earth,rev_earth_radius,i,20,0);
    [rev_mercury_phi,mv,mu,mw]=cal_revolution(rev_mercury,rev_mercury_radius,i,20,0);
    [rev_venus_phi,vv,vu,vw]=cal_revolution(rev_venus,rev_venus_radius,i,20,0);

    galRev=[1 0 0 gu; 0 1 0 gv; 0 0 1 gw; 0 0 0 1];

    rot_sun_phi=rot_sun*2*pi*i/20;
    sunRev=galRev*[1 0 0 su; 0 1 0 sv; 0 0 1 sw; 0 0 0 1];
    sunRot=[cos(rot_sun_phi) 0 sin(rot_sun_phi) 0; 0 1 0 0; -sin(rot_sun_phi) 0 cos(rot_sun_phi) 0; 0 0 0 1];
    
    rot_earth_phi=rot_earth*2*pi*i/20;
    earthRev=sunRev*[1 0 0 eu; 0 1 0 ev; 0 0 1 ew; 0 0 0 1];
    % earthRot=[cos(rot_earth_phi) 0 sin(rot_earth_phi) 0; 0 1 0 0; -sin(rot_earth_phi) 0 cos(rot_earth_phi) 0; 0 0 0 1];
    earthRot=[1 0 0 0; 0 cos(rot_earth_phi) -sin(rot_earth_phi) 0; 0 sin(rot_earth_phi) cos(rot_earth_phi) 0; 0 0 0 1];

    rot_mercury_phi=rot_mercury*2*pi*i/20;
    mercuryRev=sunRev*[1 0 0 mu; 0 1 0 mv; 0 0 1 mw; 0 0 0 1];
    mercuryRot=[1 0 0 0; 0 cos(rot_mercury_phi) -sin(rot_mercury_phi) 0; 0 sin(rot_mercury_phi) cos(rot_mercury_phi) 0; 0 0 0 1];

    rot_venus_phi=rot_venus*2*pi*i/20;
    venusRev=sunRev*[1 0 0 vu; 0 1 0 vv; 0 0 1 vw; 0 0 0 1];
    venusRot=[1 0 0 0; 0 cos(rot_venus_phi) -sin(rot_venus_phi) 0; 0 sin(rot_venus_phi) cos(rot_venus_phi) 0; 0 0 0 1];

    nsun=sunRev*sunRot*sun;
    nsx=reshape(nsun(1,:),size(X));
    nsy=reshape(nsun(2,:),size(X));
    nsz=reshape(nsun(3,:),size(X));

    nearth=earthRev*earthRot*earth;
    nex=reshape(nearth(1,:),size(X));
    ney=reshape(nearth(2,:),size(X));
    nez=reshape(nearth(3,:),size(X));

    nmercury=mercuryRev*mercuryRot*mercury;
    nmx=reshape(nmercury(1,:),size(X));
    nmy=reshape(nmercury(2,:),size(X));
    nmz=reshape(nmercury(3,:),size(X));

    nvenus=venusRev*venusRot*venus;
    nvx=reshape(nvenus(1,:),size(X));
    nvy=reshape(nvenus(2,:),size(X));
    nvz=reshape(nvenus(3,:),size(X));

    orbit_gal=update_orbit(orbit_gal,galRev(1:3,end)');
    orbit_sun=update_orbit(orbit_sun,sunRev(1:3,end)');
    orbit_earth=update_orbit(orbit_earth,earthRev(1:3,end)');
    orbit_mercury=update_orbit(orbit_mercury,mercuryRev(1:3,end)');
    orbit_venus=update_orbit(orbit_venus,venusRev(1:3,end)');

    set(sunfig,'XData',nsx,'YData',nsy,'ZData',nsz);
    set(earthfig,'XData',nex,'YData',ney,'ZData',nez);
    set(mercuryfig,'XData',nmx,'YData',nmy,'ZData',nmz);
    set(venusfig,'XData',nvx,'YData',nvy,'ZData',nvz);

    for j=1:orbit_size-1
        draw_orbit(line_sun, orbit_sun, j, linecolor_sun)
        draw_orbit(line_earth, orbit_earth, j, linecolor_earth)
        draw_orbit(line_mercury, orbit_mercury, j, linecolor_mercury)
        draw_orbit(line_venus, orbit_venus, j, linecolor_venus)
    end

    view([60, 60, 60]);
    grid on;
    xlabel('x');
    ylabel('y');
    zlabel('z');
    axis equal;
    axis([-axis_x axis_x -axis_y axis_y -axis_z axis_z]);
    pause(0.0001);
end

function [phi,u,v,w]=cal_revolution(rev_no,rev_radius,sway_base,sway_base_max,sway_scale)
    phi=rev_no*2*pi*sway_base/sway_base_max;
    u=rev_radius*cos(phi);
    v=sway_scale*sway_base;
    w=rev_radius*sin(phi);
end

function orbit=update_orbit(orbit,revpoint)
    orbit=circshift(orbit,-1);
    orbit(end,:)=revpoint;
end

function draw_orbit(lineg, orbit, j, linc)
    if orbit(j,1) ~= 0
        set(lineg(j), 'XData', [orbit(j,1), orbit(j+1,1)], 'YData', [orbit(j,2), orbit(j+1,2)], 'ZData', [orbit(j,3), orbit(j+1,3)]);
        set(lineg(j), 'Color', linc(j,:), 'LineWidth', 1);
    end
end

% 1 cycle마다 버벅거림이 심하다.