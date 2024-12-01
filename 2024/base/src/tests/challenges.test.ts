import * as AOC_Challenges from '../challenges/challenges';
import * as AOC_Challenge_Examples from '../challenges/challenge_examples';
import { Challenge } from '../types/challenge_types';
import { parseFirstLine, parseInput } from '../utils/input_parser';

// make a list of functions for every function in a namespace
let examples_only: boolean = false;
let challenges: Challenge[] = convertChallengesModuleToList(examples_only);

// iterate from 0 to the number of challenges and execute each
for (let i = 0; i < challenges.length; i++) {
  const challenge = challenges[i];

  // create a context for the test
  describe(`${challenge.description}`, () => {
    test('should parse the first line as expected', () => {
      const firstLine = parseFirstLine(challenge.input_file_name, challenge.input_parser);
      expect(firstLine).toEqual(challenge.first_line_parsed);
    });

    test('should return the expected solution', () => {
      const input = parseInput(challenge.input_file_name, challenge.input_parser);
      expect(challenge.challenge_solver(input)).toStrictEqual(challenge.expected_output);
    });
  });
}

function convertChallengesModuleToList(examples_only: boolean): Challenge[] {
  const challenges: Challenge[] = [];

  // Put all the examples first
  for (const challenge in AOC_Challenge_Examples) {
    const property = (AOC_Challenge_Examples as Record<string, any>)[challenge];
    if (typeof property === 'object') {
      challenges.push(property);
    }
  }
  
  // Add in all the actual challenges if we're not just looking for examples
  if (!examples_only) {
    for (const challenge in AOC_Challenges) {
      const property = (AOC_Challenges as Record<string, any>)[challenge];
      if (typeof property === 'object') {
        challenges.push(property);
      }
    }
  }

  return challenges;
}



