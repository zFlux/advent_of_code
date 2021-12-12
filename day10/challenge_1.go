package main

import (
	"bufio"
	"fmt"
	"log"
	"os"
	"tools"
)

var openBracket = map[rune]bool{'{': true, '(': true, '<': true, '[': true}
var matchingBracket = map[rune]rune{'}': '{', ')': '(', '>': '<', ']': '['}
var bracketValue = map[rune]int{'}': 1197, ')': 3, '>': 25137, ']': 57}

func main() {

	fileLines := load_input("input.txt")
	curruptScore := 0
	for _, line := range fileLines {
		isCurrupt, curruptCharacter := check_chucks(line)
		if isCurrupt {
			curruptScore += bracketValue[curruptCharacter]
		}
	}
	fmt.Println(curruptScore)

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

func check_chucks(line string) (bool, rune) {
	var stack tools.Stack
	for _, character := range line {
		if openBracket[character] {
			stack.Push(character)
		} else {
			if peekChar, exists := stack.Peek(); exists {
				if expectedOpeningBracket, exists := matchingBracket[character]; exists {
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
