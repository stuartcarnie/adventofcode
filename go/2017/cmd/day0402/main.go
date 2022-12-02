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

	s2 := make([]string, len(s))
	for i := 0; i < len(s); i++ {
		v := []byte(s[i])
		sort.Slice(v, func(i, j int) bool {
			return v[i] < v[j]
		})
		s2[i] = string(v)
	}

	sort.Strings(s2)

	for i := 1; i < len(s2); i++ {
		if s2[i-1] == s2[i] {
			return false
		}
	}
	return true
}
