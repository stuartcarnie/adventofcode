package main

import (
	"bufio"
	"fmt"
	"math"
	"os"
	"regexp"
	"sort"
	"strconv"
)

type node struct {
	name  string
	edges map[*node]int
}

type edge struct {
	to *node
	d  int
}

var nodes = make(map[string]*node)

func findNode(n string) *node {
	nn, ok := nodes[n]
	if !ok {
		nn = &node{name: n, edges: make(map[*node]int)}
		nodes[n] = nn
	}

	return nn
}

func find(g []*node, v *node) int {
	for i, f := range g {
		if f == v {
			return i
		}
	}

	return -1
}

func dijkstra(graph []*node, src *node) int {
	dist := make(map[*node]int)
	prev := make(map[*node]*node)
	g := make([]*node, len(graph))
	copy(g, graph)

	for _, n := range g {
		dist[n] = math.MaxInt32
		prev[n] = nil
	}

	dist[src] = 0
	for len(g) > 0 {
		d := math.MaxInt32
		var i int
		var u *node
		for ii, vv := range g {
			if dist[vv] < d {
				d = dist[vv]
				i = ii
				u = vv
			}
		}

		g = append(g[:i], g[i+1:]...)
		for to, w := range u.edges {
			if find(g, to) == -1 {
				continue
			}
			alt := d + w
			if alt < dist[to] {
				dist[to] = alt
				prev[to] = u
			}
		}
	}

	sum := 0
	for _, d := range dist {
		sum += d
	}

	return sum
}

func permute(a []int, k int) {
	for i := k; i < len(a); i++ {
		a[i], a[k] = a[k], a[i]
		permute(a, k+1)
		a[i], a[k] = a[k], a[i]
	}

	if k == len(a)-1 {
		fmt.Println(a)
	}
}

func main() {
	a := []int{1, 2, 3}
	permute(a, 0)
	os.Exit(0)

	s := bufio.NewScanner(os.Stdin)
	re := regexp.MustCompile(`(\w+) to (\w+) = (\d+)`)

LOOP:
	for s.Scan() {
		res := re.FindStringSubmatch(s.Text())
		if len(res) == 0 {
			break LOOP
		}

		from := findNode(res[1])
		to := findNode(res[2])

		dist, _ := strconv.Atoi(res[3])

		from.edges[to] = dist
		to.edges[from] = dist
	}

	var g []*node
	for _, n := range nodes {
		g = append(g, n)
	}

	var p []int
	for _, n := range g {
		d := dijkstra(g, n)
		p = append(p, d)
	}

	sort.Ints(p)

	fmt.Println(p[0])
}
