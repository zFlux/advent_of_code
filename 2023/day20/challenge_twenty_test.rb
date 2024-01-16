require 'minitest/autorun'
require_relative 'challenge_twenty'

class ChallengeTwenty_Objects < Minitest::Test

    def setup
        input_list = InputFileReader.read_file_to_list('input_test_part1.txt')
        @machine_room = MachineRoom.new(input_list)
    end

    # def test_broadcast_module
    #     mod = @machine_room.modules['broadcaster']
    #     mod.recieve_pulse(nil, true, @machine_room.stack)
    #     stack = @machine_room.stack

    #     assert stack != nil
    #     assert stack.pop == ["a", true]
    #     assert stack.pop == ["b", true]
    #     assert stack.pop == ["c", true]
    # end
    
    # def test_flip_flop_module_does_nothing_on_high_pulse
    #     mod = @machine_room.modules['a']
    #     stack = @machine_room.stack

    #     assert stack.empty?
    #     assert mod.state == false

    #     mod.recieve_pulse(nil, true, @machine_room.stack)
    #     assert stack.empty?
    #     assert mod.state == false
    # end

    # def test_flip_flop_module_flips_on_low_pulse
    #     mod = @machine_room.modules['a']
    #     stack = @machine_room.stack

    #     assert stack.empty?
    #     assert mod.state == false

    #     mod.recieve_pulse(nil, false, @machine_room.stack)
    #     assert stack.pop == ["b", true]
    #     assert mod.state == true

    #     mod.recieve_pulse(nil, false, @machine_room.stack)
    #     assert stack.pop == ["b", false]
    #     assert mod.state == false
    # end

    # def test_conjunction_module_sends_high_pulse_if_remembers_no_high_pulses
    #     mod = @machine_room.modules['inv']
    #     stack = @machine_room.stack

    #     mod.recieve_pulse("a", true, @machine_room.stack)
    #     assert stack.pop == ["a", true]
    #     assert mod.state["c"] == false

    #     mod.recieve_pulse("c", true, @machine_room.stack)
    #     assert stack.pop == ["a", false]
    #     assert mod.state["c"] == true
    # end

    def test_press_button
        @machine_room.press_button
        byebug
    end

end