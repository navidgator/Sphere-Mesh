function tree = kdtree2(P)
% P is a Nx2 matrix of 2D points
% build with:
%    tree = kdtree2(P);
% query with:
%    index = tree.knnsearch(Q);
%    index = tree.knnsearch(Q,'k',5);
% 
% assert( size(P,2)==2 );
tree = KDTreeSearcher(P);