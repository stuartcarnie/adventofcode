package main

import (
	"encoding/hex"
	"fmt"
	"io/ioutil"
	"os"
)

func main() {
	vals, _ := ioutil.ReadAll(os.Stdin)
	salt := []byte{17, 31, 73, 47, 23}
	vals = append(vals, salt...)

	hash := Process(256, vals, 64)
	fmt.Println(hex.EncodeToString(hash))
}

func Process(s int, in []byte, rounds int) []byte {
	h := newHash(s)

	for i := 0; i < rounds; i++ {
		for _, v := range in {
			h.Sum(v)
		}
	}

	return h.Hash()
}

type hash struct {
	buf  []byte
	sz   int
	p    int
	skip int
}

func newHash(sz int) *hash {
	var h hash
	h.sz = int(sz)
	h.buf = make([]byte, h.sz*2)
	for i := 1; i < h.sz; i++ {
		h.buf[i] = byte(i)
	}
	return &h
}

func (h *hash) Sum(l byte) {
	lo := h.p
	hi := h.p + int(l) - 1
	for lo < hi {
		h.buf[lo%h.sz], h.buf[hi%h.sz] = h.buf[hi%h.sz], h.buf[lo%h.sz]
		lo++
		hi--
	}

	h.p = (h.p + int(l) + h.skip) % h.sz
	h.skip++
}

func (h *hash) Hash() []byte {
	var b [16]byte
	for i := 0; i < 16; i++ {
		b[i] = h.buf[i*16]
		for j := 1; j < 16; j++ {
			b[i] ^= h.buf[i*16+j]
		}
	}
	return b[:]
}
