package main

import (
	"fmt"
	"net"
	"os"
	"time"
)

const socketPath = "/var/some_socket/server.sock"

func main() {
	// Ensure the socket file is removed if it already exists
	os.Remove(socketPath)

	// Create the Unix socket
	listener, err := net.Listen("unix", socketPath)
	if err != nil {
		fmt.Printf("Error listening on Unix socket: %v\n", err)
		return
	}
	defer listener.Close()

	fmt.Println("Server listening on", socketPath)

	// Accept incoming connections
	for {
		conn, err := listener.Accept()
		if err != nil {
			fmt.Printf("Error accepting connection: %v\n", err)
			continue
		}
		go handleConnection(conn)
	}
}

func handleConnection(conn net.Conn) {
	defer conn.Close()

	// Simulate work
	conn.Write([]byte("Hello from server at " + time.Now().String()))
}

