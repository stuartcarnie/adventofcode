package main

import (
	"fmt"
)

func main() {
	var vals []byte
	for {
		var val byte
		if _, err := fmt.Scanf("%d", &val); err != nil {
			break
		}
		vals = append(vals, val)
	}
	fmt.Println(Process(256, vals))
}

func Process(s int, in []byte) int {
	h := newHash(s)
	for _, v := range in {
		h.Sum(v)
	}
	return h.buf[0] * h.buf[1]
}

type hash struct {
	buf  []int
	sz   int
	p    int
	skip int
}

func newHash(sz int) *hash {
	var h hash
	h.sz = int(sz)
	h.buf = make([]int, h.sz*2)
	for i := 1; i < h.sz; i++ {
		h.buf[i] = i
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

	h.p = (h.p + int(l) + h.skip)%h.sz
	h.skip++
}
