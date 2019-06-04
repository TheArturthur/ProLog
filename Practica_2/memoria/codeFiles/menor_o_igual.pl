menor_o_igual(X, Y) :-
	menor_o_igual_libre(X, Y);
	(nonvar(X), nonvar(Y), functor(X, Term1, Aridad1), functor(Y, Term2, Aridad2),
	 (menor_nombre(Term1, Term2);
	     menor_aridad(Term1,Term2,Aridad1,Aridad2);
	     menor_o_igual_argumento(X, Y, Term1, Term2, Aridad1, Aridad2))).
