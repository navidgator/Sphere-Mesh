function r =  RADIUS (N,p,p_i)
p12 = p_i - p;
len = norm(p12);
cost = dot(p12/ len , -N);
r = abs (len / (cost * 2));

end