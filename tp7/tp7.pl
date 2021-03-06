p(Graph,Node) :- member(Parent/Node,Graph), write(Parent), nl, fail.
p(_Graph,_Node) :- write('end').

all_parents(Graph,Node,ParentList):-
    findall(Parent,member(Parent/Node,Graph), ParentList).

find_path_2(X,Y,Path,Graph) :-
        find_path_acc_2(X,Y,Path,[Y],Graph).

find_path_acc_2(X,X,Path,Path,_).
find_path_acc_2(X,Y,Path,Acc,G) :-
	arc(Z,Y,G),
        not(member(Z,Acc)), % <------ only difference
	find_path_acc_2(X,Z,Path,[Z|Acc],G).

%shortest_path(X,Y,Graph,ShortestPath):-

