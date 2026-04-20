# Stage 1: Build the app
FROM gcc:12 AS builder

WORKDIR /app

COPY app.cpp .
COPY httplib.h .
COPY CMakeLists.txt .

RUN apt-get update && apt-get install -y cmake
RUN cmake -B build -S .
RUN cmake --build build

# Stage 2: Run the app
FROM debian:bookworm-slim

WORKDIR /app

COPY --from=builder /app/build/app .

EXPOSE 5000
CMD ["./app"]