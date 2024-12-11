import * as Day1 from "./day_1";
import * as Day2 from "./day_2";
import * as Day3 from "./day_3";
import * as Day4 from "./day_4";
import * as Day5 from "./day_5";
import * as Day6 from "./day_6";
import * as Day7 from "./day_7";
import * as Day8 from "./day_8";
import * as Day9 from "./day_9";

const module_list = [Day1, Day2, Day3, Day4, Day5, Day6, Day7, Day8, Day9];

let solvers: { [key: string]: (input: any) => any } = {};

// loop through all the modules and export all functions
module_list.forEach((module) => {
    Object.entries(module).forEach(([name, func]) => {
        if (typeof func === 'function') {
            solvers[name] = func;
        }
    });
});

export default solvers;













