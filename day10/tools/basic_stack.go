package tools 

type Stack []rune

func (s *Stack) IsEmpty() bool {
	return len(*s) == 0
}

func (s *Stack) Push(char rune) {
	*s = append(*s, char)
}

func (s *Stack) Peek() (rune, bool) {
	if s.IsEmpty() {
		return 0, false
	} else {
		index := len(*s) - 1
		element := (*s)[index]
		return element, true
	}
}

func (s *Stack) Pop() (rune, bool) {
	if s.IsEmpty() {
		return 0, false
	} else {
		index := len(*s) - 1
		element := (*s)[index]
		*s = (*s)[:index]
		return element, true
	}
}
