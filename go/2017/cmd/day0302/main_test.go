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
		{26, 54},
		{747, 806},
	}
	for _, test := range tests {
		t.Run(fmt.Sprintf("%d", test.in), func(t *testing.T) {
			a := Process(test.in)
			assert.Equal(t, test.ex, a)
		})
	}
}

func TestMatrix(t *testing.T) {
	m := NewMatrix(1)
	m.SetVal(0, 0, 1)
	m.SetVal(2, 0, 2)
	t.Logf("%d", m.Val(0, 0))
	t.Logf("%d", m.Val(2, 0))
}
