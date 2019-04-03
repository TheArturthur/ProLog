%Colores:
color(am).
color(v).
color(a).
color(r).

%0 es natural.
nat(0).
%Si X es natural, X+1 tambien.
nat(s(X)) :- nat(X).

menor_igual(0,X).
menor_igual(s(X),s(Y)) :- menor_igual(X,Y).

mayor_igual(s(X),0) :- nat(X).
mayor_igual(s(X),s(Y)) :- mayor_igual(X,Y).

suma(0,X,X). %X = X+0.
suma(s(X),Y,s(Z)) :- suma(X,Y,Z). %Z+1 = X+1+Y

resta(X,0,X).
resta(s(X),s(Y),Z) :- resta(X,Y,Z).

iguales(s(0),s(0)).
iguales(s(A),s(B)) :- iguales(A,B).

par(0).
par(s(s(X))) :- par(X).

impar(s(0)).
impar(s(s(X))) :- impar(X).

esPieza(Anchura,Altura,Profundidad,Color) :-
	nat(Anchura),
	nat(Altura),
	nat(Profundidad),
	color(Color).

p([H|T],H,T).

append([], L, L).

append([H|T], L, [H|R]) :-
	append(T, L, R).

member(X,[X|_]).
member(X,[_|T]) :- member(X,T).

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
	nat(X),
	resta(X,Altura,Y),
	iguales(s(Y),s(0)).

alturaTorre([pieza(Anchura1,Altura1,Profundidad1,Color1),pieza(Anchura2,Altura2,Profundidad2,Color2)|Ps],X) :-
	esTorre([pieza(Anchura1,Altura1,Profundidad1,Color1),pieza(Anchura2,Altura2,Profundidad2,Color2)|Ps]),
	nat(X),
	resta(X,Altura1,Y),
	alturaTorre([pieza(Anchura2,Altura2,Profundidad2,Color2)|Ps],Y).

coloresTorre([pieza(Anchura,Altura,Profundidad,Color)|[]],[Colores|[]]) :-
	esTorre([pieza(Anchura,Altura,Profundidad,Color)|[]]),
	member(Color,[Colores]).

coloresTorre([pieza(Anchura1,Altura1,Profundidad1,Color1),pieza(Anchura2,Altura2,Profundidad2,Color2)|Ps],[Colores1,Colores2|Cs]) :-
	esTorre([pieza(Anchura1,Altura1,Profundidad1,Color1),pieza(Anchura2,Altura2,Profundidad2,Color2)|Ps]),
	member(Color1,[Colores1,Colores2|Cs]),
	coloresTorre([pieza(Anchura2,Altura2,Profundidad2,Color2)|Ps],[Colores2|Cs]).

coloresIncluidos([pieza(Anchura1,Altura1,Profundidad1,Color1)|[]],[pieza(Anchura2,Altura2,Profundidad2,Color2)|[]]) :-
	esTorre([pieza(Anchura1,Altura1,Profundidad1,Color1)|[]]),
	esTorre([pieza(Anchura2,Altura2,Profundidad2,Color2)|[]]),
	Color1 = Color2.

coloresIncluidos([pieza(Anchura1_1,Altura1_1,Profundidad1_1,Color1_1),pieza(Anchura1_2,Altura1_2,Profundidad1_2,Color1_2)|Ps1],
	[pieza(Anchura2_1,Altura2_1,Profundidad2_1,Color2_1),pieza(Anchura2_2,Altura2_2,Profundidad2_2,Color2_2)|Ps2]) :-
 esTorre([pieza(Anchura1_1,Altura1_1,Profundidad1_1,Color1_1),pieza(Anchura1_2,Altura1_2,Profundidad1_2,Color1_2)|Ps1]),
 esTorre([pieza(Anchura2_1,Altura2_1,Profundidad2_1,Color2_1),pieza(Anchura2_2,Altura2_2,Profundidad2_2,Color2_2)|Ps2]),
 listaColores([pieza(_,_,_,Color2_1),pieza(_,_,_,Color2_2)|Ps2],[Colores|Cs]),
 estaColor([pieza(_,_,_,Color1_1),pieza(_,_,_,Color1_2)|Ps1],[Colores|Cs]).

listaColores([pieza(_,_,_,Color)|[]],[H|T]) :-
	append([H|T],[Color],[Colores|Cs]).

listaColores([pieza(_,_,_,Color1),pieza(_,_,_,Color2)|Ps],[H|T]) :-
	append([H|T],[Color1],[Colores|Cs]),
	listaColores([pieza(_,_,_,Color2)|Ps],[Colores|Cs]).

estaColor([pieza(_,_,_,Color)|[]],[Colores|Cs]) :-
	member(Color,[Colores|Cs]).

estaColor([pieza(_,_,_,Color1),pieza(_,_,_,Color2)|Ps],[Colores|Cs]) :-
	member(Color1,[Colores|Cs]),
	estaColor([pieza(_,_,_,Color2)|Ps],[Colores|Cs]).

%esEdificioPar() :- .

%esEdificioPiramide() :- .

