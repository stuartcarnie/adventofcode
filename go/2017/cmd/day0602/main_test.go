package main

import (
	"testing"

	"github.com/stretchr/testify/assert"
	"strconv"
)

func TestProcess(t *testing.T) {
	tests := []struct {
		in []int
		ex int
	}{
		{[]int{0, 2, 7, 0}, 4},
	}
	for i, test := range tests {
		t.Run(strconv.Itoa(i), func(t *testing.T) {
			a := Process(test.in)
			assert.Equal(t, test.ex, a)
		})
	}
}
