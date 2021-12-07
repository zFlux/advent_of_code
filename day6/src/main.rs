use std::fs::File;
use std::io::{BufRead, BufReader};
use std::str::FromStr;

fn main() {
    let file_path = "/home/daniel/sandbox/advent_of_code/day6/src/resources/input.txt";
    let first_input_line = first_line_from_file(&file_path);
    let input_ages = first_input_line.split(",");
    let mut lantern_fishies: Vec<LanternFish> = Vec::new(); 

    for age in input_ages {
        lantern_fishies.push(LanternFish { days_till_reproduction: FromStr::from_str(age).unwrap() });
    }
    let population_after_80_days: i64 = lantern_fishies_after_days(80, lantern_fishies);
    println!("Challenge 1 - How many Lattern Fish after 80 Days: {:?}", population_after_80_days);
}

fn lantern_fishies_after_days(days: i32, lantern_fishies: Vec<LanternFish>) -> i64 {

    let mut fishy_sum: i64 = 0;
    for i in 0..lantern_fishies.len() {
        fishy_sum+= count_lantern_fish(days, lantern_fishies[i]);
    }    

    return fishy_sum;
}

fn count_lantern_fish(days: i32, mut fish: LanternFish) -> i64  {
    if days < 1 {
        return 1;
    }

    if fish.days_till_reproduction == 0 {
        fish.days_till_reproduction = 6;
        return count_lantern_fish(days-1, fish) + count_lantern_fish(days-1, LanternFish {days_till_reproduction: 8 });
    } 

    let next_day = days - fish.days_till_reproduction;
    fish.days_till_reproduction = 0;
    return count_lantern_fish(next_day, fish);    
}

fn first_line_from_file(file_path: &str) -> String {
    let mut line = String::new();
    if let Ok(file) = File::open(file_path) {
        let reader = BufReader::new(file);
        line = reader.lines().next().unwrap().unwrap();
    }
    return line;
}

#[derive(Clone, Copy, Debug)]
struct LanternFish {
    days_till_reproduction: i32
}