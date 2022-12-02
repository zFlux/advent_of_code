file_line(File, Line) :-
    setup_call_cleanup(open(File, read, In),
        stream_line(In, Line),
        close(In)).
        
stream_line(In, Line) :-
    repeat,
    (   read_line_to_string(In, Line0),
        Line0 \== end_of_file
    ->  Line0 = Line
    ;   !,
        fail
    ).

median(List, Median) :-
    msort(List, SortedList),
    middle_element(SortedList, SortedList, Median).

middle_element([], [M|_], M).
middle_element([_], [M|_], M).
middle_element([_,_|Xs], [_|Ys], M) :-
    middle_element(Xs, Ys, M).

min_position_cost([], []).
min_position_cost(I, R) :- median(I, Median), cost_of_position(Median, I, R).

cost_of_position(P, [], 0).
cost_of_position(P, [P], 0).
cost_of_position(P, [X], Cost) :- length([X], 1), cost_of_move(P, X, Cost).
cost_of_position(P, [H|T], Cost) :- cost_of_position(P, [H], Cost1), cost_of_position(P, T, Cost2), Cost is Cost1 + Cost2.

cost_of_move(A, A, 0).
cost_of_move(A, B, R) :- R is abs(A - B).


main :- file_line('input.txt', Line),
        split_string(Line, ",", "", StringList),
        maplist(number_string, InputList, StringList),
        min_position_cost(InputList, Result),
        write("Challenge 1 Solution: "),
        write(Result).