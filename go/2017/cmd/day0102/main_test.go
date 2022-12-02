package main

import (
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestProcess(t *testing.T) {
	tests := []struct {
		in string
		ex int
	}{
		{"1212", 6},
		{"1221", 0},
		{"123425", 4},
		{"123123", 12},
		{"12131415", 4},
	}
	for _, test := range tests {
		t.Run(test.in, func(t *testing.T) {
			a := Process([]byte(test.in))
			assert.Equal(t, test.ex, a)
		})
	}
}
