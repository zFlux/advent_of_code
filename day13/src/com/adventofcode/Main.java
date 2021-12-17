package com.adventofcode;

import java.io.InputStream;
import java.util.*;

public class Main {

    public static void main(String[] args) {
        InputStream inputStream = Main.class.getResourceAsStream(args[0]);
        Challenge13 problem1 = new Challenge13(inputStream);
        Challenge13 problem2 = problem1;
        List<List<String>> foldInstructions = problem1.getFoldInstructions();

        // Solution 1
        problem1.processFoldInstruction(foldInstructions.get(0));
        System.out.println("Count of unique dots after one fold: " + problem1.uniqueDotCount());

        //Solution 2
        for (List<String> instruction : foldInstructions) {
            problem2.processFoldInstruction(instruction);
        }
        System.out.print(problem2);
    }
}
