cmake_minimum_required(VERSION 3.10)
project(mini_devops_app)

set(CMAKE_CXX_STANDARD 17)

# Main app
add_executable(app app.cpp)
target_include_directories(app PRIVATE .)

# Test binary
add_executable(test_app test_app.cpp)
target_include_directories(test_app PRIVATE .)

# Link threads (required by httplib)
find_package(Threads REQUIRED)
target_link_libraries(app Threads::Threads)
target_link_libraries(test_app Threads::Threads)