menor_o_igual_argumento(X, Y, Term1, Term2, Aridad1, Aridad2) :-
	Term1 @= Term2,
	Aridad1 == Aridad2,
	X =.. [Term1|ListaX],
	Y =.. [Term2|ListaY],
	menor_igual_argumento_rec(ListaX, ListaY).
