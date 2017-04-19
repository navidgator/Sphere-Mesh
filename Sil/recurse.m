function  recurse (Img ,DIST,CORRS,CORRS2,S,RS,RD,epsilon)

[p,N] = New_Point(DIST,CORRS,S,RS,RD,epsilon);
[C,R,PI] = Circle (Img, p , N , CORRS, CORRS2, epsilon);

if (R < 2)
    return;
end    
    RD = PI-p;
    RD = Rotate90(RD');
    RD = RD/norm(RD);
    RS = (PI+p)/2;
    
    th = 0:pi/100:2*pi;
    xunit = R * cos(th) + C(2);
    yunit = R* sin(th) + C(1);
    h = plot(xunit, yunit);
    pause(0.5);
    recurse (Img ,DIST,CORRS,CORRS2,S,RS,RD,epsilon);
    recurse (Img ,DIST,CORRS,CORRS2,S,RS,-RD,epsilon);


end