FROM golang:1.16.3 AS builder

WORKDIR /kine
COPY . .
ENV GO111MODULE=on
RUN go build -o kine

FROM alpine:3.13.4

WORKDIR /

COPY --from=builder /kine/kine /bin/kine