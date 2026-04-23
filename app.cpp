#include "httplib.h"
#include <iostream>
using namespace std;

int main() {
    httplib::Server svr;

    svr.Get("/", [](const httplib::Request&, httplib::Response& res) {
        res.set_content("Calculator Backend Running", "text/plain");
    });

    svr.Get("/add", [](const httplib::Request& req, httplib::Response& res) {
        int a = stoi(req.get_param_value("a"));
        int b = stoi(req.get_param_value("b"));
        res.set_content(to_string(a + b), "text/plain");
    });

    svr.Get("/sub", [](const httplib::Request& req, httplib::Response& res) {
        int a = stoi(req.get_param_value("a"));
        int b = stoi(req.get_param_value("b"));
        res.set_content(to_string(a - b), "text/plain");
    });

    cout << "Server running on port 5000..." << endl;
    svr.listen("0.0.0.0", 5000);
}