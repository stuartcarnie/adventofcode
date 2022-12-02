package main

import (
	"fmt"
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestProcess(t *testing.T) {
	tests := []struct {
		in int
		ex int
	}{
		{1, 0},
		{12, 3},
		{23, 2},
		{1024, 31},
	}
	for _, test := range tests {
		t.Run(fmt.Sprintf("%d", test.in), func(t *testing.T) {
			a := Process(test.in)
			assert.Equal(t, test.ex, a)
		})
	}
}
