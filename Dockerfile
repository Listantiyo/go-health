FROM golang:1.24-alpine AS builder
WORKDIR /app
COPY go.mod ./
RUN go mod tidy
COPY main.go .
RUN CGO_ENABLED=0 GOOS=linux go build -o server .

FROM alpine:latest
WORKDIR /root/
COPY --from=builder /app/server .
EXPOSE 8080
ENV PORT=8080
CMD ["./server"]