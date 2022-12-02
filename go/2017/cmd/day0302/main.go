package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
)

func main() {
	s := bufio.NewScanner(os.Stdin)
	for s.Scan() {
		v, err := strconv.Atoi(s.Text())
		if err != nil {
			panic(err)
		}
		res := Process(v)
		fmt.Println(res)
	}
}

type dir int

const (
	right dir = iota
	up
	left
	down
)

func Process(in int) int {
	if in == 1 {
		return 0
	}

	m := NewMatrix(20)
	m.SetVal(0, 0, 1)
	var (
		d       dir
		x, y, s int
	)

	l := 1
	for {
		switch d {
		case right:
			x++
		case up:
			y--
		case left:
			x--
		case down:
			y++
		}
		c := m.Sum(x, y)
		if c > in {
			return c
		}
		m.SetVal(x, y, c)

		s++
		if s >= l {
			s = 0
			d = (d + 1) % 4
			switch d {
			case left, right:
				l++
			}
		}
	}
}

type Matrix struct {
	data []int
	s    int
}

func NewMatrix(s int) *Matrix {
	return &Matrix{
		data: make([]int, s*s),
		s:    s,
	}
}

func (m *Matrix) Val(x, y int) int {
	if m.pos(x, y) > len(m.data) {
		return 0
	}
	return m.data[m.pos(x, y)]
}

func (m *Matrix) SetVal(x, y, v int) {
	if m.pos(x, y) > len(m.data) {
		m.resize(m.s*2 + 1)
	}
	m.data[m.pos(x, y)] = v
}

func (m *Matrix) Sum(x, y int) int {
	sum := m.Val(x+1, y-0)
	sum += m.Val(x+1, y-1)
	sum += m.Val(x-0, y-1)
	sum += m.Val(x-1, y-1)
	sum += m.Val(x-1, y-0)
	sum += m.Val(x-1, y+1)
	sum += m.Val(x-0, y+1)
	sum += m.Val(x+1, y+1)
	return sum
}

func (m *Matrix) pos(x, y int) int {
	h := m.s / 2
	return (x + h) + (y+h)*m.s
}

func (m *Matrix) resize(s int) {
	d := make([]int, s*s)
	p := (s - m.s) / 2
	for i := 0; i < m.s; i++ {
		copy(d[(s+p)*(i+p):], m.data[m.s*i:m.s])
	}
	m.s = s
	m.data = d
}
