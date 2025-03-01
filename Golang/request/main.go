package main

import (
	"bytes"
	"encoding/json"
	"fmt"
	"io"
	"net/http"
)

type User struct {
	Name string `json:"name"`
	Age  int    `json:"age"`
}

func main() {
	user := User{Name: "Alice", Age: 25}

	// Convert struct to JSON
	jsonData, err := json.Marshal(user)
	if err != nil {
		fmt.Println("Error encoding JSON:", err)
		return
	}

	// Send POST request
	resp, err := http.Post("http://localhost:8080/users",
		"application/json", bytes.NewBuffer(jsonData))
	if err != nil {
		fmt.Println("Error:", err)
		return
	}
	defer resp.Body.Close()

	// Read response
	body, _ := io.ReadAll(resp.Body)
	fmt.Println("Response:", string(body))
}
