package main

import (
	"fmt"
)

type part struct {
	descritpion string
	count       int
}

func showInfo(p part) {
	fmt.Println("Opis:", p.descritpion)
	fmt.Println("Liczba sztuk:", p.count)
}

func minimumOrder(description string) part {
	var p part
	p.descritpion = description
	p.count = 5
	return p
}

type subscriber struct {
	name   string
	rate   float64
	actibe bool
}

func applyDiscount(s *subscriber) {
	s.rate = 4.99
}

func main() {
	var bolts part
	bolts.descritpion = "Śruba szcześć"
	bolts.count = 24
	showInfo(bolts)
	test := minimumOrder(bolts.descritpion)
	fmt.Println(test.count, test.descritpion)
	var s subscriber
	applyDiscount(&s)
	fmt.Println(s.rate)
}
