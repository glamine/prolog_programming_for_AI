clp(Vars):-
    Vars=[Soprano,Mezzo,Tenor,TenorD,Bass,Chris,JP,Lee,Pat,Val,
          Kingsley,Robinson,RobinsonD,Ulrich,Walker],
    I=[Soprano,Mezzo,Tenor,TenorD,Bass],
    FN=[Chris,JP,Lee,Pat,Val],
    LN=[Kingsley,Robinson,RobinsonD,Ulrich,Walker],
    domain(I,1,5),domain(FN,1,5),domain(LN,1,5),
    all_different(I),all_different(FN),all_different(LN),
    (Pat #= 1#/\ Bass #= 2) #\/ (Pat #= 2 #/\ Bass #= 1), % Constraint 1
    Tenor#= 2 #\/Tenor#=3, % constraint 2
    (Kingsley#=Mezzo #/\ Tenor#=5) #\/ (Kingsley#=Tenor #/\ Mezzo#=5),
	%RobinsonD#\=5,% constraint 3
    Robinson#=3,
    Walker#\=Chris,
    Chris#\=3, % constraint 4
    Ulrich#\=Bass,
    Ulrich#\=Mezzo, % constraint 5
    Lee#\=Tenor,
	Lee#\=TenorD,
    Val#\=Tenor,
	Val#\=TenorD,
    Val#\=3, %C6
    JP#\=3,
    Chris#\=5, %C7
    Bass#\=Robinson,
	Bass#\=RobinsonD,
    labeling([],Vars),
	write('Soprano: '), write(Soprano),nl,
	write('Mezzo: '), write(Mezzo),nl,
	write('Tenor: '), write(Tenor),nl,
	write('TenorD: '), write(TenorD),nl,
	write('Bass: '), write(Bass),nl,
	write('Chris: '), write(Chris),nl,
	write('JP: '), write(JP),nl,
	write('Lee: '), write(Lee),nl,
	write('Pat: '), write(Pat),nl,
	write('Val: '),write(Val),nl,
	write('Kingsley: '),write(Kingsley),nl,
	write('Robinson: '),write(Robinson),nl,
	write('RobinsonD: '),write(RobinsonD),nl,
	write('Ulrich: '),write(Ulrich),nl,
	write('Walker: '),write(Walker),nl,
    write(Vars),nl.
