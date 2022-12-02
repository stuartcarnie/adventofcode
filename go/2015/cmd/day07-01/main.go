package main

import (
	"bufio"
	"fmt"
	"math"
	"os"
	"regexp"
	"strconv"
)

type node interface {
	IsUndefined() bool
	Value() uint16
	Reset()
}

type undefinedNode struct{}

func (v *undefinedNode) IsUndefined() bool {
	return true
}

func (v *undefinedNode) Value() uint16 {
	return math.MaxUint16
}

func (v *undefinedNode) Reset() {
}

type valueNode struct {
	val uint16
}

func (v *valueNode) IsUndefined() bool {
	return false
}

func (v *valueNode) Value() uint16 {
	return v.val
}

func (v *valueNode) Reset() {
}

type assignNode struct {
	name string
	expr node
	v    *uint16
}

func (a *assignNode) IsUndefined() bool {
	return a.expr.IsUndefined()
}

func (a *assignNode) Value() uint16 {
	if a.v == nil {
		a.v = new(uint16)
		*a.v = a.expr.Value()
	}
	return *a.v
}

func (a *assignNode) Reset() {
	if a.v != nil {
		a.v = nil
		a.expr.Reset()
	}
}

type notNode struct {
	expr node
	v    *uint16
}

func (nn *notNode) IsUndefined() bool {
	return nn.expr.IsUndefined()
}

func (nn *notNode) Value() uint16 {
	if nn.v == nil {
		nn.v = new(uint16)
		*nn.v = ^nn.expr.Value()
	}
	return *nn.v
}

func (nn *notNode) Reset() {
	if nn.v != nil {
		nn.v = nil
		nn.expr.Reset()
	}
}

type op int

const (
	SHL op = iota
	SHR
	AND
	OR
)

type opNode struct {
	op          op
	left, right node
	v           *uint16
}

func (op *opNode) IsUndefined() bool {
	return op.left.IsUndefined() || op.right.IsUndefined()
}

func (op *opNode) Value() uint16 {
	if op.v == nil {
		op.v = new(uint16)
		switch op.op {
		case SHL:
			*op.v = op.left.Value() << op.right.Value()
		case SHR:
			*op.v = op.left.Value() >> op.right.Value()
		case AND:
			*op.v = op.left.Value() & op.right.Value()
		case OR:
			*op.v = op.left.Value() | op.right.Value()
		}
	}
	return *op.v
}

func (op *opNode) Reset() {
	if op.v != nil {
		op.v = nil
		op.left.Reset()
		op.right.Reset()
	}
}

const (
	cmdVal = iota
	cmdOp
	cmdNot
	cmdNone
)

var sym = make(map[string]node)

func findSym(name string) *assignNode {
	var a *assignNode
	n, ok := sym[name]
	if !ok {
		a = &assignNode{name: name, expr: &undefinedNode{}}
		sym[name] = a
	} else {
		a = n.(*assignNode)
	}

	return a
}

func newValueNode(s string) *valueNode {
	v, _ := strconv.Atoi(s)
	return &valueNode{uint16(v)}
}

var isInt = regexp.MustCompile(`^\d+`)

func getValOrSym(val string) node {
	if isInt.MatchString(val) {
		return newValueNode(val)
	}

	return findSym(val)
}

func main() {
	e := "a"
	if len(os.Args) == 2 {
		e = os.Args[1]
	}
	s := bufio.NewScanner(os.Stdin)

	res := []*regexp.Regexp{
		regexp.MustCompile(`^(\w+|\d+) -> (\w+)`),
		regexp.MustCompile(`^(\d+|\w+) (AND|OR|LSHIFT|RSHIFT) (\d+|\w+) -> (\w+)`),
		regexp.MustCompile(`^NOT (\d+|\w+) -> (\w+)`),
	}

	ops := map[string]op{
		"LSHIFT": SHL,
		"RSHIFT": SHR,
		"AND":    AND,
		"OR":     OR,
	}

	for s.Scan() {
		l := s.Text()
		var cmd int = cmdNone
		var m []string
		for i, re := range res {
			m = re.FindStringSubmatch(l)
			if len(m) > 0 {
				cmd = i
				break
			}
		}

		switch cmd {
		case cmdVal:
			a := findSym(m[2])
			a.expr = getValOrSym(m[1])

		case cmdOp:
			a := findSym(m[4])
			a.expr = &opNode{
				op:    ops[m[2]],
				left:  getValOrSym(m[1]),
				right: getValOrSym(m[3]),
			}

		case cmdNot:
			a := findSym(m[2])
			a.expr = &notNode{expr: getValOrSym(m[1])}

		case cmdNone:
			fmt.Println("invalid command", l)
			os.Exit(1)
		}
	}

	a, ok := sym[e]
	if !ok {
		fmt.Printf("%s = undefined", e)
		os.Exit(1)
	}

	fmt.Printf("%s = %d\n", e, a.Value())

	b := findSym("b")
	b.expr = &valueNode{val: a.Value()}
	a.Reset()
	fmt.Printf("%s = %d\n", e, a.Value())
}
