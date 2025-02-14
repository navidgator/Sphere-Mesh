clc, clear, close all;
[XX,YY] = meshgrid(-1.5:0.01:1.5,-1:0.01:1);
% imagesc(XX), axis equal;

% I = double( ((XX-.5).^2 + (YY).^2 - .2^2)<0 );

I0 = ((XX+.2).^2 + (YY-.3).^2 - .2^2) < 0;
I1 = ((XX-.3).^2 + (YY+.4).^2 - .2^2) < 0;
I = I0 + I1;
S = 1- I;
% imagesc(I), axis equal;

mex CXXFLAGS='$CXXFLAGS -std=c++11' dtform.cpp; 
tic()
[I2, CORRS] = dtform(I);
toc();
figure; hold all; imagesc(I2), axis equal;
[S2, CORRS2] = dtform(S);

p = [50 50];
[pp1,pp2] = ind2sub(size(CORRS), CORRS(p(1), p(2)))
%scatter(p(1), p(2));
%scatter(pp1, pp2);
plot([p(1) pp1], [p(2) pp2]);