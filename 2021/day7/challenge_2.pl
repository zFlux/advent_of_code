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

mean(List, Mean ):- sum_list( List, Sum ),
    length( List, Length ),
    Length > 0, 
    Mean is floor(Sum / Length).

sum_list([], 0).
sum_list([H|T], Sum) :-
   sum_list(T, Rest),
   Sum is H + Rest.

min_position_cost([], []).
min_position_cost(I, R) :- mean(I, Mean), cost_of_position(Mean, I, R).

cost_of_position(P, [], 0).
cost_of_position(P, [P], 0).
cost_of_position(P, [X], Cost) :- length([X], 1), length_of_move(P, X, L), cost_of_move(L, Cost).
cost_of_position(P, [H|T], Cost) :- cost_of_position(P, [H], Cost1), cost_of_position(P, T, Cost2), Cost is Cost1 + Cost2.

length_of_move(A, A, 0).
length_of_move(A, B, R) :- R is abs(A - B).

cost_of_move(X, R) :- R is X * (X+1) / 2 .

main :- file_line('input.txt', Line),
        split_string(Line, ",", "", StringList),
        maplist(number_string, InputList, StringList),
        min_position_cost(InputList, Result),
        write("Challenge 2 Solution: "),
        write(Result).