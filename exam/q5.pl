
my_append(List1,List2,List3):-
    append_dl(List1-[],List2-[],List3-[]).

append_dl(L-T,K-S,L-S):-
    T = K.

add_at_end(E,A-B,A-D):-
    B = [E|D].

member(El,[El|_]).

member(El,[_|T]):-
    member(El,T).

element(X,[X|_]).
element(X,[Y|_]):-
    element(X,Y).
element(X,[_|T]):-
    element(X,T).

