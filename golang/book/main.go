package main

import (
	"fmt"
)

var newStruct struct {
	number float64
	word string
	nested struct {
		first string
		serial float64
		enabled bool
	}

}
func test() {
	newStruct.number = 1.234
	newStruct.word = "hello"
	newStruct.nested.first = "first"
	newStruct.nested.serial = 1.234
	newStruct.nested.enabled = true
}
func main() {
	test()
    fmt.Println("Hello, World!")
	fmt.Printf("%v\n",newStruct)
}
