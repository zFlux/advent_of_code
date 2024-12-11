import { Challenge } from '../types/challenge_types';

import * as Day1 from './day_1';
import * as Day2 from './day_2';
import * as Day3 from './day_3';
import * as Day4 from './day_4';
import * as Day5 from './day_5';
import * as Day6 from './day_6';
import * as Day7 from './day_7';
import * as Day8 from './day_8';
import * as Day9 from './day_9';

const module_list = [Day1, Day2, Day3, Day4, Day5, Day6, Day7, Day8, Day9];

const LOAD_EXAMPLE_FUNCTIONS_THAT_END_WITH = '_example';
// create a regex that matches challenge_##_## where the second _## is not necessary
const LOAD_CHALLENGE_FUNCTIONS_THAT_LOOK_LIKE = /challenge_\d{1,2}(?:_\d{1,2})?/;

let challenge_examples: Challenge[] = [];
let challenges: Challenge[] = [];
module_list.forEach((module) => {
    Object.entries(module).forEach(([name, func]) => {
        if (name.endsWith(LOAD_EXAMPLE_FUNCTIONS_THAT_END_WITH) && typeof func === 'object') {
            challenge_examples.push(func);
        } else if (LOAD_CHALLENGE_FUNCTIONS_THAT_LOOK_LIKE.test(name) && typeof func === 'object') {
            challenges.push(func);
        }
    });
});

export const filter_challenges = (examples_only: boolean, todays_challenges_only: boolean, all_challenges: Challenge[], all_challenge_examples: Challenge[]): Challenge[] => {
    let challenges: Challenge[] = [];

    if (examples_only) {
        challenges = all_challenge_examples;
    } else {
        challenges = all_challenge_examples.concat(all_challenges);
    }

    if (todays_challenges_only) {
        // search all the challenges and grab all the input file directories, pull off the number appearing at the
        // end of the directory name, and return the challenges having a directory "day##" where ## is the highest number
        // in the directories
        let highest_day = 0;
        challenges.forEach((challenge) => {
            const day = parseInt(challenge.input_file_directory.replace('day', ''));
            if (day > highest_day) {
                highest_day = day;
            }
        });

        challenges = challenges.filter((challenge) => {
            const day = parseInt(challenge.input_file_directory.replace('day', ''));
            return day === highest_day;
        });
     }

        return challenges;
};

export const all_challenge_examples: Challenge[] = challenge_examples;
export const all_challenges: Challenge[] = challenges;





