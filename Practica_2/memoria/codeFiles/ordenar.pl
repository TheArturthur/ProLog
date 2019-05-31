ordenar(Lista,Comp,Orden) :-
	lista_hojas(Lista,Hojas),
	hojas_arbol(Hojas,Comp,Arbol),
	ordenacion(Arbol,Comp,Orden).