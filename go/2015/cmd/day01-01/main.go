package main

import (
	"bufio"
	"fmt"
	"io"
	"os"
)

func main() {
	rdr := bufio.NewReader(os.Stdin)
	c := 0
	for {
		b, err := rdr.ReadByte()
		if err == io.EOF {
			fmt.Println(c)
			os.Exit(0)
		} else if err != nil {
			fmt.Println(err.Error())
			os.Exit(1)
		}

		if b == '(' {
			c++
		} else if b == ')' {
			c--
		} else {
			fmt.Println("invalid input character")
			os.Exit(1)
		}
	}
}
