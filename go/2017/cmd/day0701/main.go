package main

import (
	"bufio"
	"bytes"
	"fmt"
	"os"
	"strconv"
	"strings"
)

func main() {
	s := bufio.NewScanner(os.Stdin)
	n := BuildTree(s)
	fmt.Println(n.name)
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
	n.weight, _ = strconv.Atoi(p[1][1 : len(p[1])-1])

	var c []string
	if len(p) > 2 {
		c = make([]string, 0, len(p)-3)
		for _, v := range p[3:] {
			c = append(c, strings.TrimSuffix(v, ","))
		}
	}

	return n, c
}

type node struct {
	name     string
	weight   int
	p        *node
	children []*node
}

func (n *node) AddChild(c *node) {
	n.children = append(n.children, c)
	c.p = n
}
