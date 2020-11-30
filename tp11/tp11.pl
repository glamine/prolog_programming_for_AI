%
%
% TP 11
%
%

loan(P,0,_,_,P).
loan(P,T,I,MP,Balance):-
    T > 0,
    T1 is T-1,
    loan(P,T1,I,MP,B1),
    Balance is B1*(1 + I) - MP.
