%
%
% Exercice 3
%
%

generate_and_test([Cube1,Cube2,Cube3,Cube4],[O1,O2,O3,O4]) :-
	% generate a stack with the cubes in some orientation:
	is_basic_orientation(O1), % 3 possibilities for cube1
	is_orientation(O2), % 24 possibilities for cube2
	is_orientation(O3), % 24 possibilities for cube3
	is_orientation(O4), % 24 possibilities for cube4
	% test the stack:
	test_stack([Cube1,Cube2,Cube3,Cube4],[O1,O2,O3,O4]).

stepwise([Cube1,Cube2,Cube3,Cube4],[O1,O2,O3,O4]) :-
	is_basic_orientation(O1), % 3 possibilities for cube1
	is_orientation(O2), % 24 possibilities for cube2
	test_cube_stack(Cube2,O2,[Cube1],[O1]), % test cube2 versus the stack with cube1
	is_orientation(O3), % cube3
	test_cube_stack(Cube3,O3,[Cube1,Cube2],[O1,O2]),% test cube3 versus the stack with cube1 and cube2
	is_orientation(O4), % cube4
	test_cube_stack(Cube4,O4,[Cube1,Cube2,Cube3],[O1,O2,O3]). % test cube4 versus the stack with cube1, cube2 and cube3

% 3 basic orientations:
is_basic_orientation(o(1,5,2,6,4,3)).
is_basic_orientation(o(2,4,1,3,5,6)).
is_basic_orientation(o(3,6,1,4,5,2)).

% 24 orientations in total:
is_orientation(O) :-
	% take a basic orientation ...
	is_basic_orientation(B),
	% ... and turn it around horizantally 0, 90, 180 or 270 degrees
	member(Degrees,[0,90,180,270]),
	turn_horizontally(B,Degrees,O).

is_orientation(O) :-
	% take a basic orientation ...
	is_basic_orientation(B),
        % ... turn it upside down (switching top and bottom) ...
	turn_upside_down(B,UpsideDown),
	% ... and turn it around horizantally 0, 90, 180 or 270 degrees
	member(Degrees,[0,90,180,270]),
	turn_horizontally(UpsideDown,Degrees,O).

member(X,[X|_]).
member(X,[_|T]) :-
	member(X,T).

turn_upside_down(o(T,Bo,F,L,Ba,R),o(Bo,T,Ba,L,F,R)).
turn_horizontally(o(T,Bo,F,L,Ba,R),0,o(T,Bo,F,L,Ba,R)).
turn_horizontally(o(T,Bo,F,L,Ba,R),90,o(T,Bo,R,F,L,Ba)).
turn_horizontally(o(T,Bo,F,L,Ba,R),180,o(T,Bo,Ba,R,F,L)).
turn_horizontally(o(T,Bo,F,L,Ba,R),270,o(T,Bo,L,Ba,R,F)).

test_stack([],[]).
test_stack([Cube1|Cubes],[O1|O]) :-
	test_cube_stack(Cube1,O1,Cubes,O),
	test_stack(Cubes,O).

test_cube_stack(_,_,[],[]).
test_cube_stack(Cube1,O1,[Cube2|Cubes],[O2|O]) :-
	test_two_cubes(Cube1,O1,Cube2,O2),
	test_cube_stack(Cube1,O1,Cubes,O).

test_two_cubes(C1,O1,C2,O2) :-
        % the front, left, back and right sides should be different
	test_side(C1,O1,C2,O2,front),
	test_side(C1,O1,C2,O2,left),
	test_side(C1,O1,C2,O2,back),
	test_side(C1,O1,C2,O2,right).

test_side(C1,O1,C2,O2,Side) :-
	get_figure(C1,O1,Side,Fig1),
	get_figure(C2,O2,Side,Fig2),
	not(Fig1=Fig2).

% For a given cube in a given orientation, what is the Figure on a given side:
get_figure(Cube,O,Side,Figure) :-
	get_face(O,Side,FaceNb),
	get_figure_on_face(Cube,FaceNb,Figure).

get_face(o(FaceNb,_,_,_,_,_),top,FaceNb).
get_face(o(_,FaceNb,_,_,_,_),bottom,FaceNb).
get_face(o(_,_,FaceNb,_,_,_),front,FaceNb).
get_face(o(_,_,_,FaceNb,_,_),left,FaceNb).
get_face(o(_,_,_,_,FaceNb,_),back,FaceNb).
get_face(o(_,_,_,_,_,FaceNb),right,FaceNb).

get_figure_on_face(cube(Fig,_,_,_,_,_),1,Fig).
get_figure_on_face(cube(_,Fig,_,_,_,_),2,Fig).
get_figure_on_face(cube(_,_,Fig,_,_,_),3,Fig).
get_figure_on_face(cube(_,_,_,Fig,_,_),4,Fig).
get_figure_on_face(cube(_,_,_,_,Fig,_),5,Fig).
get_figure_on_face(cube(_,_,_,_,_,Fig),6,Fig).


