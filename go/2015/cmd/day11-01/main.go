package main

import (
	"fmt"
	"os"
	"strings"
)

func isValid(in string) bool {
	// has straight
	l := len(in)
	if l < 3 {
		return false
	}

	run := false
	for i := 0; i < l-2; i++ {
		if in[i]+1 == in[i+1] && in[i+1]+1 == in[i+2] {
			run = true
			break
		}
	}

	if !run {
		return false
	}

	if strings.ContainsAny(in, "iol") {
		return false
	}

	p := 0
	for i := 0; i < l-1; i++ {
		if in[i] == in[i+1] {
			p++
			if p == 2 {
				return true
			}

			i++
		}
	}

	return false
}

type pwd struct{ b []byte }

func reverse(s string) string {
	r := []rune(s)
	for i, j := 0, len(r)-1; i < len(r)/2; i, j = i+1, j-1 {
		r[i], r[j] = r[j], r[i]
	}

	return string(r)
}

func newPwd(s string) *pwd {
	return &pwd{[]byte(reverse(s))}
}

func (p *pwd) inc() {
	b := p.b
	for i := 0; i < len(b); i++ {
		v := ((b[i] - 97) + 1)
		if v <= 25 {
			b[i] = v + 97
			return
		}
		b[i] = 'a'
	}

	p.b = append(b, 'a')
}

func (p *pwd) String() string {
	return reverse(string(p.b))
}

func main() {
	if len(os.Args) != 2 {
		fmt.Printf("must specify input")
		os.Exit(1)
	}

	orig := newPwd(os.Args[1])
	fmt.Println(orig)

	s := orig
	s.inc()

	for !isValid(s.String()) {
		s.inc()
	}

	fmt.Println(s)
}
