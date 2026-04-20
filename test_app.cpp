#include <iostream>
using namespace std;

int add(int a, int b) { return a + b; }
int sub(int a, int b) { return a - b; }

int main() {
    cout << "Running tests...\n";

    if(add(2,3) == 5 && sub(5,3) == 2) {
        cout << "All tests PASSED\n";
        return 0;
    } else {
        cout << "Tests FAILED\n";
        return 1;
    }
}