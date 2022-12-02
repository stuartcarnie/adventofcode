package main

import (
	"bytes"
	"fmt"
	"os"
)

func lookSay(s string) string {
	b := bytes.NewBufferString("")
	j := 1
	for i := 0; i < len(s); i += j {
		ch := s[i]
		for j = 1; i+j < len(s) && s[i+j] == ch; j++ {
		}

		fmt.Fprintf(b, "%d%s", j, string(ch))
	}

	return b.String()
}

func main() {
	if len(os.Args) != 2 {
		fmt.Printf("must specify input")
		os.Exit(1)
	}

	s := os.Args[1]

	for i := 0; i < 50; i++ {
		s = lookSay(s)
	}

	fmt.Println(s)
	fmt.Println(len(s))
}
