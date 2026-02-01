FROM golang:1.25.1-alpine AS build
RUN apk add --no-cache curl libstdc++ libgcc

WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

COPY . .

RUN go build -o telegram cmd/telegram/main.go

FROM alpine:3.20.1 AS prod
WORKDIR /app
COPY --from=build /app/telegram /app/telegram
EXPOSE ${PORT}
CMD ["./telegram"]


