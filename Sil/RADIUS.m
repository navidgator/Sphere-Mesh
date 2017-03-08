function len =  RADIUS (N,p,p_i)
% theta = acos((N' * (p - p_i))/ (sum(p-p_i).^2).^0.5);     
% len = abs( (sum((p-p_i).^2).^0.5)/ (2*cos(theta)));
len = (sum((p-p_i).^2).^0.5)/2;

end