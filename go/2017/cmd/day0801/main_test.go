package main

import (
	"testing"

	"bufio"
	"bytes"
	"strconv"
)

var (
	one = `b inc 5 if a > 1
a inc 1 if b < 5
c dec -10 if a >= 1
c inc -20 if c == 10`
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
			vm := NewMachine()
			vm.Execute(s)
			t.Log(vm.String())
		})
	}
}
