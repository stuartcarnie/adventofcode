package main

import (
	"testing"

	"bufio"
	"bytes"
	"github.com/stretchr/testify/assert"
	"strconv"
)

var (
	one = `pbga (66)
xhth (57)
ebii (61)
havc (66)
ktlj (57)
fwft (72) -> ktlj, cntj, xhth
qoyq (66)
padx (45) -> pbga, havc, qoyq
tknk (41) -> ugml, padx, fwft
jptl (61)
ugml (68) -> gyxo, ebii, jptl
gyxo (61)
cntj (57)`
)

func TestProcess(t *testing.T) {
	tests := []struct {
		in string
		ex int
	}{
		{one, 60},
	}
	for i, test := range tests {
		t.Run(strconv.Itoa(i), func(t *testing.T) {
			s := bufio.NewScanner(bytes.NewBufferString(test.in))
			n := BuildTree(s)
			r := FindNode(n)
			assert.Equal(t, test.ex, r.nw)
		})
	}
}

func TestParseNode(t *testing.T) {
	n, c := ParseNode("fwft (72) -> ktlj, cntj, xhth")
	t.Log(n, c)
}
