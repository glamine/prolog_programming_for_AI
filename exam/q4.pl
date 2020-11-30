
top_score(Course,TopStud,[sc(Student,Course,Mark)|T]):-
    !,
    top_score1(Course,TopStud,Mark,T,Student).

top_score(Course,TopStud,[_|T]):-
    top_score(Course,TopStud,T).

top_score1(_,TopStudent,_,[],TopStudent).
top_score1(Course,TopStudent,TopScore,[sc(Student,Course,Mark)|T],Acc):-
    Mark > TopScore,!,
    top_score1(Course,TopStudent,Mark,T,Student).

%top_score1(Course,TopStudent,TopScore,[sc(_,Course,_)|T]):-
%    !,
%    top_score1(Course,TopStudent,TopScore,T).

top_score1(Course,TopStudent,TopScore,[sc(_,C,_)|T],Acc):-
    %C \= Course,
    top_score1(Course,TopStudent,TopScore,T,Acc).
