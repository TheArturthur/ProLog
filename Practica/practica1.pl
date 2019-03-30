%Constructors:
anchura/1.
altura/1.
profundidad/1.

suma/3.

list/1.
member/2.
append/3.
length/2.

pieza/4.

esTorre/1.
alturaTorre/2.
coloresTorre/2.
coloresIncluidos/2.

esEdificio/1.
esEdificioPar/1.
esEdificioPiramide/1.

%Facts:
color(a). %Azul es color.
color(am). %Amarillo es color.
color(v). %Verde es color.
color(r). %Rojo es color.

%Predicates:
esTorre(Construccion):- member(X,Construccion), assemblyTorre(. %¿Construccion es una lista de piezas?

alturaTorre(Construccion,A):- esTorre(Construccion). /*A es altura (¿altura(A)?). A == lista miembros de construccion.length*/

coloresTorre(Construccion,Colores):- esTorre(Construccion).

coloresIncluidos(Construccion1,Construccion2):- esTorre(Construccion1), esTorre(Construccion2),
	=(coloresTorre(Construccion1), coloresTorre(Construccion2)).

%Rules:
add(0,X,X).
add(s(X),Y,s(Z)):- add(X,Y,Z).

list([]).
list([X|L]):- list(L).

member(X,[X|_]).
member(X,[_|T]):- member(X,T).

append([],Ys,Ys).
append([X|Xs],Ys,[X|Zs]):- append(Xs,Ys,Zs).

length([],0).
length([X|T],N):- length(T, N1), N is N1 + 1.

pieza(Anchura,Altura,Profundidad,Color):-Anchura>0,Altura>0,Profundidad>0,color(Color).

assembyTorre(Anchura1,Anchura2,Profundidad1,Profundidad2):-Anchura1<=Anchura2,Profundidad1<=Profundidad2.
