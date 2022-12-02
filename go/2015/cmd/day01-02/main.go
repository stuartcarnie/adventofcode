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
	i := 1
	for {
		b, err := rdr.ReadByte()
		if err == io.EOF {
			fmt.Println("does not reach floor -1")
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

		if c == -1 {
			fmt.Println(i)
			os.Exit(0)
		}

		i++
	}
}
