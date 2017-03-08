function NN = Normals(P)

S = size(P,2);  
NN = zeros (2,S);
tree = kdtree2(P');
k = 10;

  in = tree.knnsearch( P' , 'K',k );
for i=1:S
    
    Cov = zeros(2,2);
    centroid = zeros(2,1);
    for j=1:k
        centroid = P(:,in(i,j)) + centroid; 
    end
    centroid = centroid/k; 

    for j=1:k
        Cov = Cov + ((P(:,in(i,j)) - centroid)*(P(:,in(i,j))-centroid)'); 
    end
    
    [V,D] = eigs(Cov,2);  
    NN(:,i) = V(2,:);
%    [V,D] = eig(Cov);
%    
%    if ~issorted(diag(D))
%     [V,D] = eig(Cov);
%     [D,I] = sort(diag(D));
%     V = V(:, I);
%    end
    
end
