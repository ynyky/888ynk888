package main

import (
	"fmt"
	"github.com/example.com/magazine/cmd/app"
	"github.com/example.com/magazine/cmd/app1"
)
func main() {
	app.TestRun()
	var asd app.TestStruct
	asd.Name = "test"
	fmt.Println(asd.Name)
	a := app.NewStruct{Word: "asd"}
	fmt.Println(a.Nested.First)
	lol := app1.Address{Street: "123 Main St", City: "Anytown", State: "CA", PostalCode: "12345"}
	fmt.Println(lol)
	subscribe := app1.Subscribe{Rate: 123, Name: "Doe", Active: true, Address: lol}
	fmt.Println(subscribe)
}