A=[-1 1 2; 3 -1 1; -1 3 4]
inv(A)
% rref(reduced row-echelon form): Gauss-Jordan Elimination 적용한 마지막 단계 보여준다.
rref(A)

B=[-1 1 2 1 0 0; 3 -1 1 0 1 0; -1 3 4 0 0 1]
rref(B)