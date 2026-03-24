package main

import (
	"fmt"
	"log"
)

func main() {
	amount, err := paintNeeded(4.2, -3.0)
	if err != nil {
		log.Fatal(err)
	}
	fmt.Printf("you need: %0.2f l\n", amount)

}
func paintNeeded(width float64, height float64) (float64, error) {
	if width < 0 {
		return 0, fmt.Errorf("Szerokość %.2f jest nieprawidłowa", width)
	}
	if height < 0 {
		return 0, fmt.Errorf("Wysokość %.2f jest nieprawidłowa", height)
	}
	area := width * height
	return area / 10.0, nil
}

// func manyReturns() (int, bool, string) {
// 	return 1, true, "witaj"
// }
