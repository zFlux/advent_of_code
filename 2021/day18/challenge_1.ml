let () =
  let input_channel = open_in "input_test.txt" in
  let rec list_builder a_string acc index = 
    if index = String.length(a_string) then acc
    else if
    let acc = [] in
    let fold_func x y = y :: x in
      String.fold_left (fold_func) acc a_string in
  try
    while true do
      let line = input_line input_channel in
      let parsed_list = list_parser line in 
      List.iter (Printf.printf "%c ") exploaded_list
    done
  with End_of_file ->
    close_in input_channel