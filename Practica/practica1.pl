%Constructors:
suma/3.

list/1.
member/2.
append/3.
length/2.

assemblyTorre/4.
pieza/4.
torre/1.
torre/2.

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

alturaTorre(Construccion,A):- esTorre(Construccion). /*A es altura (¿altura(A)?). A == lista miembros de construccion.length*/

coloresTorre(Construccion,Colores):- esTorre(Construccion).

coloresIncluidos(Construccion1,Construccion2):- esTorre(Construccion1), esTorre(Construccion2),
	=(coloresTorre(Construccion1), coloresTorre(Construccion2)).

%Rules:
% nat(X)/1 --> X is a natural number
nat(0).
nat(s(X)) :- nat(X).

menor_o_igual_que(s(0),X) :- X\=0.  % min(0,X) = X
menor_o_igual_que(s(X),s(Y)) :- menor_o_igual_que(X,Y).

mayor_o_igual_que(X,s(0)) :- X\=0.  % min(0,X) = X
mayor_o_igual_que(s(X),s(Y)) :- mayor_o_igual_que(X,Y).

% even(X)/1 --> X is an even number
even(0).        % 0 is an even number
even(s(s(X))) :-    % n is an even number if n-2 is an even number
    even(X).    

% addition(X,Y,Z)/3 --> Z = X+Y
addition(0,X,X).              % 0+X = X
addition(s(X),Y,s(Z)) :-    % x+1+y=z+1
    addition(X,s(Y),Z).

% multiply(X,Y,Z)/3 --> Z=X*Y
multiply(0,X,0) :- nat(X).          % 0*X=0
multiply(s(X),Y,Z) :-               % (X+1)*Y=(X*Y)+Y
    multiply(X,Y,A),
    addition(A,Y,Z).

% fact(X,Y)/2 --> Y = X!
fact(0,s(0)).               % 0! = 1
fact(s(X),Y) :-             % (X+1)! = X! * (X+1)
    fact(X,Z), multiply(s(X),Z,Y).

% TODO: Not working
% exp(X,Y,Z) --> Z = X^Y
exp(_,0,s(0)).                        % X^0 = 1
exp(X,Y,Z) :-                   % X^(Y+1) = X^(Y)*X
    exp(X,Y,S), multiply(X,S,Z).

% greater(X,Y) --> X > Y
greater(X,0) :- X\=0.        % max(X,0) = X
greater(s(X),s(Y)) :- greater(X,Y).

% lower(X,Y) --> X < Y
lower(0,X) :- X\=0.        % min(0,X) = X
lower(s(X),s(Y)) :- lower(X,Y).

% min(X,Y,Z)/3 --> Z = min(X,Y)
min(_,0,0).        % min(X,0) = 0
min(X,Y,X) :- lower(X,Y).
min(X,Y,Y) :- lower(Y,X).

% Calcular menor_que
menor_que(0, s(X)):- nat(X).

menor_que(s(X),s(Y)):- menor_que(X, Y).
% Fin menor_que

% Calcular par
par(0).
par(s(s(X))):- par(X).
% fin par

list([]).
list([X|L]):- list(L).

member(X,[X|_]).
member(X,[_|T]):- member(X,T).

append([],Ys,Ys).
append([X|Xs],Ys,[X|Zs]):- append(Xs,Ys,Zs).

length([],0).
length([X|T],N):- length(T, N1), N is N1 + 1.

pieza(Anchura,Altura,Profundidad,Color):-Anchura>0,Altura>0,Profundidad>0,color(Color).

assemblyTorre(Anchura1,Anchura2,Profundidad1,Profundidad2):- 
menor_o_igual_que(Anchura1,Anchura2), 
menor_o_igual_que(Profundidad1,Profundidad2).

esTorre([pieza(Anchura1,Altura1,Profundidad1,Color1)]).
esTorre([pieza(Anchura1,Altura1,Profundidad1,Color1),pieza(Anchura2,Altura2,Profundidad2,Color2)|[]]):-
	assemblyTorre(Anchura1,Anchura2,Profundidad1,Profundidad2).
esTorre([pieza(Anchura1,Altura1,Profundidad1,Color1),pieza(Anchura2,Altura2,Profundidad2,Color2)|Ps]):-
	assemblyTorre(Anchura1,Anchura2,Profundidad1,Profundidad2),
	torre([pieza(Anchura2,Altura2,Profundidad2,Color2)|Ps]).