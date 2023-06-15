# Use a specific version of the base image
FROM golang:1.16.6-alpine3.14 AS builder

FROM golang:1.18-alpine AS build

RUN apk update && apk upgrade

WORKDIR /app

COPY go.mod go.sum ./

RUN go mod download

COPY . .

RUN CGO_ENABLED=0 go build -o main .


FROM alpine:3.14

RUN apk update && apk upgrade

# Install Go in the final stage
RUN apk add --no-cache go

WORKDIR /app

COPY --from=build /app/main .

RUN addgroup -S myapi && adduser -S -G myapi myapiuser

USER myapiuser

# Set environment variables for MySQL connection
ENV MYSQL_HOST=4.246.151.92
ENV MYSQL_USER=instabug
ENV MYSQL_PASS=instabug
ENV MYSQL_PORT=3306

# Expose the port on which the application will listen
EXPOSE 9090

# Start the Go application when the container starts
CMD ["./main"]
