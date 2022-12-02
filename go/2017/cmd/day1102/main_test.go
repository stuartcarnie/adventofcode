package main

import (
	"strconv"
	"strings"
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestProcess(t *testing.T) {
	tests := []struct {
		in string
		ex int
	}{
		{"ne,ne,ne", 3},
		{"ne,ne,sw,sw", 0},
		{"ne,ne,s,s", 2},
		{"se,sw,se,sw,sw", 3},
	}

	for n, test := range tests {
		t.Run(strconv.Itoa(n), func(t *testing.T) {
			moves := strings.Split(test.in, ",")
			d := Process(moves)
			assert.Equal(t, test.ex, d)
		})
	}
}
