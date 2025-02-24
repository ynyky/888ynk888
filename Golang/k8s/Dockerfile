# Use the official Golang image as the base
FROM golang:1.23-alpine

# Set the working directory inside the container
WORKDIR /app

# Copy the Go script (main.go) into the container
ADD podlist1 app


# Install dependencies (if any) and build the Go application
WORKDIR /app/app
RUN go mod init my-k8s-app
RUN go mod tidy
RUN go get k8s.io/client-go@latest
RUN go get k8s.io/apimachinery@latest
# Run the Go script when the container starts
CMD ["go", "run", "main.go"]