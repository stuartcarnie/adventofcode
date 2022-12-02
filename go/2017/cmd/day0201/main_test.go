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
		{"5 1 9 5", 8},
		{"7 5 3", 4},
		{"2 4 6 8", 6},
	}
	for _, test := range tests {
		t.Run(test.in, func(t *testing.T) {
			a := Process([]byte(test.in))
			assert.Equal(t, test.ex, a)
		})
	}
}
