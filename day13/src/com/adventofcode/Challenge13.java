package com.adventofcode;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.stream.Collectors;

public class Challenge13 {

    List<List<Integer>> listOfCoords = new ArrayList<>();

    public List<List<String>> getFoldInstructions() {
        return foldInstructions;
    }

    List<List<String>> foldInstructions = new ArrayList<>();

    public Challenge13(InputStream inputStream) {
        List<String> inputLines = new BufferedReader(new InputStreamReader(inputStream))
                .lines()
                .collect(Collectors.toList());

        for (String line : inputLines) {
            if (line.contains(",")) {
                String[] coords = line.split(",");
                List<Integer> intCoords = new ArrayList<>();
                intCoords.add(Integer.valueOf(coords[0]));
                intCoords.add(Integer.valueOf(coords[1]));
                listOfCoords.add(intCoords);
            } else if (line.contains("fold")){
                String[] split = line.split("=");
                List<String> instruction = new ArrayList<>();
                instruction.add(split[0].substring(split[0].length()-1));
                instruction.add(split[1]);
                foldInstructions.add(instruction);
            }
        }
    }

    public void processFoldInstruction(List<String> foldInstruction) {
        List<List<Integer>> resultingListOfCoords = new ArrayList<>();

        Integer foldLine = Integer.valueOf(foldInstruction.get(1));
        if (foldInstruction.get(0).equals("y")) {
            for(List<Integer> coords : listOfCoords) {
                List<Integer> resultingCoords = new ArrayList<>();
                Integer y = coords.get(1);
                if (y >= foldLine ) {
                    Integer foldedY = (2 * foldLine) - y;
                    resultingCoords.add(coords.get(0));
                    resultingCoords.add(foldedY);
                } else {
                    resultingCoords.add(coords.get(0));
                    resultingCoords.add(coords.get(1));
                }
                resultingListOfCoords.add(resultingCoords);
            }
        } else {
            for(List<Integer> coords : listOfCoords) {
                List<Integer> resultingCoords = new ArrayList<>();
                Integer x = coords.get(0);
                if (x >= foldLine ) {
                    Integer foldedX = (2 * foldLine) - x;
                    resultingCoords.add(foldedX);
                    resultingCoords.add(coords.get(1));
                } else {
                    resultingCoords.add(coords.get(0));
                    resultingCoords.add(coords.get(1));
                }
                resultingListOfCoords.add(resultingCoords);
            }
        }

        this.listOfCoords = resultingListOfCoords;
    }

    public int uniqueDotCount() {
        HashSet<String> uniqueDots = new HashSet<>();
        for (List<Integer> coords : listOfCoords) {
            uniqueDots.add(coords.get(0) + ", " + coords.get(1));
        }
        return uniqueDots.size();
    }


    @Override
    public String toString() {
        Integer maxX = 0;
        Integer maxY = 0;
        StringBuilder builder = new StringBuilder();
        for (List<Integer> coords : listOfCoords) {
            maxX = Math.max(coords.get(0), maxX);
            maxY = Math.max(coords.get(1), maxY);
        }
        String[][] printableArray = new String[maxY+1][maxX+1];

        for (List<Integer> coords : listOfCoords) {
            printableArray[coords.get(1)][coords.get(0)] = "#";
        }

        for (int i = 0; i < printableArray.length; i++) {
            for (int j = 0; j < printableArray[i].length; j++) {
                if (printableArray[i][j] != null) {
                    builder.append(printableArray[i][j]);
                    builder.append(" ");
                } else {
                    builder.append("  ");
                }
            }
            builder.append("\n");
        }
        return builder.toString();
    }
}
