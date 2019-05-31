lista_hojas([], []).

lista_hojas([H|T], [tree(H, void, void)|Hojas]) :-
	lista_hojas(T, Hojas).