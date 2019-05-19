suma(X,Y,Z) :- Z is X+Y.

menor(A,B,Comp,M) :-
	M is A, A=<B;
	M is B, B=<A.

menor_o_igual(X,Y) :-
	var(X) = Y;
	var(Y) = X;
	(nonvar(X), nonvar(Y),
	 (X @< Y;X = Y, ))

