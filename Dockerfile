FROM ubuntu:22.04

# Fix DNS issue
RUN echo "nameserver 8.8.8.8" > /etc/resolv.conf

# Install dependencies
RUN apt-get update --fix-missing && \
    apt-get install -y g++ --fix-missing && \
    apt-get clean

# Set working directory
WORKDIR /app

# Copy files
COPY . .

# Compile C++ app
RUN g++ app.cpp -o app -std=c++17 -pthread

# Run app
CMD ["./app"]