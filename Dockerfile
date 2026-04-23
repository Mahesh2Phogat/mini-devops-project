FROM ubuntu:latest

RUN apt update && apt install -y g++

WORKDIR /app

COPY . .

RUN g++ app.cpp -o app -pthread

EXPOSE 5000

CMD ["./app"]