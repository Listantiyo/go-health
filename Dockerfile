FROM golang:1.26.3-alpine AS builder
WORKDIR /app
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -o health .

FROM alpine:3.22.4
WORKDIR /root/
COPY --from=builder /app/health .
CMD ["./health"]