export interface Challenge {
    description: string;
    input_file_name: string;
    input_parser: (line: string, line_number: number) => any;
    first_line_parsed: any;
    challenge_solver: (input: any) => any;
    expected_output: any;
}