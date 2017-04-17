function [p,N] = New_Point(DIST,CORRS,S,RS,RD,epsilon)


PX = RS;
distance = 0;
while(1)
    PX = PX + RD' * distance;
    rounded = round(PX)
    distance = DIST(rounded(1),rounded(2))
    if ( distance <  epsilon)
        [JJ,II] = ind2sub(size(S),CORRS(rounded(1),rounded(2)));
        p = [JJ,II];
        N =  [JJ,II] - PX ;
        N = N/norm(N);
        return;
    end
    
%      PX = PX + RD' * distance; 
    
    
end

end