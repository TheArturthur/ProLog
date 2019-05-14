<(0,Y,0).
<(X,Y,Z) :- <(X-1,Y-1,M-1).

menor(A,B,Comp,M) :-
	<(A,B,M).