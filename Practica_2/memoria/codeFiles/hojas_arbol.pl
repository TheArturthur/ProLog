hojas_arbol([Hoja|Hojas],Comp,Arbol) :-
	hojasArbolRec(Hojas,Comp,Hoja,Arbol).

hojasArbolRec([],_,Arbol,Arbol).

hojasArbolRec([H|T],Comp,Arbol,Tree) :-
	arg(1,H,RaizIzq),
	arg(1,Arbol,Raiz),
	menor(Raiz,RaizIzq,Comp,M),
	hojasArbolRec(T,Comp,tree(M,Arbol,H),Tree).
