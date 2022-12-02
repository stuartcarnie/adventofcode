package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
	"strings"
	"sort"
	"bytes"
	"math"
)

func main() {
	s := bufio.NewScanner(os.Stdin)
	vm := NewMachine()
	vm.Execute(s)

	max := math.MinInt64

	for _, r := range vm.reg {
		if r.Val > max {
			max = r.Val
		}
	}
	fmt.Println(max)
}

type machine struct {
	reg map[string]*register
}

func NewMachine() *machine {
	return &machine{reg: make(map[string]*register)}
}

func (m *machine) Execute(in *bufio.Scanner) {
	for in.Scan() {
		stmt := m.ParseStatement(in.Text())
		stmt.Execute()
	}
}

func (m *machine) String() string {
	buf := bytes.NewBuffer(nil)

	keys := make([]string, 0, len(m.reg))
	for k := range m.reg {
		keys = append(keys, k)
	}
	sort.Strings(keys)

	for _, k := range keys {
		r := m.reg[k]
		fmt.Fprintf(buf, "%s: %d\n", r.n, r.Val)
	}
	return buf.String()
}

func (m *machine) ParseStatement(in string) *stmt {
	var (
		s   stmt
		err error
	)

	parts := strings.Fields(in)

	s.Reg = m.getReg(parts[0])

	switch parts[1] {
	case "inc":
		s.Op = NumOpInc
	case "dec":
		s.Op = NumOpDec
	default:
		panic(fmt.Sprintf("invalid numeric operator '%s'", parts[1]))
	}

	if s.Val, err = strconv.Atoi(parts[2]); err != nil {
		panic(fmt.Sprintf("failed to parse accumulator value '%s': %s", parts[2], err.Error()))
	}

	// parse condition
	if parts[3] != "if" {
		panic(fmt.Sprintf("expected if, got '%s'", parts[3]))
	}

	s.Cond.Reg = m.getReg(parts[4])

	switch parts[5] {
	case "<":
		s.Cond.Op = CondOpLT
	case "<=":
		s.Cond.Op = CondOpLE
	case "==":
		s.Cond.Op = CondOpEQ
	case "!=":
		s.Cond.Op = CondOpNE
	case ">":
		s.Cond.Op = CondOpGT
	case ">=":
		s.Cond.Op = CondOpGE
	default:
		panic(fmt.Sprintf("invalid condition operator '%s'", parts[5]))
	}

	if s.Cond.Val, err = strconv.Atoi(parts[6]); err != nil {
		panic(fmt.Sprintf("failed to parse condition value '%s': %s", parts[6], err.Error()))
	}

	return &s
}

func (m *machine) getReg(n string) *register {
	var r *register
	if r = m.reg[n]; r == nil {
		r = &register{n: n}
		m.reg[n] = r
	}
	return r
}

type register struct {
	n   string
	Val int
}

type NumOp int

const (
	NumOpInc NumOp = iota
	NumOpDec
)

type stmt struct {
	Reg  *register
	Op   NumOp
	Val  int
	Cond cond
}

func (s *stmt) Execute() {
	if !s.Cond.Result() {
		return
	}

	switch s.Op {
	case NumOpInc:
		s.Reg.Val += s.Val
	case NumOpDec:
		s.Reg.Val -= s.Val
	}
}

type CondOp int

const (
	CondOpLT CondOp = iota
	CondOpLE
	CondOpEQ
	CondOpNE
	CondOpGE
	CondOpGT
)

type cond struct {
	Reg *register
	Op  CondOp
	Val int
}

func (c *cond) Result() bool {
	v := c.Reg.Val
	switch c.Op {
	case CondOpLT:
		return v < c.Val
	case CondOpLE:
		return v <= c.Val
	case CondOpEQ:
		return v == c.Val
	case CondOpNE:
		return v != c.Val
	case CondOpGT:
		return v > c.Val
	case CondOpGE:
		return v >= c.Val
	}

	panic("not reachable")
}
