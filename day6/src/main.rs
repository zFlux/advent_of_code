use std::fs::File;
use std::io::{BufRead, BufReader};

fn main() {
    let file_path = "/home/daniel/sandbox/advent_of_code/day6/src/resources/input.txt";
    let first_input_line = first_line_from_file(&file_path);
    let initial_countdowns = first_input_line.split(",");

    let mut sum: u128 = 0; 
    for countdown in initial_countdowns {
        let mut day_array: [u128; 256] = [0;256]; 
        populate_days(countdown.parse().unwrap(), &mut day_array);
        sum+=day_array.iter().sum::<u128>();
        sum+=1;
    }

    println!("Challenge 1 - How many Lattern Fish after x Days: {:?}", sum);
}

fn populate_days(mut countdown: usize, day_array: &mut [u128;256]) {
    
    day_array[countdown]+=1;
    if countdown+9 < day_array.len() {
        populate_days(countdown+9, day_array);
    }
    while countdown <= day_array.len()-8 {
        countdown+=7;
        day_array[countdown]+=1;
        if countdown+9 < day_array.len() {
            populate_days(countdown + 9, day_array);
        }
    }
}

fn first_line_from_file(file_path: &str) -> String {
    let mut line = String::new();
    if let Ok(file) = File::open(file_path) {
        let reader = BufReader::new(file);
        line = reader.lines().next().unwrap().unwrap();
    }
    return line;
}