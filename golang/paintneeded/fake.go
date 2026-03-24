package main

import (
	"fmt"
	"math"
)

func floatParts(nubmer float64) (integerPart int, fractionPart float64) {
	wholeNqumber := math.Floor(nubmer)
	return int(wholeNumber), nubmer - wholeNumber
}

func main() {
	cans, remainder := floatParts(1.26)
	fmt.Println(cans, remainder)
}
