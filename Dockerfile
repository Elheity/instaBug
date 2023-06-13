# Use a specific version of the base image
FROM golang:1.16.6-alpine3.14 AS builder

# Set the working directory inside the container
WORKDIR /app

# Copy the Go modules files to the working directory
COPY go.mod go.sum ./

# Download the Go module dependencies
RUN go mod download

# Copy the rest of the application source code to the working directory
COPY . .

# Build the Go application
RUN CGO_ENABLED=0 go build -o main .

# Create a minimal runtime image
FROM alpine:3.14

# Create a non-root user and set proper permissions
RUN adduser -D -g 'ahmed' myuser
USER myuser

# Copy the built application from the builder stage
COPY --from=builder /app/main /app/main

# Set environment variables for MySQL connection
ENV MYSQL_HOST=4.246.151.92
ENV MYSQL_USER=instabug
ENV MYSQL_PASS=instabug
ENV MYSQL_PORT=3306

# Expose the port on which the application will listen
EXPOSE 9090

# Start the Go application when the container starts
CMD go run main.go db.go
