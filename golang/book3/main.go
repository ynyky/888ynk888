package main
import "fmt"

type subscribe struct {
	rate float64
}

func applyDiscount(s *subscribe) {
	s.rate = 4.99
}
func main() {
	var asd subscribe
	applyDiscount(&asd)
	fmt.Println(asd.rate)
	a := app.NewStruct{Word: "asd"}
	fmt.Println(a.Number)
}