export interface Challenge {
    description: string;
    input_file_directory: string;
    input_file_name: string;
    input_parser: (line: string) => any;
    first_line_parsed: any;
    challenge_solver: (input: any) => any;
    expected_output: any;
}

export type Space = {
    id: number;
    size: number;
    position: number;
};

export type File = {
    id: number;
    size: number;
    position: number;
};