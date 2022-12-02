package main

import (
	"crypto/md5"
	"encoding/hex"
	"fmt"
	"os"
	"strings"
)

const help = `
day04-01 key prefix
`

func main() {
	if len(os.Args) < 2 {
		fmt.Println("missing secret")
		fmt.Println(help)
		os.Exit(1)
	}
	s := os.Args[1]

	var prefix string
	if len(os.Args) == 2 {
		prefix = "00000"
	} else {
		prefix = os.Args[2]
	}

	m := md5.New()
	hash := make([]byte, m.Size())
	for i := 0; ; i++ {
		fmt.Fprintf(m, "%s%d", s, i)
		md5 := m.Sum(hash[:0])
		if res := hex.EncodeToString(md5); strings.HasPrefix(res, prefix) {
			fmt.Printf("%d\n", i)
			break
		}

		m.Reset()
		i++
	}

}
