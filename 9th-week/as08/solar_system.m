clear;clc;

% base
[X, Y, Z] = sphere(20);
Xc = reshape(X, 1, []);
Yc = reshape(Y, 1, []);
Zc = reshape(Z, 1, []);
orbit_size=320;

% galaxy
rev_gal=1;
rev_gal_radius=5000;
orbit_gal=zeros(orbit_size,3);
linecolor_gal=[linspace(1,1,orbit_size); linspace(1,0,orbit_size); linspace(1,0,orbit_size)]';
gal_sway_scale=50;

% sun
radius_sun=100;
sun=radius_sun*[Xc; Yc; Zc; zeros(size(Xc))];
sun(end,:)=sun(end,:)+1;
rev_sun=rev_gal*5;
rev_sun_radius=rev_gal_radius/2;
rot_sun=rev_sun*20;
orbit_sun=zeros(orbit_size,3);
linecolor_sun=[linspace(1,0,orbit_size); linspace(1,0,orbit_size); linspace(1,0,orbit_size)]';

% earth
radius_earth=radius_sun/3.5;
earth=radius_earth*[Xc; Yc; Zc; zeros(size(Xc))];
earth(end,:)=earth(end,:)+1;
rev_earth=rev_sun*16;
rev_earth_radius=radius_sun+1000;
rot_earth=rev_earth*365;
orbit_earth=zeros(orbit_size,3);
linecolor_earth=[linspace(1,0,orbit_size); linspace(1,1,orbit_size); linspace(1,0,orbit_size)]';

% mercury
radius_mercury=radius_earth/2;
mercury=radius_mercury*[Xc; Yc; Zc; zeros(size(Xc))];
mercury(end,:)=mercury(end,:)+1;
rev_mercury=rev_earth*4.15;
rev_mercury_radius=rev_earth_radius*0.4;
rot_mercury=rev_mercury*3;
orbit_mercury=zeros(orbit_size,3);
linecolor_mercury=[linspace(1,1,orbit_size); linspace(1,1,orbit_size); linspace(1,0,orbit_size)]';

% venus
radius_venus=radius_earth/1.5;
venus=radius_venus*[Xc; Yc; Zc; zeros(size(Xc))];
venus(end,:)=venus(end,:)+1;
rev_venus=rev_earth*1.62;
rev_venus_radius=rev_earth_radius*0.723;
rot_venus=rev_venus*0.92;
orbit_venus=zeros(orbit_size,3);
linecolor_venus=[linspace(1,1,orbit_size); linspace(1,0,orbit_size); linspace(1,0,orbit_size)]';

% mars
radius_mars=radius_earth/1.2;
mars=radius_mars*[Xc; Yc; Zc; zeros(size(Xc))];
mars(end,:)=mars(end,:)+1;
rev_mars=rev_earth*0.54;
rev_mars_radius=rev_earth_radius*1.524;
rot_mars=rev_mars*667;
orbit_mars=zeros(orbit_size,3);
linecolor_mars=[linspace(1,0,orbit_size); linspace(1,1,orbit_size); linspace(1,1,orbit_size)]';

% jupiter
radius_jupiter=radius_earth*2;
jupiter=radius_jupiter*[Xc; Yc; Zc; zeros(size(Xc))];
jupiter(end,:)=jupiter(end,:)+1;
rev_jupiter=rev_earth*0.45;
rev_jupiter_radius=rev_earth_radius*3;
rot_jupiter=rev_jupiter*1000;
orbit_jupiter=zeros(orbit_size,3);
linecolor_jupiter=[linspace(1,1,orbit_size); linspace(1,0,orbit_size); linspace(1,1,orbit_size)]';

% saturn
radius_saturn=radius_earth*1.7;
saturn=radius_saturn*[Xc; Yc; Zc; zeros(size(Xc))];
saturn(end,:)=saturn(end,:)+1;
rev_saturn=rev_earth*0.35;
rev_saturn_radius=rev_earth_radius*3.5;
rot_saturn=rev_saturn*2410;
orbit_saturn=zeros(orbit_size,3);
linecolor_saturn=[linspace(1,0,orbit_size); linspace(1,0,orbit_size); linspace(1,1,orbit_size)]';

% uranus
radius_uranus=radius_earth*1.3;
uranus=radius_uranus*[Xc; Yc; Zc; zeros(size(Xc))];
uranus(end,:)=uranus(end,:)+1;
rev_uranus=rev_earth*0.25;
rev_uranus_radius=rev_earth_radius*4.5;
rot_uranus=rev_uranus*4280;
orbit_uranus=zeros(orbit_size,3);
linecolor_uranus=[linspace(1,0.1,orbit_size); linspace(1,0.8,orbit_size); linspace(1,0.5,orbit_size)]';

