FROM ubuntu:22.04
<<<<<<< HEAD
RUN apt-get update && apt-get install -y g++
WORKDIR /app
COPY . .
RUN g++ app.cpp -o app
CMD ["./app"] 
=======

# Install dependencies (clean + stable)
RUN apt-get update --fix-missing && \
    apt-get install -y g++ && \
    apt-get clean

WORKDIR /app

COPY . .

RUN g++ app.cpp -o app -std=c++17 -pthread

CMD ["./app"]
>>>>>>> d70faac4aa942c5fd61b373150ec7f3a2ee8f0cb
