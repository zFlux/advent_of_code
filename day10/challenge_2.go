package main

import (
	"bufio"
	"fmt"
	"log"
	"os"
	"sort"
	"tools"
)

var openBracket = map[rune]bool{'{': true, '(': true, '<': true, '[': true}
var matchingClosingBracket = map[rune]rune{'}': '{', ')': '(', '>': '<', ']': '['}
var matchingOpeningBracket = map[rune]rune{'{': '}', '(': ')', '<': '>', '[': ']'}
var bracketValue = map[rune]int{'}': 1197, ')': 3, '>': 25137, ']': 57}
var openBracketValue = map[rune]int{'{': 3, '(': 1, '<': 4, '[': 2}
var incompleteSums []int

func main() {
	fileLines := load_input("input.txt")
	curruptScore := 0
	for _, line := range fileLines {
		isCurrupt, curruptCharacter := check_chuncks(line)
		if isCurrupt {
			curruptScore += bracketValue[curruptCharacter]
		} else {
			incompleteSums = append(incompleteSums, check_incomplete(line))
		}
	}

	midPoint := len(incompleteSums) / 2
	sort.Ints(incompleteSums)
	fmt.Println(incompleteSums[midPoint])
}

func load_input(fileName string) (fileLines []string) {
	file, err := os.Open(fileName)
	if err != nil {
		log.Fatal(err)
	}
	defer file.Close()

	scanner := bufio.NewScanner(file)
	var lines []string
	for scanner.Scan() {
		lines = append(lines, scanner.Text())
	}
	if err := scanner.Err(); err != nil {
		log.Fatal(err)
	}
	return lines
}

func check_incomplete(line string) int {
	var stack tools.Stack
	var incompleteSum = 0
	for _, character := range line {
		if openBracket[character] {
			stack.Push(character)
		} else {
			if peekChar, exists := stack.Peek(); exists {
				if expectedOpeningBracket, exists := matchingClosingBracket[character]; exists {
					if peekChar == expectedOpeningBracket {
						stack.Pop()
					}
				}
			}
		}
	}

	for exists, popChar := true, ' '; exists; popChar, exists = stack.Pop() {
		if exists && popChar != ' ' {
			incompleteSum *= 5
			incompleteSum += openBracketValue[popChar]
		}
	}

	return incompleteSum
}

func check_chuncks(line string) (bool, rune) {
	var stack tools.Stack
	for _, character := range line {
		if openBracket[character] {
			stack.Push(character)
		} else {
			if peekChar, exists := stack.Peek(); exists {
				if expectedOpeningBracket, exists := matchingClosingBracket[character]; exists {
					if peekChar == expectedOpeningBracket {
						stack.Pop()
					} else {
						return true, character
					}

				} else {
					return true, character
				}
			}
		}
	}
	return false, 0
}
