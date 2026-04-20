FROM ubuntu:22.04

RUN apt-get update && apt-get install -y g++ cmake

WORKDIR /app

COPY . .

RUN cmake -B build -S .
RUN cmake --build build

CMD ["./build/app"]