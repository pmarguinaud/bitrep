cmake_minimum_required(VERSION 3.16)
project(bitrep LANGUAGES Fortran CXX)

add_executable(br_main.cpu.x
	br_main.F90
	br_transcendentals.cpp
	br_intrinsics.F90
	parkind1.F90
)
target_compile_definitions(br_main.cpu.x PUBLIC ARCH="cpu")
set_property(TARGET br_main.cpu.x PROPERTY LINKER_LANGUAGE Fortran)

find_package(OpenACC)
if(${OpenACC_CXX_FOUND})
	add_executable(br_main.gpu.x
		br_main.F90
		br_transcendentals.cpp
		br_intrinsics.F90
		parkind1.F90
	)
	target_compile_definitions(br_main.gpu.x PUBLIC ARCH="gpu")
	target_compile_options(br_main.gpu.x PUBLIC -acc=gpu)
	target_link_libraries(br_main.gpu.x PUBLIC OpenACC::OpenACC_Fortran)
	set_property(TARGET br_main.gpu.x PROPERTY LINKER_LANGUAGE Fortran)
endif()
