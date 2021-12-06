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
    let population_after_80_days = lantern_fishies_after_days(80, lantern_fishies);

    println!("Challenge 1 - How many Lattern Fish after 80 Days: {:?}", population_after_80_days);
}

fn lantern_fishies_after_days(days: i32, mut lantern_fishies: Vec<LanternFish>) -> usize {

    let mut lantern_fishy_children: Vec<LanternFish> = Vec::new(); 
    for _day in 0..days {
        for i in 0..lantern_fishies.len() {
            let child = lantern_fishies[i].age_by_a_day();
      
            if child.is_some() {
                child.map(|c| lantern_fishy_children.push(c));
            }
        }
        lantern_fishies.append(&mut lantern_fishy_children);
    }

    return lantern_fishies.len();
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

trait Aging {
    fn age_by_a_day(&mut self) -> Option<LanternFish>;
}

impl Aging for LanternFish {
    fn age_by_a_day(&mut self) -> Option<LanternFish> {
        self.days_till_reproduction-=1;
        if self.days_till_reproduction == -1 {
            self.days_till_reproduction = 6;
            return Some(LanternFish { days_till_reproduction: 8 });
        }
        return None
    }
}