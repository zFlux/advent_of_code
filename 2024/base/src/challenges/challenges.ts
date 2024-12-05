import { Challenge } from '../types/challenge_types';
import * as Parsers from '../parsers/parsers';
import * as Solvers from '../solvers/solvers';  

export const challenge_1: Challenge = {
    description: "Day 1 Challenge: Sum of the absolute difference of two sorted lists of numbers",
    input_file_name: '1_input.txt',
    input_parser: Parsers.challenge_1,
    first_line_parsed: [98415, 86712],
    challenge_solver: Solvers.challenge_1,
    expected_output: 2192892
};

export const challenge_1_2: Challenge = {
    description: "Day 1 Part 2 Challenge: multiply each number in left list by number of occurences in right list and sum",
    input_file_name: '1_input.txt',
    input_parser: Parsers.challenge_1,
    first_line_parsed: [98415, 86712],
    challenge_solver: Solvers.challenge_1_2,
    expected_output: 22962826
};

export const challenge_2: Challenge = {
    description: "Day 2 Challenge: Check that the lists validate as 'safe'",
    input_file_name: '2_input.txt',
    input_parser: Parsers.challenge_2,
    first_line_parsed: [16, 18, 20, 22, 23, 22],
    challenge_solver: Solvers.challenge_2,
    expected_output: 606
};

export const challenge_2_2: Challenge = {
    description: "Day 2 Part 2 Challenge: Check that the lists validate as 'safe' with a bit more effort",
    input_file_name: '2_input.txt',
    input_parser: Parsers.challenge_2,
    first_line_parsed: [16, 18, 20, 22, 23, 22],
    challenge_solver: Solvers.challenge_2_2,
    expected_output: 644
};

export const challenge_3: Challenge = {
    description: "Day 3 Challenge: parse a string with instructions and execute the instructions",
    input_file_name: '3_input.txt',
    input_parser: Parsers.challenge_3,
    first_line_parsed: ["mul(498,303)","mul(846,233)","mul(334,117)","mul(886,213)","mul(343,197)","mul(33,616)","mul(757,847)","mul(927,553)","mul(589,387)","mul(865,934)","mul(804,792)","mul(620,348)","mul(584,827)","mul(381,633)","mul(643,715)","mul(465,37)","mul(742,669)","mul(519,650)","mul(546,337)","mul(769,202)","mul(808,254)","mul(71,204)","mul(150,335)","mul(302,220)","mul(385,231)","mul(852,324)","mul(838,178)","mul(579,121)","mul(810,214)","mul(273,606)","mul(788,896)","mul(568,713)","mul(404,402)","mul(931,692)","mul(815,388)","mul(492,448)","mul(962,335)","mul(390,36)","mul(984,787)","mul(209,744)","mul(929,15)","mul(751,670)","mul(821,742)","mul(445,950)","mul(174,953)","mul(529,661)","mul(513,442)","mul(941,152)","mul(468,787)","mul(497,717)","mul(930,672)","mul(313,480)","mul(407,85)","mul(776,808)","mul(373,713)","mul(420,163)","mul(666,491)","mul(823,835)","mul(728,808)","mul(38,577)","mul(985,224)","mul(31,270)","mul(233,598)","mul(326,395)","mul(730,832)","mul(628,729)","mul(332,18)","mul(908,439)","mul(185,715)","mul(895,903)","mul(367,623)","mul(362,189)","mul(571,203)","mul(615,719)","mul(663,163)","mul(93,614)","mul(490,261)","mul(530,933)","mul(134,307)","mul(657,957)","mul(969,590)","mul(534,951)","mul(573,576)","mul(810,772)","mul(334,140)","mul(36,336)","mul(894,946)","mul(633,59)","mul(335,809)","mul(654,481)","mul(17,334)","mul(886,695)","mul(954,476)","mul(73,181)","mul(326,125)","mul(945,965)","mul(346,328)","mul(603,626)","mul(527,536)","mul(914,232)","mul(116,640)","mul(44,854)","mul(919,687)","mul(70,882)","mul(96,388)","mul(240,319)","mul(524,524)","mul(124,571)","mul(727,591)","mul(481,435)","mul(245,145)","mul(943,836)","mul(703,555)","mul(923,88)","mul(908,970)","mul(199,227)","mul(540,629)","mul(167,775)","mul(275,320)","mul(911,818)","mul(368,63)"],
    challenge_solver: Solvers.challenge_3,
    expected_output: 189600467
};

