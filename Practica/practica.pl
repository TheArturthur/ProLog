%Colores:
color(am).
color(v).
color(a).
color(r).

%0 es natural.
nat(0).
%Si X es natural, X+1 tambien.
nat(s(X)) :- nat(X).

menor_igual(s(0),X) :- X\=0.
menor_igual(s(X),s(Y)) :- menor_igual(X,Y).

mayor_igual(s(X),0) :- nat(X).
mayor_igual(s(X),s(Y)) :- mayor_igual(X,Y).

suma(0,X,X). %X = X+0.
suma(s(X),Y,s(Z)) :- suma(X,Y,Z). %Z+1 = X+1+Y

resta(X,0,X).
resta(X,Y,Z) :- resta(s(X),Y,s(Z)).

esPieza(Anchura,Altura,Profundidad,Color) :-
	nat(Anchura),
	nat(Altura),
	nat(Profundidad),
	color(Color).

p([H|T],H,T).

esTorre([pieza(Anchura,Altura,Profundidad,Color)|[]]) :-
	esPieza(Anchura,Altura,Profundidad,Color).

esTorre([pieza(Anchura1,Altura1,Profundidad1,Color1),pieza(Anchura2,Altura2,Profundidad2,Color2)|Ps]) :-
	esPieza(Anchura1,Altura1,Profundidad1,Color1),
	esPieza(Anchura2,Altura2,Profundidad2,Color2),
	menor_igual(Anchura1,Anchura2),
	menor_igual(Profundidad1,Profundidad2),
	esTorre([pieza(Anchura2,Altura2,Profundidad2,Color2)|Ps]).

alturaTorre([pieza(Anchura,Altura,Profundidad,Color)|[]],1).

alturaTorre([pieza(Anchura,Altura,Profundidad,Color)|Ps],X) :-
	resta(X,Altura1,X),
	