require 'byebug'
require_relative '../lib/input_file_reader'

class ChallengeNineteen
    class << self
        def solutions(input_file_path)
            input_list = InputFileReader.read_file_to_list(input_file_path)
            workflow_system = WorkflowSystem.new(input_list)
            workflow_system.evaluate_parts
            part1_sum = 0
            workflow_system.accepted_parts.each do |part|
                part1_sum += part.part_hash['x'] + part.part_hash['m'] + part.part_hash['a'] + part.part_hash['s']
            end

            [part1_sum,0]
        end
    end
end

class WorkflowSystem
    attr_reader :workflows, :parts, :accepted_parts, :rejected_parts

    def initialize(input_list)
        @workflows = {}
        @parts = []
        @accepted_parts = []
        @rejected_parts = []

        input_list.each do |line|
            if line[0] == '{'
                @parts << Part.new(line)
            elsif line[0] =~ /[[:alpha:]]/
                workflow = Workflow.new(line)
                @workflows[workflow.name] = workflow
            end
        end
    end

    def evaluate_parts
        @parts.each do |part|
            curr_state = 'in'
            accepted_or_rejected = nil
            while accepted_or_rejected.nil?
                curr_state = @workflows[curr_state].evaluate_part(part)
                accepted_or_rejected = curr_state if curr_state == 'A' || curr_state == 'R'
            end
            if accepted_or_rejected == 'A'
                @accepted_parts << part
            else
                @rejected_parts << part
            end
        end
    end
end

class Workflow
    attr_reader :rules, :name

    def initialize(input_line)
        name, rules = input_line.split('{')
        rules = rules.split('}')[0].split(',')
        @rules = []
        rules.each do |rule|
            @rules << Rule.new(rule)
        end
        @name = name
    end

    def evaluate_part(part)
        @rules.each do |rule|
            if rule.test_operation == '<'
                if part.part_hash[rule.test_part] < rule.test_value
                    return rule.test_state
                end
            elsif rule.test_operation == '>'
                if part.part_hash[rule.test_part] > rule.test_value
                    return rule.test_state
                end
            elsif rule.test_operation == 'true'
                return rule.test_state
            end
        end
    end
end

class Rule
    attr_reader :test_part, :test_value, :test_operation, :test_state

    def initialize(input_rule)
        test_operation, test_state = input_rule.split(':')
        @test_state = test_state
        # split the test opration into the value using < or > as the splitter
        if test_operation.include?('<')
            @test_operation = '<'
        elsif test_operation.include?('>')
            @test_operation = '>'
        else
            @test_operation = 'true'
            @test_state = test_operation
        end

        parts_of_test = test_operation.split(@test_operation)
        @test_part = parts_of_test[0]
        @test_value = parts_of_test[1].to_i
    end
end

class Part 
    attr_reader :part_hash
    
    def initialize(input_part)
        input_part = input_part[1..-2]
        x, m, a, s = input_part.split(',').map{|part| part[2..-1].to_i}
        @part_hash = {'x' => x, 'm' => m, 'a' => a, 's' => s}
    end
end

puts ChallengeNineteen.solutions('input.txt')