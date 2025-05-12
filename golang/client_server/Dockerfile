FROM golang:1.19-alpine as build

# Set the working directory
WORKDIR /app

# Copy the Go source code
COPY . .

# Build both the server and client
RUN go build -o server ./server.go
RUN go build -o client ./client.go

# Create a minimal image for runtime
FROM alpine:latest

# Copy the compiled server and client binaries
COPY --from=build /app/server /usr/local/bin/server
COPY --from=build /app/client /usr/local/bin/client

# Create the directory for the Unix socket
RUN mkdir -p /var/some_socket

# Start the server and client as entrypoint processes (sidecars)
ENTRYPOINT ["/bin/sh", "-c", "server & client"]

