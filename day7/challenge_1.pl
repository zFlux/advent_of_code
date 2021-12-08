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

min_position_cost([], []).
min_position_cost(I, []) :- length(I, 1).
min_position_cost(I, R) :- list_of_position_costs(I, I, R1), list_min(R1, R).

list_min([], Min). 
list_min([H|T], Min) :- list_min(T, H, Min).
list_min([], Min, Min).
list_min([[IH,H]|T], [IMin0, Min0], Min) :-H =< Min0, list_min(T, [IH,H], Min).
list_min([[IH,H]|T], [IMin0, Min0], Min) :-H > Min0, list_min(T, [IMin0,Min0], Min).

list_of_position_costs([], [], []).
list_of_position_costs(I, [A], [[A,AC]]) :- cost_of_position(A, I, AC).
list_of_position_costs(I, [H|T], R) :- cost_of_position(H, I, HC), list_of_position_costs(I, T, RT), append([[H, HC]], RT, R).

cost_of_position(P, [], 0).
cost_of_position(P, [P], 0).
cost_of_position(P, [X], Cost) :- length([X], 1), cost_of_move(P, X, Cost).
cost_of_position(P, [H|T], Cost) :- cost_of_position(P, [H], Cost1), cost_of_position(P, T, Cost2), Cost is Cost1 + Cost2.

cost_of_move(A, A, 0).
cost_of_move(A, B, R) :- atom_number(A, AN), atom_number(B, BN), R is abs(AN - BN).

main :- file_line('input_test.txt', Line),
        split_string(Line, ",", "", InputList),
        list_of_position_costs(InputList, InputList, Result),
        write(Result).



