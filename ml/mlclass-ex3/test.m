function [] = test()

X = [0.9; 1.0; 1.1; 2.9; 3.0; 3.1];
y = [2; 2; 2; 1; 1; 1];
all_theta = oneVsAll(X,y,2,2)

%all_theta = 
%  -1.75575  0.87787
%  1.75575  -0.87787

end