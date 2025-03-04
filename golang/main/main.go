package main

import (
	"fmt"

	"example.com/hello"
)

func main() {
	// Get a greeting message and print it.
	message := hello.Hello("Gladys")
	fmt.Println(message)
}
