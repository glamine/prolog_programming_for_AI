listlength([Head|Tail],Count):-
	listlength(Tail,PartialCount),
	Count is PartialCount + 1 .

listlength([],0).

listsum([],0).

countdisk([],0).

countdisk([w|T],C):-
	countdisk(T,C1),
	C is C1+1.

countdisk([b|T],C):-
	countdisk(T,C1),
	C is C1+1.

countdisk([n|T],C):-
	countdisk(T,C).





