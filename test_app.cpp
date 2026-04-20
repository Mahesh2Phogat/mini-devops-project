#include <iostream>

int main() {
    std::cout << "Test running..." << std::endl;

    if (1 + 1 == 2) {
        std::cout << "Test PASSED" << std::endl;
        return 0;
    } else {
        std::cout << "Test FAILED" << std::endl;
        return 1;
    }
}