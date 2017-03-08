function N = normal(P,p)
 n_shift = 10;
 E = circshift(P,-n_shift,2)-P;
 N = [0 -1;1 0]*E; % rotate edge by 90 degree
 for i=1:size(N,2), N(:,i) = N(:,i)./norm(N(:,i)); end

end