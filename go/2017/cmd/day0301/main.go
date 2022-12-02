package main

import (
	"bufio"
	"fmt"
	"math"
	"os"
	"strconv"
)

func main() {
	s := bufio.NewScanner(os.Stdin)
	for s.Scan() {
		v, err := strconv.Atoi(s.Text())
		if err != nil {
			panic(err)
		}
		res := Process(v)
		fmt.Println(res)
	}
}

func Process(in int) int {
	if in == 1 {
		return 0
	}

	ring := int(math.Ceil(math.Sqrt(float64(in))))
	if ring&1 == 0 {
		ring++
	}

	count := ring*2 + (ring-2)*2
	br := ring * ring
	normalize := br - count
	center := ring / 2
	pos := int(math.Abs(float64(center - (in-normalize)%(ring-1))))

	return pos + center
}
