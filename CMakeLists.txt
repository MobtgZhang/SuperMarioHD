cmake_minimum_required(VERSION 2.6)
project(source)

# Use our modified FindSDL2* modules
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${PROJECT_SOURCE_DIR}/cmake")
set(BIN_DIR ${PROJECT_SOURCE_DIR}/bin)


# Bump up warning levels appropriately for clang, gcc & msvc and build in debug mode
if (${CMAKE_CXX_COMPILER_ID} STREQUAL "GNU" OR ${CMAKE_CXX_COMPILER_ID} STREQUAL "Clang")
	set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall -Wextra -pedantic -std=c++11")
	set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS} -g")
	set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS} -O2")
elseif (${CMAKE_CXX_COMPILER_ID} STREQUAL "MSVC")
	if (CMAKE_CXX_FLAGS MATCHES "/W[0-4]")
		string(REGEX REPLACE "/W[0-4]" "/W4" CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS}")
	else()
		set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /W4")
	endif()
endif()

find_package(sfml-system REQUIRED)
find_package(sfml-window REQUIRED)
find_package(sfml-graphics REQUIRED)
find_package(sfml-audio REQUIRED)
find_package(tinyxml2 REQUIRED)
include_directories(${SFML_SYSTEM_INCLUDE_DIR} ${SFML_WINDOW_INCLUDE_DIR}
                ${SFML_GRAPHICS_INCLUDE_DIR} ${SFML_AUDIO_INCLUDE_DIR} ${TINYXML2_INCLUDE_DIR})

file(COPY res DESTINATION .)

include_directories(source)

file(GLOB_RECURSE uMarioHD_SOURCES "source/*.cpp")
add_executable (uMarioHD ${uMarioHD_SOURCES})

target_link_libraries(uMarioHD ${SFML_SYSTEM_LIBRARY} ${SFML_AUDIO_LIBRARY} ${SFML_WINDOW_LIBRARY} ${SFML_GRAPHICS_LIBRARY} ${TINYXML2_LIBRARY})

install(TARGETS uMarioHD RUNTIME DESTINATION ${BIN_DIR})
