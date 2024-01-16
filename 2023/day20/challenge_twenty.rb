require 'byebug'
require_relative '../lib/input_file_reader'

class ChallengeTwenty
    class << self
        def solutions(input_file_path)
            input_list = InputFileReader.read_file_to_list(input_file_path)
            machine_room = MachineRoom.new(input_list)
            machine_room.press_button_times(1000)
            part1 = machine_room.pulse_counts[true] * machine_room.pulse_counts[false]

            [part1, 0]
        end
    end
end

class MachineRoom
    attr_reader :modules, :stack, :inputs, :pulse_counts, :min_button_presses

    def initialize(input_list)
        @inputs = {}
        @modules = {}
        input_list.each do |input|
            mod = PulseModule.new(input, @inputs)
            @modules[mod.id] = mod
        end
        @stack = []
        @pulse_counts = {PulseModule::LOW_PULSE => 0, PulseModule::HIGH_PULSE => 0}
        @min_button_presses = 0

    end

    def press_button_times(times)
        times.times do 
            press_button
        end
    end

    def press_button
        @stack.push([nil, PulseModule::BROADCASTER, PulseModule::LOW_PULSE])

        while !@stack.empty?
            curr_instr = @stack.pop
            next_mod = @modules[curr_instr[1]]
            next_mod.recieve_pulse(curr_instr[0], curr_instr[2], @stack) if next_mod
            @pulse_counts[curr_instr[2]]+=1 
        end
    end

end

class PulseModule
    attr_reader :type, :id, :destinations, :state, :inputs

    FLIP_FLOP = '%'
    CONJUNCTION = '&'
    BROADCASTER = 'broadcaster'

    LOW_PULSE = false
    HIGH_PULSE = true

    ON = true 
    OFF = false

    def recieve_pulse(id, pulse, stack)
        next_pulse = nil
        if @type == FLIP_FLOP && pulse == LOW_PULSE
            @state = !@state
            next_pulse = @state.dup
            send_pulse(next_pulse, stack)
        elsif @type == CONJUNCTION
            @state[id] = pulse.dup
            result = HIGH_PULSE
            @state.keys.each do |key|
                result = result && @state[key] == HIGH_PULSE
            end
            next_pulse = result == HIGH_PULSE ? LOW_PULSE : HIGH_PULSE
            send_pulse(next_pulse, stack)
        elsif @type == BROADCASTER
            send_pulse(pulse, stack)
        end
    end

    def initialize(input, inputs)
        module_text, dest_text = input.split('->')
        @destinations = dest_text.split(',').map(&:strip)
        parse_type_and_id(module_text)
        @destinations.each do |dest|
            if !inputs[dest] 
                inputs[dest] = []
            end
            inputs[dest].push(@id)
        end
        @inputs = inputs[@id]
        setup_state
    end

    #debug functions
    def to_s
        @type == BROADCASTER ? "#{@id} -> #{@destinations}" : "#{@type}#{@id} -> #{@destinations}"
    end

    def inspect
        to_s
    end

    private 

        def setup_state
            if @type == FLIP_FLOP
                @state = OFF
            elsif @type == CONJUNCTION
                @state = {}
                @inputs = [] if !@inputs
                @inputs.each do |input|
                    @state[input] = OFF
                end
            end
        end

        def parse_type_and_id(module_text)
            module_text = module_text.strip
            if module_text[0] == FLIP_FLOP
                @type = FLIP_FLOP
                @id = module_text[1..-1]
            elsif module_text[0] == CONJUNCTION
                @type = CONJUNCTION
                @id = module_text[1..-1]
            else
                @type = BROADCASTER
                @id = module_text
            end
        end

        def send_pulse(pulse, stack)
            @destinations.each do |dest|
                #puts "#{@id} sends #{pulse} to #{dest}"
                stack.unshift([@id, dest, pulse])
            end
        end
end

puts ChallengeTwenty.solutions('input.txt')