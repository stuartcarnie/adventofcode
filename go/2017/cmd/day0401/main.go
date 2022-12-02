package main

import (
	"bufio"
	"fmt"
	"os"
	"sort"
	"strings"
)

func main() {
	s := bufio.NewScanner(os.Stdin)
	valid := 0
	for s.Scan() {
		words := strings.Fields(s.Text())
		if Process(words) {
			valid++
		}
	}
	fmt.Println(valid)
}

func Process(s []string) bool {
	if len(s) < 2 {
		return true
	}

	sort.Strings(s)

	for i := 1; i < len(s); i++ {
		if s[i-1] == s[i] {
			return false
		}
	}
	return true
}
