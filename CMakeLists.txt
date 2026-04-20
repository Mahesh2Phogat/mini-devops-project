cmake_minimum_required(VERSION 3.10)

project(MiniDevOpsApp)

# Set C++ standard
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Find threading support
find_package(Threads REQUIRED)

# Main app
add_executable(app app.cpp)

# Test app
add_executable(test_app test_app.cpp)

# Link threading
target_link_libraries(app Threads::Threads)
target_link_libraries(test_app Threads::Threads)