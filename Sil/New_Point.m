function [p,N] = New_Point(DIST,CORRS,S,RS,RD)


PX = RS;
while(1)
    rounded = round(PX)
    distance = DIST(rounded(1),rounded(2))
    if ( distance <  5)
        [JJ,II] = ind2sub(size(S),CORRS(rounded(1),rounded(2)));
        p = [JJ,II];
        N =  [JJ,II] - PX ;
        N = N/norm(N);
        return;
    end
    
     PX = PX + RD' * distance; 
    
    
end

end