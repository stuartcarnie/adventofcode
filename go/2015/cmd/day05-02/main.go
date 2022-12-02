package main

import (
	"bufio"
	"fmt"
	"os"
	"strings"
)

func main() {
	s := bufio.NewScanner(os.Stdin)
	g := 0
	for s.Scan() {
		l := s.Text()
		ll := len(l)

		pair := false
		for i := 0; i < ll-2; i++ {
			if strings.Index(l[i+2:], l[i:i+2]) != -1 {
				pair = true
				break
			}
		}

		rep := false
		for i := 0; i < ll-2; i++ {
			if l[i] == l[i+2] {
				rep = true
				break
			}
		}

		if pair && rep {
			g++
		}
	}

	fmt.Println(g)
}
