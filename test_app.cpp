#include "httplib.h"
#include <iostream>
#include <cassert>

int main() {
    httplib::Client client("localhost", 5000);

    std::cout << "Running tests..." << std::endl;

    // Test 1: home route
    auto res1 = client.Get("/");
    assert(res1 != nullptr);
    assert(res1->status == 200);
    assert(res1->body == "Hello from my C++ DevOps Pipeline!");
    std::cout << "Test 1 PASSED: GET / returns 200" << std::endl;

    // Test 2: health check route
    auto res2 = client.Get("/health");
    assert(res2 != nullptr);
    assert(res2->status == 200);
    assert(res2->body == "OK");
    std::cout << "Test 2 PASSED: GET /health returns OK" << std::endl;

    std::cout << "All tests passed!" << std::endl;
    return 0;
}