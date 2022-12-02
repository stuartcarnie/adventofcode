package main

import (
	"testing"

	"bytes"
	"github.com/stretchr/testify/assert"
)

func TestProcess(t *testing.T) {
	tests := []struct {
		in string
		ex int
	}{
		{"{}", 1},
		{"{{{}}}", 6},
		{"{{},{}}", 5},
		{"{{{},{},{{}}}}", 16},
		{"{<a>,<a>,<a>,<a>}", 1},
		{"{{<ab>},{<ab>},{<ab>},{<ab>}}", 9},
		{"{{<!!>},{<!!>},{<!!>},{<!!>}}", 9},
		{"{{<a!>},{<a!>},{<a!>},{<ab>}}", 3},
	}
	for _, test := range tests {
		t.Run(test.in, func(t *testing.T) {
			buf := bytes.NewBufferString(test.in)
			a := Process(buf)
			assert.Equal(t, test.ex, a)
		})
	}
}
