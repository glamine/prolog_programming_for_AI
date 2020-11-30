count(nil, 0).
count(t(Left,_,Right),Res):-
	count(Left,Lc),
	count(Right,Rc),
	Res is Lc + Rc + 1 .

depth(nil,0).
depth(t(Left,_,Right),D):-
	depth(Left,Dl),
	depth(Right,Dr),
	max(Dl,Dr,Dtmp),
        D is Dtmp + 1 .

max(A,B,A):-gt(A,B),!.
max(_,B,B).


linearize(nil,[]).
linearize(t(Left,Root,Right),Res):-
	linearize(Left,L),
	linearize(Right,R),
	conc(L,[Root|R],Res).

close(nil):- !.%leaf
close(t(Left,_,Right)):- %non-leaf
	close(Left),
	close(Right).


%
%
%

occur(X,[X|_]).

occur(X,[H|T]):-
	gt(X,H), % if X>H continue searching, else stop searching
	occur(X,T).

occurthree(X,[_,_,X|_]).

occurthree(X,[_,_,H|Tail]):-
	gt(X,H), % if X>H continue searching, else stop searching
        occurthree(X,Tail).

occurthree(X,[X|_]).

occurthree(X,[_,X|_]).

%
%
%

sorted(nil). % naive version, pcq couvre chaque subtree multiple times
sorted(t(Left,Root,Right)):-
	smaller(Left,Root), sorted(Left),
	larger(Right,Root), sorted(Right).


smaller(nil,_).
smaller(t(Left,Node,Right),Nr):-
	gt(Nr,Node),
	smaller(Left,Nr), % attention, hyper important de faire ces 2
	smaller(Right,Nr).% appels recursifs, sinon marchera pas

larger(nil,_).
larger(t(Left,Node,Right),Nr):-
	gt(Node,Nr),
	larger(Left,Nr),
	larger(Right,Nr).

%
% better version, more efficient
% NOTE : a l'exam, peut juste faire une naive, c'est ok
%

sorted_2(nil).
sorted_2(t(Left,Nr,Right)):-
	smaller_and_sorted(Left,Nr),
	larger_and_sorted(Right,Nr).

smaller_and_sorted(nil,_).
smaller_and_sorted(t(Left,Node,Right),Nr):-
	gt(Nr,Node),
	smaller_and_sorted(Left,Node),
	between_and_sorted(Right,Node,Nr).

larger_and_sorted(nil,_).
larger_and_sorted(t(Left,Node,Right),Nr):-
	gt(Node,Nr),
	between_and_sorted(Left,Nr,Node),
	larger_and_sorted(Right,Node).

between_and_sorted(nil,_,_).
between_and_sorted(t(Left,Nr,Right),Low,High):-
	gt(Nr,Low),
	gt(High,Nr),
	between_and_sorted(Left,Low,Nr),
	between_and_sorted(Right,Nr,High).

%
%
%

% balanced(nil).
% balanced(t(Left,Root,Right)):-


balanced(nil).
balanced(t(Left,_,Right)):-
    depth(Left,Dl),
    depth(Right,Dr),
    Dif is Dl - Dr,
    Dif >= -1, Dif =< 1,
    balanced(Left),
    balanced(Right).


list_to_balanced([], nil).
list_to_balanced(List, t(Left, Middle, Right)):-
        length(List, N), N>0,
        SplitPos is (N+1)//2, % // is integer division
        split_list(List, SplitPos, Part1, Middle, Part2),
        list_to_balanced(Part1, Left),
        list_to_balanced(Part2, Right).

split_list([H|T], 1, [], H, T).
split_list([H|T], SplitPos, [H|T1], El, L2):-
        SplitPos > 1,
        NewSplitPos is SplitPos-1,
        split_list(T, NewSplitPos, T1, El, L2).

