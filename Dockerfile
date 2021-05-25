FROM golang:1.16.3 AS builder

WORKDIR /kine
COPY . .
ENV GO111MODULE=on
RUN ./scripts/build

FROM alpine:latest

WORKDIR /

COPY --from=builder /kine/bin/kine /bin/kine

CMD [ "/bin/kine" ]