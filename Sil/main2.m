clc, clear, close all;

quiver2 = @(P,V,varargin) quiver( P(1,:), P(2,:), V(1,:), V(2,:), varargin{:} );
plot2 = @(P,varargin) plot(P(1,:), P(2,:), varargin{:} );



I = imread('fire.png');
% I = imread ('head.jpg'); 
% I = imread('girl2.jpg');

I = I(:,:,1) / 255; % Coverting image pixels to black and white
imagesc(I);
figure;

S = double(I);      % Using for any function that needs "double image"    
I = flipud(I);      % Fliping the image
% I = round(I);     % rounding image pixels to black and white
S2 = abs(S-1);      % fliping the image color (black->white  , white -> black)
mex  CXXFLAGS='$CXXFLAGS -std=c++11' dtform.cpp;

[DIST, CORRS] = dtform(S);  % dtform for the Original image 
imagesc(DIST);


figure;
[DIST2, CORRS2] = dtform(S2); % dtform for the color-fliped image 
imagesc(DIST2);

figure; 
[P,~] = contour(I, [0.5,0.5]);  % boundry of the image

%%--- Compute normals%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
n_shift = 10;
E = circshift(P,-n_shift,2)-P;
N = [0 -1;1 0]*E; % rotate edge by 90 degree
for i=1:size(N,2), N(:,i) = N(:,i)./norm(N(:,i)); end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


r_ind = round (1 + size(P,2) * rand); %computing a RANDOM INDEX

% p_index = r_ind; 
p_index = 100;          % THE INDEX OF THE FIRST POINT
p = P(:,p_index);       % FIRST POINT
hold on;
plot(p(1,1),p(2,1),'.r','MarkerSize',20)


% pt_index =  round (1 + size(P,2) * rand);
pt_index =  4567;       % INDEX OF THE SECOND POINT
p_t = P(:,pt_index);    % SECOND POINT
plot(p_t(1,1),p_t(2,1),'.r','MarkerSize',20)

rho_i = RADIUS(N(:,p_index),p,p_t);     %RADIUS OF A TANGENT BALL TO BOTH POINTS

%  I = flipud(I);      % Fliping the image

c_i = round(abs(p - (rho_i*N(:,p_index))));     %CENTER OF THE TANGENT BALL
  plot(c_i(1,1),c_i(2,1),'.g','MarkerSize',20)
if (I(c_i(1,1),c_i(2,1)) == 1)          % IF THE CENTER LIES OUTSIDE OF THE IMAGE

    [JJ,II] = ind2sub(size(S),CORRS(c_i(2,1),c_i(1,1))); 
    p_t = [II;JJ] ;
    rho_i1 = RADIUS(N(:,p_index),p,p_t);
    plot(II,JJ,'.b','MarkerSize',20)
  
else                            % IF THE CENTER LIES INSIDE THE IMAGE
    [JJ,II] = ind2sub(size(S2),CORRS2(c_i(2,1),c_i(1,1))); 
    p_t = [II;JJ] ;
    rho_i1 = RADIUS(N(:,p_index),p,p_t);
    plot(II,JJ,'.b','MarkerSize',20)
end
 hold on;
 th = 0:pi/50:2*pi;
xunit = rho_i * cos(th) + c_i(1,1);
yunit = rho_i * sin(th) + c_i(2,1);
h = plot(xunit, yunit);
return ;
rho_i1 = RADIUS(N(:,p_index),p,p_t);
th = 0:pi/50:2*pi;
xunit = rho_i * cos(th) + c_i(1,1);
yunit = rho_i * sin(th) + c_i(2,1);
hold on;
h = plot(xunit, yunit);

% return;
hold on;
while ((rho_i ~= rho_i1))
    rho_i = rho_i1;
    c_i = round ( abs( p - (rho_i*N(:,p_index))));
    [II,JJ] = ind2sub(size(S),CORRS(c_i(1,1),c_i(2,1))); 
    p_t = [JJ;II] ;
    rho_i1 = RADIUS(N(:,p_index),p,p_t);
    
    plot(II,JJ,'.r','MarkerSize',20)
   
    th = 0:pi/50:2*pi;
    xunit = rho_i * cos(th) + c_i(1,1);
    yunit = rho_i * sin(th) + c_i(2,1);
    h = plot(xunit, yunit);

end



% figure(); 
% hold on;
% imagesc(I), axis image;
% quiver2(P,N);
% 
% th = 0:pi/50:2*pi;
% xunit = rho_i * cos(th) + c_i(1,1);
% yunit = rho_i * sin(th) + c_i(2,1);
% h = plot(xunit, yunit);

return;



