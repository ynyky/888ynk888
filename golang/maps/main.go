package main 
import (
	"fmt"
	"log"
	"github.com/ynyky/maps/src/github.com/datafile"
)
func main() {
	var counts map[string]int
	counts = make(map[string]int)
	lines, err := datafile.GetStrings("votes.txt")
	if err != nil {
		log.Fatal(err)
	}
	for _ , value := range lines {
		counts[value]++
	}
	fmt.Println(counts)
	for name, count := range counts {
		fmt.Printf("%s - votes number - %d.\n", name, count)
	}
}