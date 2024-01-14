require 'byebug'
require 'multi_range'
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

            part2_sum = workflow_system.evaluate_part_range(1, 4000)

            [part1_sum, part2_sum]
        end
    end
end

class WorkflowSystem
    attr_reader :workflows, :parts, :accepted_parts, :rejected_parts, :accepted_part_ranges, :rejected_part_ranges

    def initialize(input_list)
        @workflows = {}
        @parts = []
        @accepted_parts = []
        @rejected_parts = []
        @accepted_part_ranges = []
        @rejected_part_ranges = []

        input_list.each do |line|
            if line[0] == '{'
                @parts << Part.new({input_part: line})
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

    def evaluate_part_range(start_range, end_range)
        curr_state = 'in'
        part_range = Part.new([start_range..end_range], true)
        part_ranges_and_states = [{ :part_range => part_range, :curr_state => curr_state }]

        while part_ranges_and_states.length > 0
            curr_range_and_state = part_ranges_and_states.pop
            curr_state = curr_range_and_state[:curr_state]
            curr_range = curr_range_and_state[:part_range]

            @accepted_part_ranges << curr_range && next if curr_state == 'A'
            @rejected_part_ranges << curr_range && next if curr_state == 'R'
            
            result = @workflows[curr_state].evaluate_part_range(curr_range)
            part_ranges_and_states += result
        end
        
        val = 0
        @accepted_part_ranges.each do |part_range|
            val += part_range.part_hash['x'].ranges[0].size * part_range.part_hash['m'].ranges[0].size * part_range.part_hash['a'].ranges[0].size * part_range.part_hash['s'].ranges[0].size
        end
        val
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

    def evaluate_part_range(part_range)
        curr_part_range = part_range
        result = []
        @rules.each do |rule|
            if rule.test_operation == '<'
                curr_begin = curr_part_range.part_hash[rule.test_part].ranges[0].begin
                curr_end = curr_part_range.part_hash[rule.test_part].ranges[0].end
                # if the range has something less than the test value then map it
                if  curr_begin < rule.test_value
                    new_part_start =  curr_begin
                    new_part_end = [curr_end, rule.test_value - 1].min
                    new_part = curr_part_range.clone
                    new_part.part_hash[rule.test_part] = MultiRange.new([new_part_start..new_part_end])
                    result << { :part_range => new_part, :curr_state => rule.test_state }
                    return result if new_part_end == curr_end
                    curr_part_range.part_hash[rule.test_part] = MultiRange.new([(new_part_end + 1)..curr_end])
                end
            elsif rule.test_operation == '>'
                curr_begin = curr_part_range.part_hash[rule.test_part].ranges[0].begin
                curr_end = curr_part_range.part_hash[rule.test_part].ranges[0].end
                # if the range has something greater than the test value then map it
                if curr_end > rule.test_value
                    new_part_start = [curr_begin, rule.test_value + 1].max
                    new_part_end = curr_end
                    new_part = curr_part_range.clone
                    new_part.part_hash[rule.test_part] = MultiRange.new([new_part_start..new_part_end])
                    result << { :part_range => new_part, :curr_state => rule.test_state }
                    return result if new_part_start == curr_begin
                    curr_part_range.part_hash[rule.test_part] = MultiRange.new([curr_begin..(new_part_start - 1)])
                end
            elsif rule.test_operation == 'true'
                result << { :part_range => curr_part_range, :curr_state => rule.test_state }
                return result
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
    
    def initialize(args, is_range = false)
        if is_range
            x, m, a, s = [MultiRange.new(args),MultiRange.new(args),MultiRange.new(args),MultiRange.new(args)]
        else 
            input_part = args[:input_part]
            input_part = input_part[1..-2]
            x, m, a, s = input_part.split(',').map{|part| part[2..-1].to_i}
        end
        @part_hash = {'x' => x, 'm' => m, 'a' => a, 's' => s}
    end

    def clone
        x = Part.new([1..4000], true)
        x.part_hash['x'] = @part_hash['x'].clone
        x.part_hash['m'] = @part_hash['m'].clone
        x.part_hash['a'] = @part_hash['a'].clone
        x.part_hash['s'] = @part_hash['s'].clone
        x
    end
end

puts ChallengeNineteen.solutions('input.txt')