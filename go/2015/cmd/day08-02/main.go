package main

import (
	"bufio"
	"bytes"
	"fmt"
	"os"
	"unicode/utf8"
)

func encode(s string) string {
	var b bytes.Buffer
	b.WriteString("\"")

	for i := 0; i < len(s); i++ {
		ch := s[i]
		switch ch {
		case '"':
			b.WriteString(`\"`)

		case '\\':
			b.WriteString(`\\`)

		default:
			b.WriteByte(ch)
		}
	}

	b.WriteString("\"")

	return b.String()
}

func main() {
	s := bufio.NewScanner(os.Stdin)

	codeLen, strLen := 0, 0

	for s.Scan() {
		line := s.Text()
		codeLen += len(line)

		d := encode(line)
		strLen += utf8.RuneCountInString(d)

		fmt.Printf("%3d | %3d | %s\n", len(line), utf8.RuneCountInString(d), d)
	}

	fmt.Println(strLen - codeLen)
}
