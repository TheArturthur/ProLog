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