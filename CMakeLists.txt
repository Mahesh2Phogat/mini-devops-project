cmake_minimum_required(VERSION 3.10)

project(MiniDevOpsApp)

# Force C++17
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Add compile flags manually (IMPORTANT for old MinGW)
add_compile_options(-std=gnu++17 -pthread)

# Threads
find_package(Threads REQUIRED)

# Executables
add_executable(app app.cpp)
add_executable(test_app test_app.cpp)

# Link libraries
target_link_libraries(app Threads::Threads ws2_32)
target_link_libraries(test_app Threads::Threads ws2_32)