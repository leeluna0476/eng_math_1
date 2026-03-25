A=[[2 0 -4 6];[4 5 1 0];[0 2 6 -1];[-3 8 9 1]];

fprintf('det(A)=%.2f\n', det_gauss(A));

%B=[[1 2 3];[4 5 6]];
%fprintf('det(B)=%.2f\n', det_gauss(B));

function D=det_gauss(A)
    Asize=size(A);
    if Asize(1)~=Asize(2)
        error('The input is not a square matrix.');
    end

    n = Asize(1);
    for k=1:n
        for i=k+1:n
            m=A(i,k)/A(k,k);
            for j=k:n
                A(i,j)=A(i,j)-A(k,j)*m;
            end
        end
    end
    
    %D=1;
    %for k=1:n
    %    D = D * A(k, k);
    %end
    D=prod(diag(A)); % get the product of main diagonal elements
end