package main

import (
	"database/sql"
	"encoding/json"
	"fmt"
	"io"
	"net/http"

	_ "github.com/mattn/go-sqlite3"
)

// User struct
type User struct {
	Name string `json:"name"`
	Age  int    `json:"age"`
}

// Initialize database
func initDB() *sql.DB {
	db, err := sql.Open("sqlite3", "users.db")
	if err != nil {
		panic(err)
	}

	// Create table if it doesn't exist
	_, err = db.Exec("CREATE TABLE IF NOT EXISTS users (name TEXT, age INTEGER)")
	if err != nil {
		panic(err)
	}

	return db
}

// Insert user into the database
func insertUser(db *sql.DB, user User) {
	_, err := db.Exec("INSERT INTO users (name, age) VALUES (?, ?)", user.Name, user.Age)
	if err != nil {
		fmt.Println("Error inserting user:", err)
	}
}

// Fetch users from database
func getUsers(db *sql.DB) []User {
	rows, err := db.Query("SELECT name, age FROM users")
	if err != nil {
		fmt.Println("Error fetching users:", err)
		return nil
	}
	defer rows.Close()

	var users []User
	for rows.Next() {
		var user User
		rows.Scan(&user.Name, &user.Age)
		users = append(users, user)
	}
	return users
}

// Handle POST request
func createUserHandler(db *sql.DB) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		if r.Method != http.MethodPost {
			http.Error(w, "Invalid request method", http.StatusMethodNotAllowed)
			return
		}

		body, err := io.ReadAll(r.Body)
		if err != nil {
			http.Error(w, "Failed to read request body", http.StatusBadRequest)
			return
		}
		defer r.Body.Close()

		var newUser User
		if err := json.Unmarshal(body, &newUser); err != nil {
			http.Error(w, "Invalid JSON", http.StatusBadRequest)
			return
		}

		insertUser(db, newUser)

		w.Header().Set("Content-Type", "application/json")
		w.WriteHeader(http.StatusCreated)
		json.NewEncoder(w).Encode(newUser)
	}
}

// Handle GET request
func getUsersHandler(db *sql.DB) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		users := getUsers(db)
		w.Header().Set("Content-Type", "application/json")
		json.NewEncoder(w).Encode(users)
	}
}

func main() {
	db := initDB()
	defer db.Close()

	http.HandleFunc("/users", createUserHandler(db))
	http.HandleFunc("/get-users", getUsersHandler(db))

	fmt.Println("Server is running on :8080...")
	http.ListenAndServe(":8080", nil)
}
