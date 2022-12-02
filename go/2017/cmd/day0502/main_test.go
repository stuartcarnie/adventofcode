package main

import (
	"strconv"
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestProcess(t *testing.T) {
	tests := []struct {
		in []int
		ex int
	}{
		{[]int{0, 3, 0, 1, -3}, 10},
	}
	for n, test := range tests {
		t.Run(strconv.Itoa(n), func(t *testing.T) {
			a := Process(test.in)
			assert.Equal(t, test.ex, a)
		})
	}
}