export const challenge_3_2: Challenge = {
    description: "Day 3 Part 2 Challenge: parse a string with instructions and execute the instructions (with additional do / don't instructions)",
    input_file_name: '3_input.txt',
    input_parser: Parsers.challenge_3_2,
    first_line_parsed: ["mul(498,303)","mul(846,233)","mul(334,117)","mul(886,213)","mul(343,197)","mul(33,616)","mul(757,847)","mul(927,553)","mul(589,387)","mul(865,934)","mul(804,792)","mul(620,348)","mul(584,827)","mul(381,633)","do()","mul(643,715)","mul(465,37)","mul(742,669)","mul(519,650)","mul(546,337)","mul(769,202)","mul(808,254)","mul(71,204)","mul(150,335)","mul(302,220)","don't()","mul(385,231)","mul(852,324)","mul(838,178)","mul(579,121)","mul(810,214)","don't()","mul(273,606)","mul(788,896)","don't()","mul(568,713)","mul(404,402)","mul(931,692)","mul(815,388)","mul(492,448)","mul(962,335)","mul(390,36)","mul(984,787)","mul(209,744)","mul(929,15)","mul(751,670)","mul(821,742)","mul(445,950)","mul(174,953)","mul(529,661)","mul(513,442)","mul(941,152)","mul(468,787)","mul(497,717)","mul(930,672)","mul(313,480)","mul(407,85)","mul(776,808)","mul(373,713)","mul(420,163)","mul(666,491)","do()","mul(823,835)","mul(728,808)","mul(38,577)","mul(985,224)","mul(31,270)","mul(233,598)","mul(326,395)","don't()","mul(730,832)","mul(628,729)","mul(332,18)","mul(908,439)","mul(185,715)","mul(895,903)","mul(367,623)","mul(362,189)","mul(571,203)","mul(615,719)","mul(663,163)","mul(93,614)","mul(490,261)","mul(530,933)","don't()","mul(134,307)","mul(657,957)","mul(969,590)","mul(534,951)","mul(573,576)","mul(810,772)","mul(334,140)","mul(36,336)","don't()","mul(894,946)","mul(633,59)","mul(335,809)","mul(654,481)","mul(17,334)","mul(886,695)","mul(954,476)","mul(73,181)","mul(326,125)","mul(945,965)","mul(346,328)","mul(603,626)","mul(527,536)","do()","mul(914,232)","mul(116,640)","mul(44,854)","mul(919,687)","mul(70,882)","mul(96,388)","mul(240,319)","mul(524,524)","mul(124,571)","mul(727,591)","mul(481,435)","mul(245,145)","mul(943,836)","mul(703,555)","mul(923,88)","mul(908,970)","don't()","mul(199,227)","mul(540,629)","mul(167,775)","mul(275,320)","mul(911,818)","mul(368,63)"],
    challenge_solver: Solvers.challenge_3_2,
    expected_output: 107069718
};

export const challenge_4: Challenge = {
    description: "Day 4 Challenge: find how many times xmas appears in any direction on a grid",
    input_file_name: '4_input.txt',
    input_parser: Parsers.challenge_4,
    first_line_parsed: ["S","S","S","M","M","S","A","M","X","S","S","S","S","S","S","M","S","S","S","S","M","A","M","S","M","M","S","M","S","M","X","S","A","S","M","M","M","M","A","M","X","A","X","M","A","X","X","S","S","M","S","S","S","M","S","M","M","S","X","M","A","X","X","M","A","X","S","A","M","X","M","X","M","A","X","X","M","A","A","M","M","M","M","M","A","A","S","X","M","S","A","M","X","M","A","S","M","M","S","M","S","M","S","X","X","M","S","M","S","X","A","X","M","S","M","M","S","X","A","S","X","S","M","M","S","M","M","X","M","M","M","M","X","M","X","A","M","M","S","X"],
    challenge_solver: Solvers.challenge_4,
    expected_output: 2427
};

export const challenge_4_2: Challenge = {
    description: "Day 4 Part 2 Challenge: find how many times the word mas appears in an x on a grid",
    input_file_name: '4_input.txt',
    input_parser: Parsers.challenge_4,
    first_line_parsed: ["S","S","S","M","M","S","A","M","X","S","S","S","S","S","S","M","S","S","S","S","M","A","M","S","M","M","S","M","S","M","X","S","A","S","M","M","M","M","A","M","X","A","X","M","A","X","X","S","S","M","S","S","S","M","S","M","M","S","X","M","A","X","X","M","A","X","S","A","M","X","M","X","M","A","X","X","M","A","A","M","M","M","M","M","A","A","S","X","M","S","A","M","X","M","A","S","M","M","S","M","S","M","S","X","X","M","S","M","S","X","A","X","M","S","M","M","S","X","A","S","X","S","M","M","S","M","M","X","M","M","M","M","X","M","X","A","M","M","S","X"],
    challenge_solver: Solvers.challenge_4_2,
    expected_output: 1900
};
