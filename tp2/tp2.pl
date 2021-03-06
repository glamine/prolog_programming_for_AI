% the base case: if the number has only one digit
% then this number is the sum of all digits
count(Number,Number):-
        % the condition under which this applies:
	Number < 10.

% the recursive case: cut away the last digit,
% add the rest of the digits (=recursive call) ,
% and add the last digit to that sum.
count(Number,Sum):-
        % the condition under which this applies:
	Number >= 10,
        % 'split' the number
        split_number(Number,Digit,NewNumber),
	% the recursive call:
        count(NewNumber,TmpSum),
        % construct the final result:
	Sum is TmpSum + Digit.

split_number(Number,Digit,NewNumber) :-
	Digit is mod(Number,10),
	NewNumber is Number//10.

%
%
% Exercices 1
%
%

cut_word(Word):-
    % base case no letter
    Word = ''.

cut_word(SubWord):-
    %word at least one letter
    SubWord \= '',
    %
    split_string(SubWord,FirstLetter,RestWord),
    write(FirstLetter),
    % recursive call
    cut_word(RestWord).


%
% Exercice 2
%

direct_road(brugge, ghent).
direct_road(ghent, antwerp).
direct_road(ghent, brussels).
direct_road(antwerp, brussels).
direct_road(hasselt, leuven).
direct_road(brussels, leuven).
direct_road(mons, brussels).
direct_road(mons, namur).
direct_road(namur, liege).
direct_road(bastogne, liege).

reach(StartCity, EndCity):-
    direct_road(StartCity,EndCity).

reach(StartCity,EndCity):-
    direct_road(StartCity,OtherCity),
    reach(OtherCity,EndCity).

%direct_road(A,B):-
%	direct_road(B,A). % FUCK FALL INTO A LOOP

%
% Exercice 3
%

all_even(Number):-
        % the condition under which this applies:
	Number < 10,
        A is mod(Number,2),
        A = 0.

% the recursive case: cut away the last digit,
% add the rest of the digits (=recursive call) ,
% and add the last digit to that sum.
all_even(Number):-
        % the condition under which this applies:
	Number >= 10,
        % 'split' the number
        split_number(Number,Digit,NewNumber),
	% the recursive call:
        all_even(Digit),
        all_even(NewNumber).

split_number(Number,Digit,NewNumber) :-
	Digit is mod(Number,10),
	NewNumber is Number//10.


%
% Exercice 4
%

count_even(Number,Count):-
        Number < 10,
        A is mod(Number,2),
        A = 0,
        Count is 1.

count_even(Number,Count):-
        Number < 10,
        A is mod(Number,2),
        A = 1,
        Count is 0.

count_even(Number,Count):-
    Number >= 10,
    split_number(Number,Digit,NewNumber),
    count_even(Digit,Incr),
    count_even(NewNumber,TempCount),
    Count is TempCount + Incr.


%
% Exercice 5
%

even(N):-
	A is mod(N,2),
	A = 0.
odd(N):-
	A is mod(N,2),
	A = 1.

funny(1):-
	write('I will quit'),nl.
funny(N):-
%	write(N), nl,  % <-----
        even(N),
	write(N), nl,  % <-----
	NewN is N / 2,
	funny(NewN).
funny(N):-
%        write(N), nl,  % <-----
	odd(N),
	write(N), nl,  % <-----
	N>1,
	NewN is 3 * N + 1,
	funny(NewN).


%
% Exercice 6
%

