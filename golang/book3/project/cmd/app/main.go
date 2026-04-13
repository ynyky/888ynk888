package app
import (
	"fmt"
)
type NewStruct struct {
	Number float64
	Word string
	Nested struct {
		First string
		Serial  float64
		Enabled bool
	}
}
type TestStruct struct {
	Name string
}
func TestRun() {
	fmt.Println("test")
}
