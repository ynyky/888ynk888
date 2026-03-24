package main

import (
	"fmt"
	"log"

	"example.com/myapp/src/github.com/firstgo/datafile"
)

func main() {
	numbers, err := datafile.GetFloats("data.txt")
	if err != nil {
		log.Fatal(err)
	}
	var sum float64
	for _, number := range numbers {
		sum += number
	}
	sampleCount := float64(len(numbers))
	fmt.Printf("avarage: %0.2f.\n", sum/sampleCount)
}
