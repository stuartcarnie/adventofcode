package main

import (
	"encoding/json"
	"fmt"
	"io"
	"os"
)

func main() {
	sum := int64(0)
	d := json.NewDecoder(os.Stdin)
	d.UseNumber()
	for {
		tt, e := d.Token()
		if e == io.EOF {
			break
		} else if e != nil {
			fmt.Println(e.Error())
			break
		}

		switch t := tt.(type) {
		case json.Number:
			v, _ := t.Int64()
			sum += v

		}
	}

	fmt.Println(sum)
}
