FROM ubuntu:22.04

# Fix DNS + retry issues
RUN apt-get update --fix-missing && \
    apt-get install -y --no-install-recommends g++ && \
    apt-get clean

WORKDIR /app

COPY . .

RUN g++ app.cpp -o app -std=c++17 -pthread

CMD ["./app"]