FROM ubuntu:22.04

RUN apt-get update && apt-get install -y g++ make

WORKDIR /app

COPY . .

RUN g++ app.cpp -o app -std=c++17 -pthread

CMD ["./app"]