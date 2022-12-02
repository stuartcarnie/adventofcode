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
	sort.Ints(vals)
	return vals[len(vals)-1] - vals[0]
}
