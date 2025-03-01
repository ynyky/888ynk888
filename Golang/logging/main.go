package main

import "fmt"

// Function that takes a pointer to an array of integers
func modifyArray(arr *[3]int) {
	arr[0] = 10
	arr[1] = 20
	arr[2] = 30
}

func main() {
	// Declare an array
	nums := [3]int{1, 2, 3}

	fmt.Println("Before:", nums)

	// Pass pointer to the array
	modifyArray(&nums)

	fmt.Println("After:", nums) // [10 20 30]
}
