package main

import "fmt"

func modify(p *bool) {
	*p = false
}

func main() {
	var myBool bool = true
	fmt.Print("przed \n")
	fmt.Println(myBool)
	modify(&myBool)
	fmt.Print("po \n")
	fmt.Println(myBool)
}
