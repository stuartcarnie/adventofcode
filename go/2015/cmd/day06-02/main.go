package main

import (
	"bufio"
	"fmt"
	"os"
	"regexp"
	"strconv"
)

const (
	CmdOff = iota
	CmdOn
	CmdToggle
)

const (
	pCmd = iota + 1
	pStartX
	pStartY
	pEndX
	pEndY
)

type point struct {
	x, y int
}

func (p point) String() string {
	return fmt.Sprintf("%d,%d", p.x, p.y)
}

type lights [1000][1000]int

func (l *lights) on(from, to point) {
	for x := from.x; x <= to.x; x++ {
		for y := from.y; y <= to.y; y++ {
			l[x][y] += 1
		}
	}
}

func max(a, b int) int {
	if a > b {
		return a
	}

	return b
}

func (l *lights) off(from, to point) {
	for x := from.x; x <= to.x; x++ {
		for y := from.y; y <= to.y; y++ {
			b := l[x][y]
			l[x][y] = max(b-1, 0)
		}
	}
}

func (l *lights) toggle(from, to point) {
	for x := from.x; x <= to.x; x++ {
		for y := from.y; y <= to.y; y++ {
			l[x][y] += 2
		}
	}
}

func (l *lights) brightness() int {
	b := 0
	for x := 0; x < 1000; x++ {
		for y := 0; y < 1000; y++ {
			b += l[x][y]
		}
	}

	return b
}

func main() {
	s := bufio.NewScanner(os.Stdin)
	r := regexp.MustCompile(`^(turn on|turn off|toggle)\s+(\d+),(\d+)\s+through\s+(\d+),(\d+)`)

	var l *lights = new(lights)

	for s.Scan() {
		res := r.FindStringSubmatch(s.Text())
		if len(res) != 6 {
			fmt.Println("invalid command line")
			os.Exit(1)
		}
		cmd := res[pCmd]
		var from, to point
		from.x, _ = strconv.Atoi(res[pStartX])
		from.y, _ = strconv.Atoi(res[pStartY])
		to.x, _ = strconv.Atoi(res[pEndX])
		to.y, _ = strconv.Atoi(res[pEndY])
		fmt.Printf("%s: %s through %s | ", cmd, from, to)

		before := l.brightness()

		switch cmd {
		case "turn on":
			l.on(from, to)

		case "turn off":
			l.off(from, to)

		case "toggle":
			l.toggle(from, to)
		}

		fmt.Printf("before %d, after %d\n", before, l.brightness())
	}

	fmt.Println(l.brightness())
}
