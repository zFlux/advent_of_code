require 'minitest/autorun'
require_relative 'challenge_five'

class ChallengeFive_Objects < Minitest::Test
    def test_map_range_when_input_range_is_contained
        # source points 0-4 maps to 10-14
        map_range = MapRange.new([10,0,5])

        # resource points 0-4
        resource_range = ResourceRange.new([0,5])

        result = map_range.map_range(resource_range)
        mapped = result[:mapped]
        unmapped = result[:unmapped]

        assert_equal(1, mapped.length)
        assert_equal(0, unmapped.length)
        assert_equal([10,5], [mapped[0].range_start, mapped[0].range_length])
    end

    def test_map_range_when_map_range_is_contained
        # source points 5-9 maps to 20-24
        map_range = MapRange.new([20,5,5])
        # resource points 0-14
        resource_range = ResourceRange.new([0,15])
        result = map_range.map_range(resource_range)
        mapped = result[:mapped]
        unmapped = result[:unmapped]

        # expected ranges are 0-4, 20-24 (because it mapped), 10-14
        assert_equal(1, mapped.length)
        assert_equal(2, unmapped.length)
        assert_equal([0,5], [unmapped[0].range_start, unmapped[0].range_length])
        assert_equal([10,5], [unmapped[1].range_start, unmapped[1].range_length])
        assert_equal([20,5], [mapped[0].range_start, mapped[0].range_length])
    end

    def test_map_range_when_input_range_starts_before_map_range
        # source points 5-9 maps to 20-24
        map_range = MapRange.new([20,5,5])

        # resource points 0-8
        resource_range = ResourceRange.new([0,9])

        result = map_range.map_range(resource_range)
        mapped = result[:mapped]
        unmapped = result[:unmapped]

        # expected ranges are 0-4, 20-23 (because it mapped)
        assert_equal(1, mapped.length)
        assert_equal(1, unmapped.length)
        assert_equal([0,5], [unmapped[0].range_start, unmapped[0].range_length])
        assert_equal([20,4], [mapped[0].range_start, mapped[0].range_length])
    end

    def test_map_range_when_input_range_begins_in_and_ends_after_map_range
        # source points 5-9 maps to 20-24
        map_range = MapRange.new([20,5,5])

        # resource points 6-17
        resource_range = ResourceRange.new([6,12])

        result = map_range.map_range(resource_range)
        mapped = result[:mapped]
        unmapped = result[:unmapped]

        # expected ranges are 21-24 (because it mapped) and 10-17
        assert_equal(1, mapped.length)
        assert_equal(1, unmapped.length)
        assert_equal([21,4], [mapped[0].range_start, mapped[0].range_length])
        assert_equal([10,8], [unmapped[0].range_start, unmapped[0].range_length])
    end

    def test_map_range_when_input_range_begins_in_and_ends_after_map_range_2
        # source points 0-4 maps to 10-14
        map_range = MapRange.new([10,0,5])

        # resource points 0-6
        resource_range = ResourceRange.new([0,7])

        result = map_range.map_range(resource_range)
        mapped = result[:mapped]
        unmapped = result[:unmapped]

        # expected ranges are 10-14 (because it mapped) and 5-6 because it didn't
        assert_equal(1, mapped.length)
        assert_equal(1, unmapped.length)
        assert_equal([10,5], [mapped[0].range_start, mapped[0].range_length])
        assert_equal([5,2], [unmapped[0].range_start, unmapped[0].range_length])
    end

    def test_map_range_when_input_range_has_no_overlap_with_map_range
        # source points 5-9 maps to 20-24
        map_range = MapRange.new([20,5,5])

        # resource points 20-24
        resource_range = ResourceRange.new([20,5])

        result = map_range.map_range(resource_range)
        mapped = result[:mapped]
        unmapped = result[:unmapped]

        # expected range are 20-24
        assert_equal(1, unmapped.length)
        assert_equal([20,5], [unmapped[0].range_start, unmapped[0].range_length])
    end

    class ResourceMapTest < Minitest::Test
        def setup
            @resource_map_ranges = [
                # source points 6-9 map to 20-23
                MapRange.new([20,6,4]),
                # source points 0-4 map to 10-14
                MapRange.new([10,0,5])
            ]
            @resource_map = ResourceMap.new('Test Map', @resource_map_ranges)
        end

        def test_map_source_resource_for_full_range
            resource_range_list = ResourceRangeList.new([0,12])
            # expect [10,5] (0-4), [5,1] (5), [20,4] (6-9), [10,2] (10-11)
            result = @resource_map.map_source_resource_ranges_to_dest_ranges(resource_range_list.resource_ranges)
            assert_equal(4, result.length)
            # assert that the result contains the list [20,4] somewhere inside
            assert(result.any? {|range| range.range_start == 10 && range.range_length == 5})
            assert(result.any? {|range| range.range_start == 5 && range.range_length == 1})
            assert(result.any? {|range| range.range_start == 20 && range.range_length == 4})
            assert(result.any? {|range| range.range_start == 10 && range.range_length == 2})
        end

        def test_map_source_resource_for_full_range_2
            resource_range_list = ResourceRangeList.new([0,12,30,14])
            # expect [10,5] (0-4), [5,1] (5), [20,4] (6-9), [10,2] (10-11)
            result = @resource_map.map_source_resource_ranges_to_dest_ranges(resource_range_list.resource_ranges)
            byebug
        end
    end
end
