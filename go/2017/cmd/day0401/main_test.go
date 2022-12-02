package main

import (
	"strings"
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestProcess(t *testing.T) {
	tests := []struct {
		in string
		ex bool
	}{
		{"aa bb cc dd ee", true},
		{"aa bb cc dd aa", false},
		{"aa bb cc dd aaa", true},
	}
	for _, test := range tests {
		t.Run(test.in, func(t *testing.T) {
			a := Process(strings.Fields(test.in))
			assert.Equal(t, test.ex, a)
		})
	}
}
