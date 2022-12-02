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
		{"1122", 3},
		{"1111", 4},
		{"1234", 0},
		{"91212129", 9},
	}
	for _, test := range tests {
		t.Run(test.in, func(t *testing.T) {
			a := Process([]byte(test.in))
			assert.Equal(t, test.ex, a)
		})
	}
}
