borraElemento(_,[],[]).

borraElemento(Elemento,[Elemento|T],T).

borraElemento(Elemento,[H|T1],[H|T2]) :-
	borraElemento(Elemento,T1,T2).