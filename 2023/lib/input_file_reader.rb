class InputFileReader
    class << self
        def read_file_to_list(file_name)
            file_path = File.join(Dir.pwd, file_name)
            file_lines = []
            File.open(file_path, "r") do |file|
                file.each_line do |line|
                    file_lines << line.chomp
                end
            end
            file_lines
        end
    end
end