FROM golang:1.7.3 AS builder

# Create and set working directory
RUN mkdir -p /go/src/github.com/hgsat123/bringon
WORKDIR /go/src/github.com/hgsat123/bringon

ADD . .
RUN go get -u github.com/golang/dep/cmd/dep && dep ensure
RUN CGO_ENABLED=0 GOOS=linux go build -o bringon
 
FROM alpine:latest
RUN apk --no-cache add ca-certificates
WORKDIR /root/
EXPOSE 8091
COPY --from=builder /go/src/github.com/hgsat123/bringon/bringon .
CMD ["./bringon"]
