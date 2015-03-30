function sonuc=cramer(A,b)
    
    x=det(A);
    boyut=size(A);
    for i=1:boyut(1,1)
        tempA=A;
        for j=1:boyut(1,1)
            tempA(j,i)=b(j);
        end
        sonuc(i)=det(tempA)/x;
    end

end
