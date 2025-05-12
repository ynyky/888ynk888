package main

import (
	"fmt"
	"net"
	"os"
	"time"
)

const socketPath = "/var/some_socket/server.sock"

func main() {
        for {
	// Connect to the Unix socket
	conn, err := net.Dial("unix", socketPath)
	if err != nil {
		fmt.Printf("Error connecting to Unix socket: %v\n", err)
		os.Exit(1)
	}
	defer conn.Close()

	// Read the response from the server
	buf := make([]byte, 1024)
	n, err := conn.Read(buf)
	if err != nil {
		fmt.Printf("Error reading from socket: %v\n", err)
		os.Exit(1)
	}

	// Print the server's response
	fmt.Println("Received from server:", string(buf[:n]))
	time.Sleep(10 * time.Second)
	fmt.Println("connected")
}
}

