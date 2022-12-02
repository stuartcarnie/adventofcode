package main

import (
	"strconv"
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestProcess(t *testing.T) {
	tests := []struct {
		in []byte
		ex int
	}{
		{[]byte{3, 4, 1, 5}, 12},
	}
	for n, test := range tests {
		t.Run(strconv.Itoa(n), func(t *testing.T) {
			a := Process(5, test.in)
			assert.Equal(t, test.ex, a)
		})
	}
}
