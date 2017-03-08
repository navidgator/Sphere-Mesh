quiver2 = @(P,V,varargin) quiver( P(1,:), P(2,:), V(1,:), V(2,:), varargin{:} );
plot2 = @(P,varargin) plot(P(1,:), P(2,:), varargin{:} );

 A = imread ('fire.png'); 
%A = imread ('head.jpg'); 
% A = imread ('Lion.png');
% A = imread('girl2.jpg'); 
S = sum(A,3);
mex  CXXFLAGS='$CXXFLAGS -std=c++11' dtform.cpp;
[DIST, CORRS] = dtform(S);
imagesc(S);


figure , imagesc(DIST) ;   hold on;
% colormap(gray(256));
boundary = contour(DIST,[1 1], 'color','white');
boundary(:,1) = [];
 N = Normals(boundary);




figure , plot2(boundary,'-r') , hold on;
quiver2(boundary,N);
