require_relative 'day1/challenge_one'
require_relative 'day2/challenge_two'
require_relative 'day3/challenge_three'
require_relative 'day4/challenge_four'

challenges = [ChallengeOne, ChallengeTwo, ChallengeThree, ChallengeFour]

challenges.each_with_index.map do |challenge, index|
    puts ""
    puts challenge.name
    puts "--------------"
    challenge.solutions("day#{index + 1}/input.txt").each_with_index do |solution, index|
        puts "Part #{index + 1}: #{solution}"
    end
end