
%Exercice 1

first(Element,[Head|_]):-
    Element = Head.

first(Element,[Element|_]).


%last(Element,[_|Tail]):-
%    last(Element,Tail).

%last(Element,[Element|[]]).

remove(T, [], []).

remove(T, [T|Tail], Tail).

remove(T, [H1|T1], FinalList):-
    HeadTempo = H1,
    remove(T, T1, TailTempo),
    FinalList = [HeadTempo|TailTempo].

remove_all(_,[],[]).

remove_all(T, [T|Tail],NewList):-
    remove_all(T, Tail, NewList).

remove_all(T, [H1|T1], [H1|TailTempo]):-
    H1 \= T,
    %HeadTempo = H1,
    remove_all(T, T1, TailTempo).
    %TempoList = [HeadTempo|TailTempo],
    %remove_all(T,TempoList,FinalList).

remove_all(_, [], []).

remove_all(El, [El|Tail], Tail2):-
	remove_all(El, Tail, Tail2).

remove_all(El, [Head|Tail], [Head|Tail2]):-
	not(El = Head),
	remove_all(El, Tail, Tail2).

%
%
% EXERCICE 5
%
%

split_matrix([],[],[]).
split_matrix([[A|B]|C],[A|First],[B|WithoutFirst]):-
    split_matrix(C,First,WithoutFirst).

transpose([[]|_],[]).
transpose(Matrix,[FirstColumn|TransposedRestMatrix]):-
    split_matrix(Matrix,FirstColumn,RestMatrix),
    transpose(RestMatrix,TransposedRestMatrix).
