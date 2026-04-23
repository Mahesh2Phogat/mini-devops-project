FROM ubuntu:22.04

RUN apt-get update && apt-get install -y g++

WORKDIR /app

COPY . .

RUN g++ app.cpp -o app

CMD ["./app"]