ordenacion_aux(tree(Element,void,void),_,Orden,OrdenF) :-
	append(Orden,[Element],OrdenF).

ordenacion_aux(tree(Element,Left,Right),Comp,Orden,OrdenF) :-
	append(Orden,[Element],OrdenS),
	makeList(tree(Element,Left,Right),[],Lista),
	borraElemento(Element,Lista,Salida),
	lista_hojas(Salida,Hojas),
	hojas_arbol(Hojas,Comp,Arbol),
	ordenacion_aux(Arbol,Comp,OrdenS,OrdenF).