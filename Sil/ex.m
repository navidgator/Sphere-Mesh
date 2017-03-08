clc, clear, close all;

%--- convenience functions (silly matlab)
% HP: 2xN matrices, one point per column
quiver2 = @(P,V,varargin) quiver( P(1,:), P(2,:), V(1,:), V(2,:), varargin{:} );
plot2 = @(P,varargin) plot(P(1,:), P(2,:), varargin{:} );
kdtree = @(P) KDTreeSearcher(P');

c= [100 100]
r = 50

[X,Y] = meshgrid(1:200, 1:200);
[XX,YY] = meshgrid(1:200, 1:200);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%CIRCLE%%%%%%%%%%%%%%%%%%%%%%%%%

load dragon.mat P N;
figure; hold on;

plot2(P,'.r');
quiver2(P,N);

c=[100;100];
r=50;

t=linspace(0,2*pi,100);
x=c(1)+r*cos(t);
y=c(2)+r*sin(t);
figure;
plot(x,y,'-r');

[X,Y]=meshgrid(1:200,1:200);


phi=zeros(200,200);
for x=1:200
    for y=1:200
        p=[x;y];
        phi(x,y)=norm(p-c) - r;
    end
end

figure; hold on;
imagesc(phi);
contour(X,Y,phi, 'color','white');

figure; hold on;
row=phi(100,:);
plot(row);
axis equal;

figure;
surfc(phi, 'Edgecolor','none');



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%DRAGON%%%%%%%%%%%%%%%%%%%%%%%%%%%%
load dragon.mat P N;
figure; hold on;
plot2(P,'.r');
quiver2(P,N);


 phi = zeros(200, 200);
 tree = kdtree(P);

  for x=1:200
    for y = 1:200
        i = tree.knnsearch([x,y]);

        p = P(:,i);
        n = N(:,i);
        point=[x;y];
        phi(y,x) = n'*(point-p);
    end
  end
figure; hold on;
imagesc(phi);
contour(X,Y,phi,[0,0], 'color','white');
% plot2 = @(P,varargin) plot(P(1,:), P(2,:), varargin{:} );
% quiver2 = @(P,V,varargin) quiver( P(1,:), P(2,:), V(1,:), V(2,:), varargin{:} );
% load dragon.mat P N;
% figure; hold on;
% plot2(P,'.r');
% quiver2(P,N);


