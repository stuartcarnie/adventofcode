package main

import (
	"bufio"
	"fmt"
	"io"
	"os"
	"regexp"
	"sort"
	"strconv"
)

type deerSpec struct {
	name     string
	velocity int
	run      int
	rest     int
}

type obj struct {
	deer     *deerSpec
	sleeping bool
	next     int
	pos      int
	score    int
}

type world []*obj

func (w world) Len() int {
	return len(w)
}

func (w world) Less(i, j int) bool {
	return w[i].pos > w[j].pos
}

func (w world) Swap(i, j int) {
	w[i], w[j] = w[j], w[i]
}

func main() {
	r := bufio.NewReader(os.Stdin)
	re := regexp.MustCompile(`^(\w+) can fly (\d+) km/s for (\d+) seconds, but then must rest for (\d+)`)

	var deers []*deerSpec

	for {
		l, _, err := r.ReadLine()
		if err == io.EOF || len(l) == 0 {
			break
		}

		d := re.FindStringSubmatch(string(l))
		dd := &deerSpec{}
		dd.name = d[1]
		dd.velocity, _ = strconv.Atoi(d[2])
		dd.run, _ = strconv.Atoi(d[3])
		dd.rest, _ = strconv.Atoi(d[4])
		deers = append(deers, dd)
	}

	w := make(world, len(deers))
	for i, d := range deers {
		w[i] = &obj{deer: d, sleeping: false, next: d.run, pos: 0, score: 0}
	}

	for t, to := 0, 2503; t < to; t++ {
		for _, o := range w {
			if o.next == t {
				if o.sleeping {
					o.sleeping = false
					o.next = t + o.deer.run
				} else {
					o.sleeping = true
					o.next = t + o.deer.rest
				}
			}

			if !o.sleeping {
				o.pos += o.deer.velocity
			}
		}

		sort.Sort(w)
		for i := 0; i < len(w)-1; i++ {
			w[i].score++
			if w[i].pos > w[i+1].pos {
				break
			}
		}
	}

	for _, o := range w {
		fmt.Printf("%s, pos: %d, score: %d\n", o.deer.name, o.pos, o.score)
	}
}
