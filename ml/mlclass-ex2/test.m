function [theta, cost] = test()

	[theta, cost] = fminunc(@(t)(costFunction(t, X, y)), [0;0;0], options)

end