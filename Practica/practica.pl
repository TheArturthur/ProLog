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
resta(s(X),s(Y),Z) :- resta(X,Y,Z). %Z=X-Y

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

alturaTorre(Torre,X) :-
	esTorre(Torre),
	nat(X),
	sacarAltura(Torre,X).

sacarAltura([pieza(Anchura[pieza(Anchura1,Altura1,Profundidad1,Color1),pieza(Anchura2,Altura2,Profundidad2,Color2)|Ps],X) :-
	resta(X,Altura1,Y),
	alturaTorre([pieza(Anchura2,Altura2,Profundidad2,Color2)|Ps],Y).	  

coloresTorre([pieza(Anchura,Altura,Profundidad,Color)|[]],[Colores|[]]) :-
	esTorre([pieza(Anchura,Altura,Profundidad,Color)|[]]),
	member(Color,[Colores]).

coloresTorre(Torre,Colores) :-
	esTorre(Torre),
	sacarColores(Torre, Colores).

sacarColores([pieza(Anchura1,Altura1,Profundidad1,Color1),pieza(Anchura2,Altura2,Profundidad2,Color2)|Ps],[Colores1,Colores2|Cs]) :-
	member(Color1,[Colores1,Colores2|Cs]),
	coloresTorre([pieza(Anchura2,Altura2,Profundidad2,Color2)|Ps],[Colores2|Cs]).

coloresIncluidos(Torre1,Torre2) :-
    esTorre(Torre1),
    esTorre(Torre2),
    comprobarColores(Torre1,Torre2,Torre2).

comprobarColores([],_,_).

comprobarColores([pieza(_,_,_,Color)|Torre1],[pieza(_,_,_,Color)|_],Torre2):-
	comprobarColores(Torre1,Torre2,Torre2).

comprobarColores(Torre1,[_|Torre2],T):-
	comprobarColores(Torre1,Torre2,T).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%EDIFICIO%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


esEdificioPar([Linea|[]]) :-
	lineaPar(Linea).

esEdificioPar([Linea1|RestoLineas]) :-
	lineaPar(Linea1),
	esEdificioPar(RestoLineas).

lineaPar([]).

lineaPar(Linea) :-
	longitudLinea(Linea,Longitud),
	par(Longitud).

longitudLinea(Linea,N) :-
	longitudSinBlanco(Linea,0,N).

longitudSinBlanco([],N1,N2) :-
	N2 = N1.

longitudSinBlanco([b|Resto],N1,N2) :-
	longitudSinBlanco(Resto,N1,N2).

longitudSinBlanco([C|Resto],N1,N2) :-
	color(C),
	longitudSinBlanco(Resto,s(N1),N2).

esEdificioPiramide() :- .

