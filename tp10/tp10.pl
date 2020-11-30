solve(InitialState,Trace) :-
        search(InitialState,[InitialState],Trace).

search(CurrentState,Trace,Trace):-
        is_solution(CurrentState).

search(CurrentState,AccTrace,Trace):-
        try_action(CurrentState,NewState),
        validate_state(NewState),
        no_loop(NewState,AccTrace),
        search(NewState,[NewState|AccTrace],Trace).

no_loop(NewState,AccTrace) :-
        not(member(NewState,AccTrace)).
        % Using negation here is only `safe'
        % when NewState and AccTrace are already
        % instantiated when no_loop/2 is called.

% desired end state is t(0,0,1).
is_solution(t(0,0,1)).


try_action(t(M,C,-1),t(NewM,NewC,1)):-
	% boat goes from start-shore to end-shore
        cross_start_to_end(M,C,2,NewM,NewC); % either 2 people cross ...
	cross_start_to_end(M,C,1,NewM,NewC). % ... or only 1.

try_action(t(M,C,1),t(NewM,NewC,-1)):-
	% boat goes from end-shore to start-shore
        cross_end_to_start(M,C,2,NewM,NewC); % either 2 people cross ...
	cross_end_to_start(M,C,1,NewM,NewC). % ... or only 1.


cross_start_to_end(M,C,0,M,C):- !.

cross_start_to_end(M,C,N,NewM,NewC):-
	M2 is M-1,  % let a missionary cross
	M2>=0,
	N1 is N-1,
	cross_start_to_end(M2,C,N1,NewM,NewC).

cross_start_to_end(M,C,N,NewM,NewC):-
	C2 is C-1,  % let a cannibal cross
	C2>=0,
	N1 is N-1,
	cross_start_to_end(M,C2,N1,NewM,NewC).

cross_end_to_start(M,C,0,M,C):- !.

cross_end_to_start(M,C,N,NewM,NewC):-
	M2 is M+1,  % let a missionary cross
	M2=<3,
	N1 is N-1,
	cross_end_to_start(M2,C,N1,NewM,NewC).

cross_end_to_start(M,C,N,NewM,NewC):-
	C2 is C+1,  % let a cannibal cross
	C2=<3,
	N1 is N-1,
	cross_end_to_start(M,C2,N1,NewM,NewC).

validate_state(t(M,C,_)):-
        OtherM is 3 - M,
        OtherC is 3 - C,
        nobody_eaten(M,C),  % start-shore
        nobody_eaten(OtherM,OtherC). % end-shore

nobody_eaten(0,_). % no missionaries
nobody_eaten(M,C):-
        C =< M. % not more cannibals than missionaries.

member(H,[H|_]).
member(H,[_|T]) :-
	member(H,T).
