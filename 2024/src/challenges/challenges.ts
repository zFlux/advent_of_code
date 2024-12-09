import { Challenge } from '../types/challenge_types';

import { challenge_1, challenge_1_2 } from './day_1';
import { challenge_2, challenge_2_2 } from './day_2';
import { challenge_3, challenge_3_2 } from './day_3';
import { challenge_4, challenge_4_2 } from './day_4';
import { challenge_5, challenge_5_2 } from './day_5';
import { challenge_6, challenge_6_2 } from './day_6';
import { challenge_7, challenge_7_2 } from './day_7';
import { challenge_8, challenge_8_2 } from './day_8';

export const all_challenges: Challenge[] = 
    [challenge_1, challenge_1_2, 
    challenge_2, challenge_2_2, 
    challenge_3, challenge_3_2, 
    challenge_4, challenge_4_2, 
    challenge_5, challenge_5_2, 
    challenge_6, challenge_6_2, 
    challenge_7, challenge_7_2,
    challenge_8, challenge_8_2];


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
    



