package main

import (
	"bufio"
	"fmt"
	"os"
	"regexp"
	"strings"
)

const vowels = "aeiou"

func main() {
	s := bufio.NewScanner(os.Stdin)
	bad := regexp.MustCompile("ab|cd|pq|xy")
	g := 0
	for s.Scan() {
		l := s.Text()
		if bad.MatchString(l) {
			continue
		}

		c, dbl := 0, false
		for i := 0; i < len(l) && (c < 3 || !dbl); i++ {
			p := strings.IndexByte(vowels, l[i])
			if p != -1 {
				c++
			}

			if i > 0 && l[i-1] == l[i] {
				dbl = true
			}
		}

		if c > 2 && dbl {
			g++
		}
	}

	fmt.Println(g)
}
