function [C,R,PI] =  Circle_pure (Img, p , N , CORRS, CORRS2, epsilon)

S = double(Img);      % Using for any function that needs "double image"
S2 =  1-S;      % fliping the image color (black->white  , white -> black)
% mex  CXXFLAGS='$CXXFLAGS -std=c++11' dtform.cpp;


% [DIST, CORRS] = dtform(S);  % dtform for the Original image
%  figure ; imagesc(DIST);
% [DIST2, CORRS2] = dtform(S2); % dtform for the color-fliped image
%   figure; imagesc(DIST2);
% figure; axis equal; hold all;
[P,~] = contour(Img, [0.5,0.5]);  % boundry of the image

IMAX = [size(Img,1) , size(Img,2)];
FS = farthest(p,-N,IMAX);
% plot(FS(2),FS(1),'*green','MarkerSize',10);


p_t = zeros(1,2);
FS(1) = round(FS(1));
FS(2) = round(FS(2));
[p_t(1),p_t(2)] = ind2sub(size(S2),CORRS2(FS(1),FS(2)));    %%Correct Form

%%%%%%%%%%%%%%%%%%%%%%%%%%

% plot(p_t(2),p_t(1),'.r','MarkerSize',20);
rho_i = RADIUS(N,p,p_t);     %RADIUS OF A TANGENT BALL TO BOTH POINTS
% rho_i = (sum((p-p_t).^2).^0.5)/2
c_i = round(abs(p - (rho_i*N)));     %CENTER OF THE TANGENT BALL
% c_i = round( abs( (p_t+p)/2))

%  plot(c_i(2),c_i(1),'.g','MarkerSize',20);



if (Img(c_i(1),c_i(2)) == 0)          % IF THE CENTER LIES INSIDE OF THE IMAGE
    [JJ,II] = ind2sub(size(S),CORRS(c_i(1),c_i(2)));
else                                    % IF THE CENTER LIES OUTSIDE THE IMAGE
    [JJ,II] = ind2sub(size(S2),CORRS2(c_i(1),c_i(2)));
end

JJ = JJ+1;
p_t = [JJ,II];
rho_i1 = RADIUS(N,p,p_t);
% plot(II,JJ,'.b','MarkerSize',20);
% plot(p_t(2),p_t(1),'.black','MarkerSize',20);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% hold all;
% th = 0:pi/50:2*pi;
% xunit = rho_i * cos(th) + c_i(2);
% yunit = rho_i * sin(th) + c_i(1);
% h = plot(xunit, yunit);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


while (rho_i - rho_i1 > epsilon)

    rho_i = rho_i1;
    c_i = round(abs(p - (rho_i*N)))

    %     plot(c_i(2),c_i(1),'.g','MarkerSize',20);
    if (Img(c_i(1),c_i(2)) == 0)          % IF THE CENTER LIES INSIDE OF THE IMAGE
        [JJ,II] = ind2sub(size(S),CORRS(c_i(1),c_i(2)));
    else                                    % IF THE CENTER LIES OUTSIDE THE IMAGE
        [JJ,II] = ind2sub(size(S2),CORRS2(c_i(1),c_i(2)));
    end
    JJ = JJ+1;
    p_t = [JJ,II];
    % if (abs(norm(p-c_i)-norm(p_t - c_i))<epsilon)
    %     break;
    rho_i1 = RADIUS(N,p,p_t);
    %  plot(II,JJ,'.b','MarkerSize',20);
    % plot(p_t(2),p_t(1),'.black','MarkerSize',20);
    % hold all;
    % th = 0:pi/50:2*pi;
    % xunit = rho_i * cos(th) + c_i(2);
    % yunit = rho_i * sin(th) + c_i(1);
    % h = plot(xunit, yunit);
end
C = c_i;
R = rho_i;
PI = p_t;


end
