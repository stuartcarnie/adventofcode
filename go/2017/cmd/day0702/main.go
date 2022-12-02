package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
	"strings"
)

func main() {
	s := bufio.NewScanner(os.Stdin)
	n := BuildTree(s)
	r := FindNode(n)
	fmt.Println(r.nw)
}

func BuildTree(s *bufio.Scanner) *node {
	nodes := make(map[string]*node)
	children := make(map[string][]string)

	for s.Scan() {
		d, c := ParseNode(s.Text())
		nodes[d.name] = d
		children[d.name] = c
	}

	var n *node
	for name, cc := range children {
		n = nodes[name]
		for _, cn := range cc {
			n.AddChild(nodes[cn])
		}
	}

	for n.p != nil {
		n = n.p
	}
	return n
}

func ParseNode(line string) (*node, []string) {
	p := strings.Fields(line)

	n := &node{name: p[0]}
	n.weight, _ = strconv.Atoi(p[1][1: len(p[1])-1])

	var c []string
	if len(p) > 2 {
		c = make([]string, 0, len(p)-3)
		for _, v := range p[3:] {
			c = append(c, strings.TrimSuffix(v, ","))
		}
	}

	return n, c
}

type nw struct {
	n  *node
	nw int
}

func FindNode(n *node) *nw {
	if len(n.children) < 2 {
		return nil
	}

	weights := make(map[int][]int)
	for i, c := range n.children {
		if found := FindNode(c); found != nil {
			return found
		}
		weights[c.Weight()] = append(weights[c.Weight()], i)
	}

	if len(weights) == 1 {
		return nil
	}

	v := make([]int, 2)
	for k, c := range weights {
		if len(c) == 1 {
			v[0] = k
		} else {
			v[1] = k
		}
	}

	req := v[0] - v[1]
	dn := weights[v[0]][0]
	child := n.children[dn]
	return &nw{n: child, nw: child.weight - req}
}

type node struct {
	name     string
	weight   int
	p        *node
	children []*node
	tw       int
	set      bool
}

func (n *node) AddChild(c *node) {
	n.children = append(n.children, c)
	c.p = n
}

func (n *node) Weight() int {
	if n.set {
		return n.tw
	}

	weight := n.weight
	for _, c := range n.children {
		weight += c.Weight()
	}
	n.set = true
	n.tw = weight

	return n.tw
}
