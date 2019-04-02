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
resta(s(X),s(Y),Z) :- resta(X,Y,Z).

iguales(s(0),s(0)).
iguales(s(A),s(B)) :- iguales(A,B).

esPieza(Anchura,Altura,Profundidad,Color) :-
	nat(Anchura),
	nat(Altura),
	nat(Profundidad),
	color(Color).

p([H|T],H,T).

member(X,[X|L]).
member(X,[_|L]):-member(X,L).

esTorre([pieza(Anchura,Altura,Profundidad,Color)|[]]) :-
	esPieza(Anchura,Altura,Profundidad,Color).

esTorre([pieza(Anchura1,Altura1,Profundidad1,Color1),pieza(Anchura2,Altura2,Profundidad2,Color2)|Ps]) :-
	esPieza(Anchura1,Altura1,Profundidad1,Color1),
	esPieza(Anchura2,Altura2,Profundidad2,Color2),
	menor_igual(Anchura1,Anchura2),
	menor_igual(Profundidad1,Profundidad2),
	esTorre([pieza(Anchura2,Altura2,Profundidad2,Color2)|Ps]).

alturaTorre([pieza(Anchura,Altura,Profundidad,Color)|[]],X) :-
	esTorre([pieza(Anchura,Altura,Profundidad,Color)|[]]),
	resta(X,Altura,X),
	iguales(s(s(X)),s(0)).

alturaTorre([pieza(Anchura1,Altura1,Profundidad1,Color1),pieza(Anchura2,Altura2,Profundidad2,Color2)|Ps,X) :-
	esTorre([pieza(Anchura1,Altura1,Profundidad1,Color1),pieza(Anchura2,Altura2,Profundidad2,Color2)|Ps]),
	resta(X,Altura1,X),
	alturaTorre([pieza(Anchura2,Altura2,Profundidad2,Color2)|Ps],X).

coloresTorre([pieza(Anchura,Altura,Profundidad,Color)|[]],Colores) :-
	esTorre([pieza(Anchura,Altura,Profundidad,Color)|Colores),
	member(Color,Colores).

coloresTorre([pieza(Anchura,Altura,Profundidad,Color1),pieza(Anchura2,Altura2,Profundidad2,Color2)|Ps],Colores) :-
	esTorre([pieza(Anchura,Altura,Profundidad,Color1)|[]).

coloresIncluidos() :-.

coloresIncluidos() :-	.

esEdificioPar() :-	.

