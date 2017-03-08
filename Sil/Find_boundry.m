function F = Find_boundry(S)
 [m,n] = size(S);
 F= zeros(m,n);
 F(:,:) =255;
 for i=1:m
    for j=1:n
        flag = 0;
       if (S(i,j)==0)
           if (i==1 || j==1 || i==m || j==n)
               flag =1;
           end
            for t1 = i-1:i+1
               for t2 = j-1:j+1
                  if (t1 < m+1 && t1>0 && t2 < n+1 && t2>0 && S(t1,t2)>0)
                      flag = 1; 
                  end
               end
            end
           
       end
       
       if (flag ==1)
          F(i,j) = 0 ;  
       end
    end
 end
end