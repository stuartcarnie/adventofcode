package main

import (
	"fmt"
	"io"
	"os"
)

func main() {
	fmt.Println(Process(os.Stdin))
}

func Process(r io.Reader) int {
	var w stream
	io.Copy(&w, r)
	return w.Score()
}

type stream struct {
	score   int
	stack   []byte
	esc     bool
	garbage bool
}

func (s *stream) Write(b []byte) (int, error) {
	var (
		n   int
		err error
	)
	for _, c := range b {
		n++
		if s.esc {
			s.esc = false
			continue // ignore
		}

		if c == '!' {
			s.esc = true
			continue
		}

		if s.garbage {
			if c == '>' {
				s.garbage = false
			} else {
				s.score++
			}
			continue
		}

		switch c {
		case '<':
			s.garbage = true
			continue

		case '{':
			s.push(c)

		case '}':
			s.pop()
		}
	}

	return n, err
}

func (s *stream) push(c byte) {
	s.stack = append(s.stack, c)
}

func (s *stream) pop() {
	s.stack = s.stack[:len(s.stack)-1]
}

func (s *stream) Score() int {
	return s.score
}
