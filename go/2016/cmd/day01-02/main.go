package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
)

func isSpace(c byte) bool {
	return c == ' ' || c == '\n'
}

func onComma(data []byte, atEOF bool) (advance int, token []byte, err error) {
	var s int
	for ; s < len(data) && isSpace(data[s]); s++ {
	}

	var i int
	for i = s; i < len(data); i++ {
		if data[i] == ',' {
			return i + 1, data[s:i], nil
		}
	}

	for i = s; i < len(data); i++ {
		if isSpace(data[i]) {
			break
		}
	}

	return 0, data[s:i], bufio.ErrFinalToken
}

func main() {
	m := make(map[string]struct{})

	s := bufio.NewScanner(os.Stdin)
	s.Split(onComma)
	d := 0
	x, y := 0, 0
	for s.Scan() {
		c := s.Text()
		switch c[0] {
		case 'L':
			d -= 1

		case 'R':
			d += 1
		}

		if d < 0 {
			d += 4
		} else if d > 3 {
			d -= 4
		}

		v, _ := strconv.Atoi(c[1:])
		switch d {
		case 0:

			y + v
		case 1:
			x += v
		case 2:
			y -= v
		case 3:
			x -= v
		}
		fmt.Printf("c=%s, v=%d, x=%d, y=%d, d=%d\n", c, v, x, y, d)
		key := fmt.Sprintf("%d,%d", x, y)
		if _, ok := m[key]; ok {
			break
		} else {
			m[key] = struct{}{}
		}
	}

	if x < 0 {
		x *= -1
	}
	if y < 0 {
		y *= -1
	}
	fmt.Println(x + y)
}

// vim:ts=4 sw=4 noet
