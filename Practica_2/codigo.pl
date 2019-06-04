
alumno_prode('Vidal','Pena','Arturo','W140307').

%Parte 1:

menor(A, B, Comp, M) :-
	functor(X, Comp, 2),
	arg(1,X,A),
	arg(2,X,B),
	call(X)->
	M = A;
	M = B.


%Parte 2:

menor_o_igual(X, Y) :-
	menor_o_igual_libre(X, Y);
	(nonvar(X), nonvar(Y), functor(X, Term1, Aridad1), functor(Y, Term2, Aridad2),
	 (menor_nombre(Term1, Term2);
	     menor_aridad(Term1,Term2,Aridad1,Aridad2);
	     menor_o_igual_argumento(X, Y, Term1, Term2, Aridad1, Aridad2))).

menor_o_igual_libre(X, Y) :-
	var(X), X = Y;
	var(Y), Y = X.

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
	(number(Arg1), number(Brg1), Arg1 =< Brg1 ;
	    Arg1 @=< Brg1),
	menor_igual_argumento_rec(T1, T2).


%Parte 3:

lista_hojas([], []).

lista_hojas([H|T], [tree(H, void, void)|Hojas]) :-
	lista_hojas(T, Hojas).

hojas_arbol([Hoja|Hojas],Comp,Arbol) :-
	hojasArbolRec(Hojas,Comp,Hoja,Arbol).

hojasArbolRec([],_,Arbol,Arbol).

hojasArbolRec([H|T],Comp,Arbol,Tree) :-
	arg(1,H,RaizIzq),
	arg(1,Arbol,Raiz),
	menor(Raiz,RaizIzq,Comp,M),
	hojasArbolRec(T,Comp,tree(M,Arbol,H),Tree).

ordenacion(Arbol,Comp,Orden) :-
	ordenacion_aux(Arbol,Comp,[],Orden).

ordenacion_aux(tree(Element,void,void),_,Orden,OrdenF) :-
	append(Orden,[Element],OrdenF).

ordenacion_aux(tree(Element,Left,Right),Comp,Orden,OrdenF) :-
	append(Orden,[Element],OrdenS),
	makeList(tree(Element,Left,Right),[],Lista),
	borraElemento(Element,Lista,Salida),
	lista_hojas(Salida,Hojas),
	hojas_arbol(Hojas,Comp,Arbol),
	ordenacion_aux(Arbol,Comp,OrdenS,OrdenF).

makeList(tree(Element,void,void), Lista, [Element|Lista]).

makeList(tree(_,Left,Right), Lista, ListaSalida) :-
	Right = tree(ElementRight,_,_),
	append(Lista,[ElementRight],Lista2),
	makeList(Left,Lista2,ListaSalida).

borraElemento(_,[],[]).

borraElemento(Elemento,[Elemento|T],T).

borraElemento(Elemento,[H|T1],[H|T2]) :-
	borraElemento(Elemento,T1,T2).

ordenar(Lista,Comp,Orden) :-
	lista_hojas(Lista,Hojas),
	hojas_arbol(Hojas,Comp,Arbol),
	ordenacion(Arbol,Comp,Orden).