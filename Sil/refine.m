function r = refine(S)
[m,n] = size(S);
r = S;
for i= 1 : m
    for j= 1 : n
        if (r(i,j)>0 && r(i,j)<255)
            r(i,j)= 0;
    end

end

end