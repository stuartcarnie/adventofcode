package main

import (
	"fmt"
)

func main() {
	var vals []int
	for {
		var val int
		if _, err := fmt.Scanf("%d", &val); err != nil {
			break
		}
		vals = append(vals, val)
	}
	fmt.Println(Process(vals))
}

func Process(in []int) int {
	p := 0
	s := 0
	for p < len(in) {
		ofs := in[p]
		if ofs > 2 {
			in[p]--
		} else {
			in[p]++
		}

		p += ofs
		s++
	}
	return s
}
