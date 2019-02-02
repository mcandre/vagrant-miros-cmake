cmake_minimum_required(VERSION 3.4)

project(hello)

set(EXECUTABLE_OUTPUT_PATH "bin")

if(CMAKE_C_COMPILER_ID MATCHES "clang")
    set(CMAKE_C_FLAGS "-std=c11 -O2 -Wall -Wextra -Wmost -Weverything")
elseif(CMAKE_C_COMPILER_ID MATCHES "gcc")
    set(CMAKE_C_FLAGS "-std=c11 -O2 -Wall -Wextra")
elseif(MSVC)
    set(CMAKE_C_FLAGS "/O2 /W4 /wd4204")
else()
    set(CMAKE_C_FLAGS "-std=c11 -O2 -Wall")
endif()

add_executable(hello lib/hello.c)

enable_testing()

add_test(NAME hellotest COMMAND hello)

add_custom_target(cppcheck COMMAND cppcheck -q --enable=all --suppressions-list=suppressions.cfg --error-exitcode=1 lib)
add_custom_target(cpplint COMMAND sh recur-cpplint.sh)
add_custom_target(splint COMMAND sh recur-splint.sh)
add_custom_target(vera++ COMMAND sh recur-vera++.sh)

# Pending full C99 support
add_custom_target(splint99)

# Missing linter ports
if(
    CMAKE_SYSTEM_NAME MATCHES "Haiku" OR
    CMAKE_SYSTEM_NAME MATCHES "MirBSD" OR
    CMAKE_SYSTEM_NAME MATCHES "SunOS" OR
    "${CMAKE_GNU_C_MACHINE}" MATCHES "uclibc"
)
    add_custom_target(lint DEPENDS)
elseif(CMAKE_SYSTEM_NAME MATCHES "Minix")
    add_custom_target(lint DEPENDS splint99)
elseif(CMAKE_SYSTEM_VERSION MATCHES "HBSD")
    add_custom_target(lint DEPENDS cpplint vera++ splint99)
elseif(
    MSVC OR
    CMAKE_SYSTEM_NAME MATCHES "OpenBSD" OR
    LSB_RELEASE MATCHES "Void"
)
    add_custom_target(lint DEPENDS cppcheck cpplint splint99)
else()
    add_custom_target(lint DEPENDS cppcheck cpplint vera++ splint99)
endif()
