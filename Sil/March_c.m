function [p,N] =  March_c (DIST,CORRS,S,RS,RD,epsilon)

PX = RS;
max_i = PX;
max_d = 0;
while(1)
    rounded = round(PX);
    distance = DIST(rounded(1),rounded(2));
    if (distance > max_d)
        max_d = distance;
        max_i = rounded;
    end
    
    if ( distance <  epsilon)
        [JJ,II] = ind2sub(size(S),CORRS(max_i(1),max_i(2)));
        p = [JJ,II];
        N =  [JJ,II] - max_i ;
        N = N/norm(N);
        return;
    end
    
    
     PX = PX + RD' * distance; 
    
    
end
end