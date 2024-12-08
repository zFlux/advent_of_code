import { all_challenges, filter_challenges } from '../challenges/challenges';
import { all_challenge_examples } from '../challenges/challenge_examples';
import { Challenge } from '../types/challenge_types';
import { parseFirstLine, parseInput } from '../utils/input_parser';

// make a list of functions for every function in a namespace
let examples_only: boolean = false;
let todays_challenges_only: boolean = true;

let challenges: Challenge[] = filter_challenges(examples_only, todays_challenges_only, all_challenges, all_challenge_examples);

// iterate from 0 to the number of challenges and execute each
for (let i = 0; i < challenges.length; i++) {
  const challenge = challenges[i];

  // create a context for the test
  describe(`${challenge.description}`, () => {
    test('should parse the first line as expected', () => {
      const firstLine = parseFirstLine(challenge.input_file_directory, challenge.input_file_name, challenge.input_parser);
      expect(firstLine).toEqual(challenge.first_line_parsed);
    });

    test('should return the expected solution', () => {
      const input = parseInput(challenge.input_file_directory, challenge.input_file_name, challenge.input_parser);
      expect(challenge.challenge_solver(input)).toStrictEqual(challenge.expected_output);
    });
  });
};

