
%Parte 1:

=<(A, B, M) :-
	M is A, A =< B;
	M is B, B =< A.

>(A, B, M) :-
	M is A, A > B;
	M is B, B > A.

@=<(A, B, M) :-
	M is A, A @=< B;
	M is B, B @=< A.

@>(A, B, M) :-
	M = A, A @> B;
	M = B, B @> A.


menor(A, B, Comp, M) :-
	arg(3,menor(A, B, Comp,M ), C),
	(C = =<, =<(A, B, M);
	    C = >, >(A, B, M);
	    C = @=<, @=<(A, B, M);
	    C = @>, @>(A, B, M)).


%Parte 2:

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
%TODO: Mirar si arg1 y arg2 son numeros antes de la comprobación.
	(Arg1 @=< Brg1; Arg1 =< Brg1);
	menor_igual_argumento_rec([T1], [T2]).


%Parte 3:

lista_hojas([], []).

lista_hojas([H|T], [tree(H, void, void)|Hojas]) :-
	lista_hojas(T, Hojas).

hojas_arbol([],_,_).

hojas_arbol([H1,H2|T], Comp, Arbol) :-
	hojasArbolRec([H1,H2|T], Comp, Arbol, _).

hojasArbolRec([tree(A,void,void)], Comp, Arbol, tree(Element,Left,Right)) :-
	(A =< Element, C = tree(A, tree(A, void, void), tree(Element,Left,Right));
	    C = tree(Element, tree(A, void, void), tree(Element,Left,Right))),
	Arbol = C.

hojasArbolRec([tree(A,void,void),tree(B,void,void)|T],Comp,Arbol,Tree) :-
	(A =< B, C = A;
	    C = B),
	Tree = tree(C, tree(A,void,void), tree(B,void,void)),
	hojasArbolRec(T, Comp, Arbol, Tree).

%ordenacion(Arbol,Comp,Orden) :-
%	.


	
%ordenar(Lista,Comp,Orden) :-
%	.