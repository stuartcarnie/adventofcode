package main

import (
	"bufio"
	"fmt"
	"os"
	"sort"
	"strconv"
	"strings"
)

type dimension [3]int

func (d dimension) String() string {
	return fmt.Sprintf("%dx%dx%d", d[0], d[1], d[2])
}

func (d dimension) surfaceArea() int {
	return 2*(d[0]*d[1]) + 2*(d[1]*d[2]) + 2*(d[0]*d[2])
}

func findSmallestArea(d dimension) int {
	sort.Ints(d[0:])
	return d[0] * d[1]
}

func conv(s string) (dimension, error) {
	dims := strings.Split(s, "x")
	if len(dims) != 3 {
		return dimension{}, fmt.Errorf("invalid dimension")
	}

	var d dimension
	var err error
	for i, a := range dims {
		d[i], err = strconv.Atoi(a)
		if err != nil {
			return dimension{}, fmt.Errorf("invalid dimension")
		}
	}

	return d, nil
}

func main() {
	s := bufio.NewScanner(os.Stdin)
	t := 0
	for s.Scan() {
		d, err := conv(s.Text())
		if err != nil {
			fmt.Println(err)
			os.Exit(1)
		}

		p := d.surfaceArea() + findSmallestArea(d)
		fmt.Printf("%-10s | total=%5d | area=%5d | small=%4d\n", d, p, d.surfaceArea(), findSmallestArea(d))
		t += p
	}

	fmt.Println(t)
}
