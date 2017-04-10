clc, clear, close all;

quiver2 = @(P,V,varargin) quiver( P(1,:), P(2,:), V(1,:), V(2,:), varargin{:} );
plot2 = @(P,varargin) plot(P(1,:), P(2,:), varargin{:} );



% I = imread('fire.png');
I = imread('body1.jpg');
% I = imread('body2.jpeg');
% I = imread ('head.jpg'); 
% I = imread('girl2.jpg'); 
% size(I,1)
% size(I,2)

I = I(:,:,1) / 255; % Coverting image pixels to black and white
imagesc(I);

S = double(I);       % Using for any function that needs "double image"    
S2 =  1-S;      % fliping the image color (black->white  , white -> black)

mex  CXXFLAGS='$CXXFLAGS -std=c++11' dtform.cpp;


[DIST, CORRS] = dtform(S);  % dtform for the Original image 
 figure ; imagesc(DIST);
[DIST2, CORRS2] = dtform(S2); % dtform for the color-fliped image 
%  figure; imagesc(DIST2);
figure; axis equal; hold all; 
[P,~] = contour(I, [0.5,0.5]);  % boundry of the image

% for iter =1 :100

%%--- Compute normals%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
prand_x = round (1 +( size(I,2) * rand)); % COMPUTING A RANDOM INDEX
prand_y = round (1 + (size(I,1) * rand));
plot(prand_x,prand_y,'.b','MarkerSize',20);

prand = [prand_y , prand_x];

I(prand_y,prand_x)
if (I(prand_y,prand_x)== 0)         %Inside
    [JJ,II] = ind2sub(size(S),CORRS(prand_y,prand_x));
    N =  [JJ,II] - prand ;
    
else
     [JJ,II] = ind2sub(size(S2),CORRS2(prand_y,prand_x));
    N = prand - [JJ,II] ; 
end
N = N/norm(N);
quiver(II,JJ,N(2),N(1),50);


p = [JJ,II];
hold on;
plot(p(2),p(1),'.r','MarkerSize',20);

[center,rho,PI] = Circle (I, p , N ,CORRS, CORRS2, 4);
% 
% figure; hold all; axis equal;
contour(I, [0.5,0.5]);
plot(center(2),center(1),'.g','MarkerSize',20);
plot(PI(2),PI(1),'.black','MarkerSize',20);
th = 0:pi/100:2*pi;
xunit = rho * cos(th) + center(2);
yunit = rho * sin(th) + center(1);
h = plot(xunit, yunit);
plot ([p(2),PI(2)],[p(1),PI(1)]);
RD = PI-p;
RD = Rotate90(RD');
RD = RD/norm(RD);
RS = (PI+p)/2;
% plot(RS(2),RS(1),'.white','MarkerSize',20);
quiver(RS(2),RS(1),RD(2),RD(1),100);
% quiver(RS(2),RS(1),-RD(2),-RD(1),200);

RD_R = -RD;
[New,N_New] = New_Point(DIST,CORRS,S,RS,RD); 

plot(New(2),New(1),'.yellow','MarkerSize',20);
quiver(New(2),New(1),N_New(2),N_New(1),50);

[center,rho,PI] = Circle (I, New , N_New ,CORRS, CORRS2, 4);
plot(center(2),center(1),'.g','MarkerSize',20);
plot(PI(2),PI(1),'.black','MarkerSize',20);
th = 0:pi/100:2*pi;
xunit = rho * cos(th) + center(2);
yunit = rho * sin(th) + center(1);
h = plot(xunit, yunit);
return;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




