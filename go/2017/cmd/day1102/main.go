package main

import (
	"fmt"
	"io/ioutil"
	"os"
	"strings"
)

func main() {
	d, _ := ioutil.ReadAll(os.Stdin)
	moves := strings.Split(string(d), ",")
	fmt.Println(Process(moves))
}

func abs(v int) int {
	if v < 0 {
		return -v
	}
	return v
}

type Cube struct {
	x, y, z int
}

func (c *Cube) Add(o Cube) {
	c.x += o.x
	c.y += o.y
	c.z += o.z
}

func (c Cube) Distance(o Cube) int {
	return (abs(c.x-o.x) + abs(c.y-o.y) + abs(c.z-o.z)) / 2
}

var (
	cubeDirs = map[string]Cube{
		"n":  {x: 0, y: +1, z: -1},
		"ne": {x: +1, y: 0, z: -1},
		"se": {x: +1, y: -1, z: 0},
		"s":  {x: 0, y: -1, z: +1},
		"sw": {x: -1, y: 0, z: +1},
		"nw": {x: -1, y: +1, z: 0},
	}
)

func Process(in []string) int {
	var pos Cube
	max := 0

	for _, m := range in {
		pos.Add(cubeDirs[m])
		d := pos.Distance(Cube{})
		if d > max {
			max = d
		}
	}

	return max
}
