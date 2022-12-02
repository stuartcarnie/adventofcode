package main

import (
	"bufio"
	"bytes"
	"encoding/hex"
	"fmt"
	"os"
	"unicode/utf8"
)

func decode(s string) string {
	var b bytes.Buffer

	for i := 0; i < len(s); i++ {
		ch := s[i]
		switch ch {
		case '"':

			i++
		LOOP:
			for ; i < len(s); i++ {
				ch := s[i]
				switch ch {
				case '"':
					break LOOP

				case '\\':
					switch s[i+1] {
					case 'x':
						i += 2
						v := s[i : i+2]
						i++
						c, _ := hex.DecodeString(v)
						b.WriteByte(c[0])

					case '\\':
						fallthrough
					case '"':
						i++
						b.WriteByte(s[i])

					default:
						panic("invalid escape sequence")
					}

				default:
					b.WriteByte(ch)
				}
			}
		}
	}

	return b.String()
}

func main() {
	s := bufio.NewScanner(os.Stdin)

	codeLen, strLen := 0, 0

	for s.Scan() {
		line := s.Text()
		codeLen += len(line)

		d := decode(line)
		strLen += utf8.RuneCountInString(d)

		fmt.Printf("%3d | %3d | %s\n", len(line), utf8.RuneCountInString(d), line)
	}

	fmt.Println(codeLen - strLen)
}
