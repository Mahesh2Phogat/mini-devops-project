#include "httplib.h"
#include <iostream>

int main() {
    httplib::Server server;

    server.Get("/", [](const httplib::Request& req, httplib::Response& res) {
        res.set_content("Hello from my C++ DevOps Pipeline!", "text/plain");
    });

    server.Get("/health", [](const httplib::Request& req, httplib::Response& res) {
        res.set_content("OK", "text/plain");
    });

    std::cout << "Server running on port 5000..." << std::endl;
    server.listen("0.0.0.0", 5000);

    return 0;
}