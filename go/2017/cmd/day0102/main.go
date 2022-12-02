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

	h := len(s) / 2
	s = append(s, s...)

	sum := 0
	for i := 0; i < len(s)/2; i++ {
		if s[i] == s[i+h] {
			sum += int(s[i] - '0')
		}
	}
	return sum
}
