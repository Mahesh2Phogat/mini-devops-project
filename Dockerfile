FROM ubuntu:22.04

RUN apt-get update && apt-get install -y g++ cmake

WORKDIR /app

COPY . .

# ❌ REMOVE OLD BUILD CACHE (IMPORTANT FIX)
RUN rm -rf build

# ✅ FRESH BUILD
RUN cmake -B build -S .
RUN cmake --build build

CMD ["./build/app"]