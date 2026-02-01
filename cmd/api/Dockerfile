FROM golang:1.25.1-alpine AS build
RUN apk add --no-cache curl libstdc++ libgcc

WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

COPY . .

RUN go build -o api cmd/api/main.go

FROM alpine:3.20.1 AS prod
WORKDIR /app
COPY --from=build /app/api /app/api
EXPOSE ${PORT}
CMD ["./api"]


