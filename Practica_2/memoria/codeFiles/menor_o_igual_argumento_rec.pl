menor_igual_argumento_rec([], []).

menor_igual_argumento_rec([Arg1|T1], [Brg1|T2]) :-
	(number(Arg1), number(Brg1), Arg1 =< Brg1 ;
	    Arg1 @=< Brg1),
	menor_igual_argumento_rec(T1, T2).
