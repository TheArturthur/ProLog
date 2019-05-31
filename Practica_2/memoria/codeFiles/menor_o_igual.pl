menor_o_igual(X, Y) :-
	menor_o_igual_libre(X, Y);
	(nonvar(X), nonvar(Y), functor(X, Term1, Aridad1), functor(Y, Term2, Aridad2),
	 (menor_nombre(Term1, Term2);
	     menor_aridad(Term1,Term2,Aridad1,Aridad2);
	     menor_o_igual_argumento(X, Y, Term1, Term2, Aridad1, Aridad2))).

menor_o_igual_libre(X, Y) :-
	var(X) = Y;
	var(Y) = X.

menor_nombre(Term1, Term2) :-
	Term1 @< Term2.

menor_aridad(Term1, Term2, Aridad1, Aridad2) :-
	Term1 == Term2,
	Aridad1 < Aridad2.

menor_o_igual_argumento(X, Y, Term1, Term2, Aridad1, Aridad2) :-
	Term1 == Term2,
	Aridad1 == Aridad2,
	X =.. [Term1|ListaX],
	Y =.. [Term2|ListaY],
	menor_igual_argumento_rec(ListaX, ListaY).

menor_igual_argumento_rec([], []).

menor_igual_argumento_rec([Arg1|T1], [Brg1|T2]) :-
	(number(Arg1), number(Brg1), Arg1 =< Brg1 ;
	    Arg1 @=< Brg1),
	menor_igual_argumento_rec(T1, T2).
