(** Function Definitions*)
let shape_score = function  "X" -> 1 | "Y" -> 2 | "Z" -> 3 | "A" -> 1 | "B" -> 2 | "C" -> 3 | _ -> 0;;
let game_score = function 
|  [x;y] when shape_score(y) = shape_score(x) -> shape_score(y) + 3
|  [x;y] when shape_score(y) = 1 && shape_score(x) = 3 -> shape_score(y) + 6
|  [x;y] when shape_score(y) = 2 && shape_score(x) = 1 -> shape_score(y) + 6 
|  [x;y] when shape_score(y) = 3 && shape_score(x) = 2 -> shape_score(y) + 6
|  [x;y] -> shape_score(y)
|  x::y -> 0
|  [] -> 0;;

let game_result = function "X" -> "Lose" | "Y" -> "Draw" | "Z" -> "Win" | _ -> "Error";;
let lose_result = function | 1 -> "Z" | 2 -> "X" | 3 -> "Y" | _ -> "Error";;
let draw_result = function | 1 -> "X" | 2 -> "Y" | 3 -> "Z" | _ -> "Error";;
let win_result = function | 1 -> "Y" | 2 -> "Z" | 3 -> "X" | _ -> "Error";;

let transform_to_desired_game = function
| [x;y] when game_result(y) = "Lose" -> [x;lose_result(shape_score(x))]
| [x;y] when game_result(y) = "Draw" -> [x;draw_result(shape_score(x))]
| [x;y] when game_result(y) = "Win" -> [x;win_result(shape_score(x))]
| _::_ -> []
| [] -> [];;

let input = Arg.read_arg "input.txt";;
let split_input = Array.map (Str.split (Str.regexp " ")) input;;

(* Part 1 *)
let game_scores = Array.map game_score split_input;;
let sum_of_game_scores =  Array.fold_left (+) 0 game_scores;;

(* Part 2 *)
let transformed_games = Array.map transform_to_desired_game split_input;;
let transformed_game_scores = Array.map game_score transformed_games;;
let sum_of_transformed_game_scores =  Array.fold_left (+) 0 transformed_game_scores;;