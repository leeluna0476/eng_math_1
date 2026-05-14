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
orbit_gal=nan(orbit_size,3);
linecolor_gal=[linspace(1,1,orbit_size); linspace(1,0,orbit_size); linspace(1,0,orbit_size)]';
gal_sway_scale=50;

% sun
radius_sun=100;
sun=radius_sun*[Xc; Yc; Zc; zeros(size(Xc))];
sun(end,:)=sun(end,:)+1;
rev_sun=rev_gal*5;
rev_sun_radius=rev_gal_radius/2;
rot_sun=rev_sun*20;
orbit_sun=nan(orbit_size,3);
linecolor_sun=[linspace(1,0,orbit_size); linspace(1,0,orbit_size); linspace(1,0,orbit_size)]';

% earth
radius_earth=radius_sun/3.5;
earth=radius_earth*[Xc; Yc; Zc; zeros(size(Xc))];
earth(end,:)=earth(end,:)+1;
rev_earth=rev_sun*16;
rev_earth_radius=radius_sun+1000;
rot_earth=rev_earth*365;
orbit_earth=nan(orbit_size,3);
linecolor_earth=[linspace(1,0,orbit_size); linspace(1,1,orbit_size); linspace(1,0,orbit_size)]';

% mercury
radius_mercury=radius_earth/2;
mercury=radius_mercury*[Xc; Yc; Zc; zeros(size(Xc))];
mercury(end,:)=mercury(end,:)+1;
rev_mercury=rev_earth*4.15;
rev_mercury_radius=rev_earth_radius*0.4;
rot_mercury=rev_mercury*3;
orbit_mercury=nan(orbit_size,3);
linecolor_mercury=[linspace(1,1,orbit_size); linspace(1,1,orbit_size); linspace(1,0,orbit_size)]';

% venus
radius_venus=radius_earth/1.5;
venus=radius_venus*[Xc; Yc; Zc; zeros(size(Xc))];
venus(end,:)=venus(end,:)+1;
rev_venus=rev_earth*1.62;
rev_venus_radius=rev_earth_radius*0.723;
rot_venus=rev_venus*0.92;
orbit_venus=nan(orbit_size,3);
linecolor_venus=[linspace(1,1,orbit_size); linspace(1,0,orbit_size); linspace(1,0,orbit_size)]';

% mars
radius_mars=radius_earth/1.2;
mars=radius_mars*[Xc; Yc; Zc; zeros(size(Xc))];
mars(end,:)=mars(end,:)+1;
rev_mars=rev_earth*0.54;
rev_mars_radius=rev_earth_radius*1.524;
rot_mars=rev_mars*667;
orbit_mars=nan(orbit_size,3);
linecolor_mars=[linspace(1,0,orbit_size); linspace(1,1,orbit_size); linspace(1,1,orbit_size)]';

% jupiter
radius_jupiter=radius_earth*2;
jupiter=radius_jupiter*[Xc; Yc; Zc; zeros(size(Xc))];
jupiter(end,:)=jupiter(end,:)+1;
rev_jupiter=rev_earth*0.45;
rev_jupiter_radius=rev_earth_radius*3;
rot_jupiter=rev_jupiter*1000;
orbit_jupiter=nan(orbit_size,3);
linecolor_jupiter=[linspace(1,1,orbit_size); linspace(1,0,orbit_size); linspace(1,1,orbit_size)]';

% saturn
radius_saturn=radius_earth*1.7;
saturn=radius_saturn*[Xc; Yc; Zc; zeros(size(Xc))];
saturn(end,:)=saturn(end,:)+1;
rev_saturn=rev_earth*0.33;
rev_saturn_radius=rev_earth_radius*3.5;
rot_saturn=rev_saturn*2410;
orbit_saturn=nan(orbit_size,3);
linecolor_saturn=[linspace(1,0,orbit_size); linspace(1,0,orbit_size); linspace(1,1,orbit_size)]';

% uranus
radius_uranus=radius_earth*1.3;
uranus=radius_uranus*[Xc; Yc; Zc; zeros(size(Xc))];
uranus(end,:)=uranus(end,:)+1;
rev_uranus=rev_earth*0.22;
rev_uranus_radius=rev_earth_radius*4.5;
rot_uranus=rev_uranus*4280;
orbit_uranus=nan(orbit_size,3);
linecolor_uranus=[linspace(1,0.1,orbit_size); linspace(1,0.8,orbit_size); linspace(1,0.5,orbit_size)]';

% neptune
radius_neptune=radius_earth*1.2;
neptune=radius_neptune*[Xc; Yc; Zc; zeros(size(Xc))];
neptune(end,:)=neptune(end,:)+1;
rev_neptune=rev_earth*0.15;
rev_neptune_radius=rev_earth_radius*5.5;
rot_neptune=rev_neptune*8970;
orbit_neptune=nan(orbit_size,3);
linecolor_neptune=[linspace(1,0.1,orbit_size); linspace(1,0.5,orbit_size); linspace(1,0.8,orbit_size)]';

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
neptunefig=surf(X,Y,Z);

