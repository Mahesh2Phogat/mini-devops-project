FROM ubuntu:22.04

# Install dependencies (clean + stable)
RUN apt-get update --fix-missing && \
    apt-get install -y g++ && \
    apt-get clean

WORKDIR /app

COPY . .

RUN g++ app.cpp -o app -std=c++17 -pthread

CMD ["./app"]