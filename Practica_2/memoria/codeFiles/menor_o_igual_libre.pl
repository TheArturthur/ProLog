menor_o_igual_libre(X, Y) :-
	var(X), X = Y;
	var(Y), Y = X.