orbitfig_gal=create_orbitfig(orbit_size, linecolor_gal);
orbitfig_sun=create_orbitfig(orbit_size, linecolor_sun);
orbitfig_earth=create_orbitfig(orbit_size, linecolor_earth);
orbitfig_mercury=create_orbitfig(orbit_size, linecolor_mercury);
orbitfig_venus=create_orbitfig(orbit_size, linecolor_venus);
orbitfig_mars=create_orbitfig(orbit_size, linecolor_mars);
orbitfig_jupiter=create_orbitfig(orbit_size, linecolor_jupiter);
orbitfig_saturn=create_orbitfig(orbit_size, linecolor_saturn);
orbitfig_uranus=create_orbitfig(orbit_size, linecolor_uranus);
orbitfig_neptune=create_orbitfig(orbit_size, linecolor_neptune);

for i=0:0.005:5
    [gv,gu,gw]=cal_revolution(rev_gal,rev_gal_radius,i,20,gal_sway_scale);
    [su,sv,sw]=cal_revolution(rev_sun,rev_sun_radius,i,20,0);
    [eu,ev,ew]=cal_revolution(rev_earth,rev_earth_radius,i,20,0);
    [mu,mv,mw]=cal_revolution(rev_mercury,rev_mercury_radius,i,20,0);
    [vu,vv,vw]=cal_revolution(rev_venus,rev_venus_radius,i,20,0);
    [mru,mrv,mrw]=cal_revolution(rev_mars,rev_mars_radius,i,20,0);
    [ju,jv,jw]=cal_revolution(rev_jupiter,rev_jupiter_radius,i,20,0);
    [stu,stv,stw]=cal_revolution(rev_saturn,rev_saturn_radius,i,20,0);
    [uu,uv,uw]=cal_revolution(rev_uranus,rev_uranus_radius,i,20,0);
    [nu,nv,nw]=cal_revolution(rev_neptune,rev_neptune_radius,i,20,0);

    galRev=[1 0 0 gu; 0 1 0 gv; 0 0 1 gw; 0 0 0 1];

    rot_sun_phi=rot_sun*2*pi*i/20;
    [sunRev,sunRot]=cal_trans_matrices(rot_sun_phi,su,sv,sw,'y',galRev);
    
    rot_earth_phi=rot_earth*2*pi*i/20;
    [earthRev,earthRot]=cal_trans_matrices(rot_earth_phi,ev,eu,ew,'x',sunRev);

    rot_mercury_phi=rot_mercury*2*pi*i/20;
    [mercuryRev,mercuryRot]=cal_trans_matrices(rot_mercury_phi,mv,mu,mw,'x',sunRev);

    rot_venus_phi=rot_venus*2*pi*i/20;
    [venusRev,venusRot]=cal_trans_matrices(rot_venus_phi,vv,vu,vw,'x',sunRev);

    rot_mars_phi=rot_mars*2*pi*i/20;
    [marsRev,marsRot]=cal_trans_matrices(rot_mars_phi,mrv,mru,mrw,'x',sunRev);

    rot_jupiter_phi=rot_jupiter*2*pi*i/20;
    [jupiterRev,jupiterRot]=cal_trans_matrices(rot_jupiter_phi,jv,ju,jw,'x',sunRev);

    rot_saturn_phi=rot_saturn*2*pi*i/20;
    [saturnRev,saturnRot]=cal_trans_matrices(rot_saturn_phi,stv,stu,stw,'x',sunRev);

    rot_uranus_phi=rot_uranus*2*pi*i/20;
    [uranusRev,uranusRot]=cal_trans_matrices(rot_uranus_phi,uv,uu,uw,'x',sunRev);

    rot_neptune_phi=rot_neptune*2*pi*i/20;
    [neptuneRev,neptuneRot]=cal_trans_matrices(rot_neptune_phi,nv,nu,nw,'x',sunRev);

    [nsx,nsy,nsz]=transformed_data(sunRev,sunRot,sun,size(X));
    [nex,ney,nez]=transformed_data(earthRev,earthRot,earth,size(X));
    [nmx,nmy,nmz]=transformed_data(mercuryRev,mercuryRot,mercury,size(X));
    [nvx,nvy,nvz]=transformed_data(venusRev,venusRot,venus,size(X));
    [nmrx,nmry,nmrz]=transformed_data(marsRev,marsRot,mars,size(X));
    [njx,njy,njz]=transformed_data(jupiterRev,jupiterRot,jupiter,size(X));
    [nstx,nsty,nstz]=transformed_data(saturnRev,saturnRot,saturn,size(X));
    [nux,nuy,nuz]=transformed_data(uranusRev,uranusRot,uranus,size(X));
    [nnx,nny,nnz]=transformed_data(neptuneRev,neptuneRot,neptune,size(X));

    orbit_gal=update_orbit(orbit_gal,galRev(1:3,end)');
    orbit_sun=update_orbit(orbit_sun,sunRev(1:3,end)');
    orbit_earth=update_orbit(orbit_earth,earthRev(1:3,end)');
    orbit_mercury=update_orbit(orbit_mercury,mercuryRev(1:3,end)');
    orbit_venus=update_orbit(orbit_venus,venusRev(1:3,end)');
    orbit_mars=update_orbit(orbit_mars,marsRev(1:3,end)');
    orbit_jupiter=update_orbit(orbit_jupiter,jupiterRev(1:3,end)');
    orbit_saturn=update_orbit(orbit_saturn,saturnRev(1:3,end)');
    orbit_uranus=update_orbit(orbit_uranus,uranusRev(1:3,end)');
    orbit_neptune=update_orbit(orbit_neptune,neptuneRev(1:3,end)');

    set(sunfig,'XData',nsx,'YData',nsy,'ZData',nsz);
    set(earthfig,'XData',nex,'YData',ney,'ZData',nez);
    set(mercuryfig,'XData',nmx,'YData',nmy,'ZData',nmz);
    set(venusfig,'XData',nvx,'YData',nvy,'ZData',nvz);
    set(marsfig,'XData',nmrx,'YData',nmry,'ZData',nmrz);
    set(jupiterfig,'XData',njx,'YData',njy,'ZData',njz);
    set(saturnfig,'XData',nstx,'YData',nsty,'ZData',nstz);
    set(uranusfig,'XData',nux,'YData',nuy,'ZData',nuz);
    set(neptunefig,'XData',nnx,'YData',nny,'ZData',nnz);

    % draw_orbit(orbitfig_gal, orbit_gal)
    draw_orbit(orbitfig_sun, orbit_sun)
    draw_orbit(orbitfig_earth, orbit_earth)
    draw_orbit(orbitfig_mercury, orbit_mercury)
    draw_orbit(orbitfig_venus, orbit_venus)
    draw_orbit(orbitfig_mars, orbit_mars)
    draw_orbit(orbitfig_jupiter, orbit_jupiter)
    draw_orbit(orbitfig_saturn, orbit_saturn)
    draw_orbit(orbitfig_uranus, orbit_uranus)
    draw_orbit(orbitfig_neptune, orbit_neptune)

    view(20, 30);
    grid on;
    xlabel('x');
    ylabel('y');
    zlabel('z');
    axis equal;
    % axis([-axis_x axis_x -axis_y axis_y -axis_z axis_z]);
    pause(0.001);
end

function [u,v,w]=cal_revolution(rev_no,rev_radius,sway_base,sway_base_max,sway_scale)
    phi=rev_no*2*pi*sway_base/sway_base_max;
    u=rev_radius*cos(phi);
    v=sway_scale*sway_base;
    w=rev_radius*sin(phi);
end

% CW rotation
function [Rev,Rot]=cal_trans_matrices(rot_phi,u,v,w,axis,centerRev)
    Rev=centerRev*[1 0 0 u; 0 1 0 v; 0 0 1 w; 0 0 0 1];
    if strcmp(axis,'x')
        Rot=[1 0 0 0; 0 cos(rot_phi) -sin(rot_phi) 0; 0 sin(rot_phi) cos(rot_phi) 0; 0 0 0 1];
    elseif strcmp(axis,'y')
        Rot=[cos(rot_phi) 0 sin(rot_phi) 0; 0 1 0 0; -sin(rot_phi) 0 cos(rot_phi) 0; 0 0 0 1];
    else
        Rot=[cos(rot_phi) -sin(rot_phi) 0 0; sin(rot_phi) cos(rot_phi) 0 0; 0 0 1 0; 0 0 0 1];
    end
end

function [nx,ny,nz]=transformed_data(Rev,Rot,orig,shape)
    newd=Rev*Rot*orig;
    nx=reshape(newd(1,:),shape);
    ny=reshape(newd(2,:),shape);
    nz=reshape(newd(3,:),shape);
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
    vertices=nan(orbit_size+1,3);
    orbitfig=patch('Vertices', vertices, ...
                   'Faces', 1:orbit_size+1, ...
                   'FaceVertexCData', [linc; ones(1,3)], ...
                   'EdgeColor', 'flat', ... 
                   'FaceColor', 'none', ...
                   'LineWidth', 0.5);
end

function draw_orbit(orbitfig, orbit)
    vertices=[orbit;nan(1,3)];
    set(orbitfig, 'Vertices', vertices);
end
