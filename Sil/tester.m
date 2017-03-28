p   =   1.0e+03 *[0.0250; 1.6575];
p_t =   1.0e+03 *[1.4560; 1.4865];
N   =   [-0.9487;0.3162]
% N = [-1;0];
% p = [0;0];
% % p_t = [1;1];
% p_t   = [2;0];
rho_i = RADIUS(N,p,p_t);     %RADIUS OF A TANGENT BALL TO BOTH POINTS
% rho_i = RADIUS(N(:,p_index),p,p_t);     %RADIUS OF A TANGENT BALL TO BOTH POINTS
c_i = round(abs(p - (rho_i*N)));     %CENTER OF THE TANGENT BALL
 
 
figure
hold all;
plot(p(1),p(2),'ro')
plot(p_t(1),p_t(2),'bo')
plot([p(1),p(1)+N(1)],[p(2),p(2)+N(2)],'g')
th = 0:pi/50:2*pi;
xunit = rho_i * cos(th) + c_i(1,1);
yunit = rho_i * sin(th) + c_i(2,1);
h = plot(xunit, yunit);