axis_x=10000;
axis_y=10000;
axis_z=10000;
prev_G=zeros(0,0);

% figures
figure(1);
clf;
hold on;
sunfig=surf(X,Y,Z);
earthfig=surf(X,Y,Z);
mercuryfig=surf(X,Y,Z);
venusfig=surf(X,Y,Z);
marsfig=surf(X,Y,Z);
jupiterfig=surf(X,Y,Z);
saturnfig=surf(X,Y,Z);
uranusfig=surf(X,Y,Z);

orbitfig_gal=create_orbitfig(orbit_size, linecolor_gal);
orbitfig_sun=create_orbitfig(orbit_size, linecolor_sun);
orbitfig_earth=create_orbitfig(orbit_size, linecolor_earth);
orbitfig_mercury=create_orbitfig(orbit_size, linecolor_mercury);
orbitfig_venus=create_orbitfig(orbit_size, linecolor_venus);
orbitfig_mars=create_orbitfig(orbit_size, linecolor_mars);
orbitfig_jupiter=create_orbitfig(orbit_size, linecolor_jupiter);
orbitfig_saturn=create_orbitfig(orbit_size, linecolor_saturn);
orbitfig_uranus=create_orbitfig(orbit_size, linecolor_uranus);
% orbitfig_neptune=create_orbitfig(orbit_size, linecolor_neptune);


