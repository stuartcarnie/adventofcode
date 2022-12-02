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
		{"<>", 0},
		{"<random characters>", 17},
		{"<<<<>", 3},
		{"<{!>}>", 2},
		{"<!!>", 0},
		{"<!!!>>", 0},
		{`<{o"i!a,<{i<a>`, 10},
	}
	for _, test := range tests {
		t.Run(test.in, func(t *testing.T) {
			buf := bytes.NewBufferString(test.in)
			a := Process(buf)
			assert.Equal(t, test.ex, a)
		})
	}
}
