FROM golang:1.8 

# Create and set working directory
WORKDIR /go/src/github.com/hgsat123/bringon

ADD . .
RUN go get -u github.com/golang/dep/cmd/dep
RUN dep ensure -vendor-only
RUN CGO_ENABLED=0 GOOS=linux go build -o bringon
 
FROM alpine:latest
RUN apk --no-cache add ca-certificates
WORKDIR /root/
EXPOSE 8091
#COPY /go/src/github.com/hgsat123/bringon/bringon .
CMD ["./bringon"]
