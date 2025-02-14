clc, clear, close all;
[XX,YY] = meshgrid(-1.5:0.01:1.5,-1:0.01:1);
% imagesc(XX), axis equal;

% I = double( ((XX-.5).^2 + (YY).^2 - .2^2)<0 );

I0 = ((XX+.2).^2 + (YY-.3).^2 - .2^2) < 0;
I1 = ((XX-.3).^2 + (YY+.4).^2 - .2^2) < 0;
I = I0 + I1;
figure; imagesc(I);
% imagesc(I), axis equal;

mex CXXFLAGS='$CXXFLAGS -std=c++11' dtform.cpp; 
tic()
% [I2, CORRS] = dtform(I);
% [I2] = dtform(I);
% S = round(1-I);
S = 1.0-I;
figure; imagesc(S);
[I3] = dtform(S);
% [I3, CORRS2] = dtform(S);
toc();

return;

figure, imagesc(I2), axis equal;
hold on;
contour (I2, [0.5,0.5],'color', 'white');
% figure, imagesc(I22), axis equal;
% contour (I22, [0.5,0.5],'color', 'white');
[JJ,II] = ind2sub(size(I),CORRS(140,140));
JJ = JJ +1; 
hold on;
plot(II,JJ,'.r','MarkerSize',20)
plot(140,140,'.b','MarkerSize',20)
