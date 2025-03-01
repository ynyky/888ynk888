package main

import (
	"encoding/json"
	"fmt"
	"io"
	"net/http"
	"os"
	"sync"
)

// User struct
type User struct {
	Name string `json:"name"`
	Age  int    `json:"age"`
}

// File path
const filePath = "users.json"

// Mutex for safe concurrent access
var mu sync.Mutex

// Save users to a file
func saveUsersToFile(users []User) error {
	mu.Lock()
	defer mu.Unlock()

	file, err := os.Create(filePath)
	if err != nil {
		return err
	}
	defer file.Close()

	return json.NewEncoder(file).Encode(users)
}

// Load users from a file
func loadUsersFromFile() ([]User, error) {
	mu.Lock()
	defer mu.Unlock()

	file, err := os.Open(filePath)
	if err != nil {
		return []User{}, err
	}
	defer file.Close()

	var users []User
	if err := json.NewDecoder(file).Decode(&users); err != nil {
		return []User{}, err
	}

	return users, nil
}

// Handle user creation
func createUserHandler(w http.ResponseWriter, r *http.Request) {
	if r.Method != http.MethodPost {
		http.Error(w, "Invalid request method", http.StatusMethodNotAllowed)
		return
	}

	// Read request body
	body, err := io.ReadAll(r.Body)
	if err != nil {
		http.Error(w, "Failed to read request body", http.StatusBadRequest)
		return
	}
	defer r.Body.Close()

	// Convert JSON to struct
	var newUser User
	if err := json.Unmarshal(body, &newUser); err != nil {
		http.Error(w, "Invalid JSON", http.StatusBadRequest)
		return
	}

	// Load existing users, add new user, then save
	users, _ := loadUsersFromFile()
	users = append(users, newUser)
	saveUsersToFile(users)

	// Send response
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusCreated)
	json.NewEncoder(w).Encode(newUser)
}

// Fetch all users
func getUsersHandler(w http.ResponseWriter, r *http.Request) {
	users, _ := loadUsersFromFile()
	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(users)
}

func main() {
	http.HandleFunc("/users", createUserHandler)
	http.HandleFunc("/get-users", getUsersHandler)

	fmt.Println("Server is running on :8080...")
	http.ListenAndServe(":8080", nil)
}
