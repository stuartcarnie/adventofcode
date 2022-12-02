package main

import (
	"bufio"
	"fmt"
	"os"
)

type pos struct{ x, y, m int }

const santaCount = 2

var cols = []string{
	"\x1b[32m",
	"\x1b[0m",
}

func main() {
	s := bufio.NewScanner(os.Stdin)
	s.Split(bufio.ScanBytes)
	h := make(map[string]int)
	h["0x0"] = santaCount
	var p [santaCount]pos
	i := 0

	for s.Scan() {
		ch := s.Text()
		s := &p[i]
		i = (i + 1) % santaCount
		switch ch {
		case "^":
			s.y += 1
		case "v":
			s.y -= 1
		case "<":
			s.x -= 1
		case ">":
			s.x += 1
		}
		s.m += 1
		fmt.Printf("%s%d | %s | moves = %4d | visits = %4d | %04d x %04d\n", cols[i%2], i, ch, s.m, len(h), s.x, s.y)
		k := fmt.Sprintf("%dx%d", s.x, s.y)
		v := h[k]
		v = v + 1
		h[k] = v
	}

	c := len(h)

	fmt.Println(c)
}
