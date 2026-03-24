package main

import "fmt"

func double(number int) {
	number *= 2
	fmt.Println(number)
}
func main() {
	amount := 6
	double(amount)
	fmt.Println(amount)
}
