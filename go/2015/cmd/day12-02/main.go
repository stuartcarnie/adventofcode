package main

import (
	"encoding/json"
	"fmt"
	"io/ioutil"
	"os"
)

func walkVal(vv interface{}) int64 {
	switch v := vv.(type) {
	case map[string]interface{}:
		return walkObj(v)

	case []interface{}:
		return walkArr(v)

	case int64:
		return v

	case float64:
		return int64(v)

	case string:
		return 0
	}

	return 0
}

func walkArr(obj []interface{}) int64 {
	sum := int64(0)
	for _, vv := range obj {
		sum += walkVal(vv)
	}

	return sum
}

func walkObj(obj map[string]interface{}) int64 {
	sum := int64(0)
	for _, vv := range obj {
		if s, ok := vv.(string); ok && s == "red" {
			return 0
		}

		sum += walkVal(vv)
	}

	return sum
}

func main() {
	b, _ := ioutil.ReadAll(os.Stdin)
	var obj interface{}
	json.Unmarshal(b, &obj)
	sum := walkVal(obj)

	fmt.Println(sum)
}
