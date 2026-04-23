FROM ubuntu:latest

RUN apt update && apt install -y g++ curl

WORKDIR /app

COPY . .

# Download httplib
RUN curl -L https://raw.githubusercontent.com/yhirose/cpp-httplib/master/httplib.h -o httplib.h

RUN g++ app.cpp -o app -pthread

EXPOSE 5000

CMD ["./app"]