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
		{"5 9 2 8", 4},
		{"9 4 7 3", 3},
		{"3 8 6 5", 2},
	}
	for _, test := range tests {
		t.Run(test.in, func(t *testing.T) {
			a := Process([]byte(test.in))
			assert.Equal(t, test.ex, a)
		})
	}
}
