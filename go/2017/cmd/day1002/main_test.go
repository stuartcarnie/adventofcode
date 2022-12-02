package main

import (
	"strconv"
	"testing"

	"encoding/hex"
	"github.com/stretchr/testify/assert"
)

func TestProcess(t *testing.T) {
	tests := []struct {
		in string
		ex string
	}{
		{"", "a2582a3a0e66e6e86e3812dcb672a272"},
		{"AoC 2017", "33efeb34ea91902bb2f59c9920caa6cd"},
		{"1,2,3", "3efbe78a8d82f29979031a4aa0b16a9d"},
		{"1,2,4", "63960835bcdc130f0b66d7ff4f6a5a8e"},
	}

	salt := []byte{17, 31, 73, 47, 23}

	for n, test := range tests {
		t.Run(strconv.Itoa(n), func(t *testing.T) {
			buf := append([]byte(test.in), salt...)
			a := hex.EncodeToString(Process(256, buf, 64))
			assert.Equal(t, test.ex, a)
		})
	}
}
