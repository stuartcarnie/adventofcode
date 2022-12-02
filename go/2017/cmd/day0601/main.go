package main

import (
	"bufio"
	"bytes"
	"fmt"
	"os"
	"strconv"
	"strings"
)

func main() {
	s := bufio.NewScanner(os.Stdin)
	s.Scan()
	words := strings.Fields(s.Text())
	vals := make([]int, len(words))
	for i, w := range words {
		vals[i], _ = strconv.Atoi(w)
	}

	fmt.Println(Process(vals))
}

func Process(in []int) int {
	set := make(map[string]struct{})
	b := bytes.NewBuffer(nil)
	c := 0

	for {
		c++
		// find largest
		var p int
		for i := 1; i < len(in); i++ {
			if in[i] > in[p] {
				p = i
			}
		}

		// rearrange
		var v int
		for v, in[p] = in[p], 0; v > 0; v-- {
			p = (p + 1) % len(in)
			in[p]++
		}

		// make key
		b.Reset()
		for _, v := range in {
			b.WriteString(strconv.Itoa(v))
			b.WriteByte(',')
		}
		key := b.String()

		if _, ok := set[key]; ok {
			return c
		}
		set[key] = struct{}{}
	}
}
