FROM golang:alpine as builder
RUN apk add --no-cache git curl make ca-certificates gcc libtool musl-dev
RUN mkdir /app
ADD . /app
WORKDIR /app
RUN make build

FROM alpine
WORKDIR /
COPY --from=builder /app/bin/penguin-api .
ENTRYPOINT ["./penguin-api"]