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
		{"abcde fghij", true},
		{"abcde xyz ecdab", false},
		{"a ab abc abd abf abj", true},
		{"iiii oiii ooii oooi oooo", true},
		{"oiii ioii iioi iiio", false},
	}
	for _, test := range tests {
		t.Run(test.in, func(t *testing.T) {
			a := Process(strings.Fields(test.in))
			assert.Equal(t, test.ex, a)
		})
	}
}
