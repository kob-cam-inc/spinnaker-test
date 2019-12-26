FROM golang:1.13 as builder
COPY . .
ENV CGO_ENABLED=0
ENV GOOS=linux
ENV GOARCH=amd64
RUN go build -o /app ./src/main.go

FROM alpine:latest
RUN apk add --no-cache ca-certificates
EXPOSE 80
COPY --from=builder /app /app
CMD ["/app"]