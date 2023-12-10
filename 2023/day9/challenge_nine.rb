require 'byebug'
require_relative '../lib/input_file_reader'

class ChallengeNine
    class << self
        def solutions(input_file_path)
            input_list = InputFileReader.read_file_to_list(input_file_path)
            instability_reports = []
            input_list.map do |input|
                # split the input into a list of integers
                report = input.split(' ').map(&:to_i)
                # create a new instability report
                instability_reports << InstabilityReport.new(report)
            end
            instability_reports

            next_values = []
            instability_reports.each do |instability_report|
                next_values << instability_report.predict_next_value
            end
            part_1 = next_values.sum

            prior_values = []
            instability_reports.each do |instability_report|
                prior_values << instability_report.predict_prior_value
            end
            part_2 = prior_values.sum
            
            [part_1, part_2]
        end
    end
end

class InstabilityReport
    attr_reader :report, :prediction_lists

    def initialize(report)
        @report = report
        initialize_prediction_lists
    end

    def predict_next_value
        # iterate backwards through the prediction lists
        last_value = 0

        # iteration list from i = length to 1
        (@prediction_lists.length - 1).downto(1) do |i|
            # take the last value of the current prediction list
            last_value = @prediction_lists[i].last
            # if its zero add it to the current prediction list
            if i == @prediction_lists.length - 1
                @prediction_lists[i] << last_value
            # otherwise add the computed value to the prior list
            else
                # otherwise add the last value to the last value of the next prediction list
                @prediction_lists[i-1] << last_value + @prediction_lists[i-1].last
                last_value = @prediction_lists[i-1].last
            end 
        end
        last_value
    end

    def predict_prior_value

        first_value = 0

        # iteration list from i = length to 1
        (@prediction_lists.length - 1).downto(1) do |i|
            # take the first value of the current prediction list
            first_value = @prediction_lists[i].first
            # if its zero add it to the current prediction list
            if i == @prediction_lists.length - 1
                # add to the beginning of the list
                @prediction_lists[i].unshift(first_value)
            else
                # otherwise add the first value to the first value of the next prediction list
                @prediction_lists[i-1].unshift(@prediction_lists[i-1].first - first_value)
                first_value = @prediction_lists[i-1].first
            end 
        end
        first_value
    end

    def initialize_prediction_lists
        # for the report list of integers find the difference between report[1] - report[0], report[2] - report[1]
        # and so on and put these differences in a list
        @prediction_lists = []
        next_prediction_list = @report
        @prediction_lists << @report
        next_prediction_all_zeros = false
        while !next_prediction_all_zeros do
            working_list = []
            next_prediction_list.each_with_index do |num, index|
                next if index == 0
                working_list << num - next_prediction_list[index - 1]
            end
            @prediction_lists << working_list
            next_prediction_list = working_list
            # if the next prediction list is all zeros then we are done
            next_prediction_all_zeros = next_prediction_list.all? { |prediction| prediction == 0 }
        end
    end
end