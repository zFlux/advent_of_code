require_relative 'day1/challenge_one'
require_relative 'day2/challenge_two'

challenges = [ChallengeOne, ChallengeTwo]

challenges.each_with_index.map do |challenge, index|
    puts ""
    puts challenge.name
    puts "--------------"
    challenge.solutions("day#{index + 1}/input.txt").each_with_index do |solution, index|
        puts "Part #{index + 1}: #{solution}"
    end
end