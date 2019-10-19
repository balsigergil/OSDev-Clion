cmake_minimum_required(VERSION 3.15)
project(MyOS)

set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_SYSTEM_PROCESSOR i686)

ENABLE_LANGUAGE(ASM)

set(TOOLS $ENV{HOME}/opt/cross)
set(CMAKE_C_COMPILER ${TOOLS}/bin/i686-elf-gcc)
set(CMAKE_CXX_COMPILER ${TOOLS}/bin/i686-elf-g++)
set(CMAKE_ASM_COMPILER ${TOOLS}/bin/i686-elf-as)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_C_STANDARD 11)
set(CMAKE_CXX_FLAGS "-ffreestanding -O2 -Wall -Wextra -fno-exceptions -fno-rtti")
set(CMAKE_C_FLAGS "-ffreestanding -O2 -Wall -Wextra")

add_library(mylib mylib.c)

add_executable(MyOS.bin boot.s kernel.cpp mylib)
set_target_properties(MyOS.bin PROPERTIES LINK_FLAGS "-T ${CMAKE_SOURCE_DIR}/linker.ld -ffreestanding -O2 -nostdlib -lgcc")

add_custom_target(MyOS.iso ALL
        COMMAND ./generate-iso.sh
        COMMENT "Generating the kernel bootable iso file"
        WORKING_DIRECTORY ${CMAKE_SOURCE_DIR})
add_dependencies(MyOS.iso MyOS.bin)
