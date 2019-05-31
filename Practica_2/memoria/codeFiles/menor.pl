menor(A, B, Comp, M) :-
	functor(X, Comp, 2),
	arg(1,X,A),
	arg(2,X,B),
	call(X)->
	M = A;
	M = B.
