package main

import (
	"bufio"
	"fmt"
	"os"
)

func main() {
	s := bufio.NewScanner(os.Stdin)
	s.Split(bufio.ScanBytes)
	h := make(map[string]int)
	h["0x0"] = 1

	x, y, m := 0, 0, 0
	for s.Scan() {
		ch := s.Text()
		switch ch {
		case "^":
			y += 1
		case "v":
			y -= 1
		case "<":
			x -= 1
		case ">":
			x += 1
		}
		m += 1
		fmt.Printf("%s | moves = %4d | visits = %4d | %04d x %04d\n", ch, m, len(h), x, y)
		k := fmt.Sprintf("%dx%d", x, y)
		v := h[k]
		v = v + 1
		h[k] = v
	}

	c := len(h)

	fmt.Println(c)
}
