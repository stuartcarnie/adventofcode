package main

import (
	"bufio"
	"fmt"
	"os"
)

func main() {
	s := bufio.NewScanner(os.Stdin)
	for s.Scan() {
		sum := Process(s.Bytes())
		fmt.Println(sum)
	}
}

func Process(s []byte) int {
	if len(s) < 2 {
		return 0
	}

	s = append(s, s[0])

	sum := 0
	for i := 1; i < len(s); i++ {
		if s[i-1] == s[i] {
			sum += int(s[i] - '0')
		}
	}
	return sum
}
