package main


import (
	"fmt"
)
var any_input string
var testing_slice = []string{"example" ,"example2","example3"}

func main() {
	fmt.Println(testing_slice)
	fmt.Scanln(&any_input)
}
