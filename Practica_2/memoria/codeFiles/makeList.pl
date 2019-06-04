makeList(tree(Element,void,void), Lista, [Element|Lista]).

makeList(tree(_,Left,Right), Lista, ListaSalida) :-
	Right = tree(ElementRight,_,_),
	append(Lista,[ElementRight],Lista2),
	makeList(Left,Lista2,ListaSalida).