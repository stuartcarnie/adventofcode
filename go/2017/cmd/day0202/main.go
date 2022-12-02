package main

import (
	"bufio"
	"bytes"
	"fmt"
	"io"
	"os"
	"sort"
)

func main() {
	s := bufio.NewScanner(os.Stdin)
	sum := 0
	for s.Scan() {
		sum += Process(s.Bytes())
	}
	fmt.Println(sum)
}

func Process(s []byte) int {
	r := bytes.NewReader(s)
	var vals []int
	for {
		v := 0
		_, err := fmt.Fscanf(r, "%d", &v)
		if err == io.EOF {
			break
		}
		vals = append(vals, v)
	}

	sort.Sort(sort.Reverse(sort.IntSlice(vals)))

	for i := 0; i < len(vals); i++ {
		n := vals[i]
		half := n / 2

		for j := len(vals) - 1; j > i; j-- {
			m := vals[j]
			if m > half {
				break
			}

			if n%m == 0 {
				return n / m
			}
		}
	}

	return 0
}