for i=0:0.005:20
    [rev_gal_phi,gv,gu,gw]=cal_revolution(rev_gal,rev_gal_radius,i,20,gal_sway_scale);
    [rev_sun_phi,su,sv,sw]=cal_revolution(rev_sun,rev_sun_radius,i,20,0);
    [rev_earth_phi,ev,eu,ew]=cal_revolution(rev_earth,rev_earth_radius,i,20,0);
    [rev_mercury_phi,mv,mu,mw]=cal_revolution(rev_mercury,rev_mercury_radius,i,20,0);
    [rev_venus_phi,vv,vu,vw]=cal_revolution(rev_venus,rev_venus_radius,i,20,0);
    [rev_mars_phi,mrv,mru,mrw]=cal_revolution(rev_mars,rev_mars_radius,i,20,0);
    [rev_jupiter_phi,jv,ju,jw]=cal_revolution(rev_jupiter,rev_jupiter_radius,i,20,0);
    [rev_saturn_phi,stv,stu,stw]=cal_revolution(rev_saturn,rev_saturn_radius,i,20,0);
    [rev_uranus_phi,uv,uu,uw]=cal_revolution(rev_uranus,rev_uranus_radius,i,20,0);

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

    rot_mars_phi=rot_mars*2*pi*i/20;
    marsRev=sunRev*[1 0 0 mru; 0 1 0 mrv; 0 0 1 mrw; 0 0 0 1];
    marsRot=[1 0 0 0; 0 cos(rot_mars_phi) -sin(rot_mars_phi) 0; 0 sin(rot_mars_phi) cos(rot_mars_phi) 0; 0 0 0 1];

    rot_jupiter_phi=rot_jupiter*2*pi*i/20;
    jupiterRev=sunRev*[1 0 0 ju; 0 1 0 jv; 0 0 1 jw; 0 0 0 1];
    jupiterRot=[1 0 0 0; 0 cos(rot_jupiter_phi) -sin(rot_jupiter_phi) 0; 0 sin(rot_jupiter_phi) cos(rot_jupiter_phi) 0; 0 0 0 1];

    rot_saturn_phi=rot_saturn*2*pi*i/20;
    saturnRev=sunRev*[1 0 0 stu; 0 1 0 stv; 0 0 1 stw; 0 0 0 1];
    saturnRot=[1 0 0 0; 0 cos(rot_saturn_phi) -sin(rot_saturn_phi) 0; 0 sin(rot_saturn_phi) cos(rot_saturn_phi) 0; 0 0 0 1];

    rot_uranus_phi=rot_uranus*2*pi*i/20;
    uranusRev=sunRev*[1 0 0 uu; 0 1 0 uv; 0 0 1 uw; 0 0 0 1];
    uranusRot=[1 0 0 0; 0 cos(rot_uranus_phi) -sin(rot_uranus_phi) 0; 0 sin(rot_uranus_phi) cos(rot_uranus_phi) 0; 0 0 0 1];

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

    nmars=marsRev*marsRot*mars;
    nmrx=reshape(nmars(1,:),size(X));
    nmry=reshape(nmars(2,:),size(X));
    nmrz=reshape(nmars(3,:),size(X));

    njupiter=jupiterRev*jupiterRot*jupiter;
    njx=reshape(njupiter(1,:),size(X));
    njy=reshape(njupiter(2,:),size(X));
    njz=reshape(njupiter(3,:),size(X));

    nsaturn=saturnRev*saturnRot*saturn;
    nstx=reshape(nsaturn(1,:),size(X));
    nsty=reshape(nsaturn(2,:),size(X));
    nstz=reshape(nsaturn(3,:),size(X));

    nuranus=uranusRev*uranusRot*uranus;
    nux=reshape(nuranus(1,:),size(X));
    nuy=reshape(nuranus(2,:),size(X));
    nuz=reshape(nuranus(3,:),size(X));

    orbit_gal=update_orbit(orbit_gal,galRev(1:3,end)');
    orbit_sun=update_orbit(orbit_sun,sunRev(1:3,end)');
    orbit_earth=update_orbit(orbit_earth,earthRev(1:3,end)');
    orbit_mercury=update_orbit(orbit_mercury,mercuryRev(1:3,end)');
    orbit_venus=update_orbit(orbit_venus,venusRev(1:3,end)');
    orbit_mars=update_orbit(orbit_mars,marsRev(1:3,end)');
    orbit_jupiter=update_orbit(orbit_jupiter,jupiterRev(1:3,end)');
    orbit_saturn=update_orbit(orbit_saturn,saturnRev(1:3,end)');
    orbit_uranus=update_orbit(orbit_uranus,uranusRev(1:3,end)');

    set(sunfig,'XData',nsx,'YData',nsy,'ZData',nsz);
    set(earthfig,'XData',nex,'YData',ney,'ZData',nez);
    set(mercuryfig,'XData',nmx,'YData',nmy,'ZData',nmz);
    set(venusfig,'XData',nvx,'YData',nvy,'ZData',nvz);
    set(marsfig,'XData',nmrx,'YData',nmry,'ZData',nmrz);
    set(jupiterfig,'XData',njx,'YData',njy,'ZData',njz);
    set(saturnfig,'XData',nstx,'YData',nsty,'ZData',nstz);
    set(uranusfig,'XData',nux,'YData',nuy,'ZData',nuz);

    % draw_orbit(orbitfig_gal, orbit_gal, linecolor_gal)
    draw_orbit(orbitfig_sun, orbit_sun, linecolor_sun)
    draw_orbit(orbitfig_earth, orbit_earth, linecolor_earth)
    draw_orbit(orbitfig_mercury, orbit_mercury, linecolor_mercury)
    draw_orbit(orbitfig_venus, orbit_venus, linecolor_venus)
    draw_orbit(orbitfig_mars, orbit_mars, linecolor_mars)
    draw_orbit(orbitfig_jupiter, orbit_jupiter, linecolor_jupiter)
    draw_orbit(orbitfig_saturn, orbit_saturn, linecolor_saturn)
    draw_orbit(orbitfig_uranus, orbit_uranus, linecolor_uranus)

    view(20, 30);
    grid on;
    xlabel('x');
    ylabel('y');
    zlabel('z');
    axis equal;
    % axis([-axis_x axis_x -axis_y axis_y -axis_z axis_z]);
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

% use patch instead of an array of line objects
% the 'Faces' works as a set of lines, and is a matrix of raw datas
% => can operate parallel processing on it using SIMD
% however, an array of line objects does not contain raw datas
% => cannot operate parallel processing ...
function orbitfig=create_orbitfig(orbit_size, linc)
    orbitfig=patch('Vertices', zeros(orbit_size, 3), ...
                   'Faces', [(1:orbit_size-1)',(2:orbit_size)'], ...
                   'FaceVertexCData', linc, ...
                   'EdgeColor', 'interp', ... 
                   'FaceColor', 'none', ...
                   'LineWidth', 1);
end

function draw_orbit(orbitfig, orbit, linc)
    mask=orbit==0;
    active_orbit=orbit(~all(mask,2),:);
    sz=size(active_orbit);

    if sz(1) > 1
        active_colors=linc(~all(mask,2),:);
        set(orbitfig, 'Vertices', active_orbit, ...
                      'Faces', [(1:sz(1)-1)',(2:sz(1))'], ...
                      'FaceVertexCData', active_colors);
    end
end

% 1 cycle마다 버벅거림이 심하다.
