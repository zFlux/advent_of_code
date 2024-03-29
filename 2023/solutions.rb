require_relative 'day1/challenge_one'
require_relative 'day2/challenge_two'
require_relative 'day3/challenge_three'
require_relative 'day4/challenge_four'
require_relative 'day5/challenge_five'
require_relative 'day6/challenge_six'
require_relative 'day7/challenge_seven'
require_relative 'day8/challenge_eight'
require_relative 'day9/challenge_nine'
require_relative 'day10/challenge_ten'
require_relative 'day11/challenge_eleven'
require_relative 'day12/challenge_twelve'
require_relative 'day13/challenge_thirteen'

challenges = [ChallengeOne, ChallengeTwo, ChallengeThree, ChallengeFour, ChallengeFive, 
ChallengeSix, ChallengeSeven, ChallengeEight, ChallengeNine, ChallengeTen, ChallengeEleven, ChallengeTwelve, ChallengeThirteen]

challenges.each_with_index.map do |challenge, index|
    puts ""
    puts challenge.name
    puts "--------------"
    challenge.solutions("day#{index + 1}/input.txt").each_with_index do |solution, index|
        puts "Part #{index + 1}: #{solution}"
    end
end