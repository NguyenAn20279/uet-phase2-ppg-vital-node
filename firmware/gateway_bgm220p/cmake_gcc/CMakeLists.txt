# Define minimal required version of CMake.
cmake_minimum_required(VERSION "3.25")

# Project definition
project(
	gateway_bgm220p
	VERSION 1.0
	LANGUAGES C CXX ASM
)

# Include the definition of the slc_gateway_bgm220p target,
# which contains the content of the SLC project
include(gateway_bgm220p.cmake)

add_executable(gateway_bgm220p
    # Add additional sources here
)

target_include_directories(gateway_bgm220p PUBLIC
    # Add additional include paths here
)

target_compile_definitions(gateway_bgm220p PUBLIC
    # Add additional macros here
)

target_compile_options(gateway_bgm220p PUBLIC
    # Set additional compiler flags here
)

target_link_options(gateway_bgm220p PUBLIC
    # Set additional linker flags here
)

# Link with the content defined in the SLC project
target_link_libraries(gateway_bgm220p PRIVATE
    slc
)

# Include managed project content if available
include(gateway_bgm220p_project.cmake OPTIONAL RESULT_VARIABLE managed_project)
if(managed_project)
    message(STATUS "Using managed project content from ${managed_project}")
endif()

# Force the gcc linker command
set_target_properties(gateway_bgm220p PROPERTIES LINKER_LANGUAGE C)

# Create .bin, .hex and .s37 artifacts after building the project
add_custom_command(TARGET gateway_bgm220p
    POST_BUILD
    COMMAND ${CMAKE_OBJCOPY} ${OBJCOPY_SREC_CMD} "$<TARGET_FILE:gateway_bgm220p>" "$<TARGET_FILE_DIR:gateway_bgm220p>/$<TARGET_FILE_BASE_NAME:gateway_bgm220p>.s37"
    COMMAND ${CMAKE_OBJCOPY} ${OBJCOPY_IHEX_CMD} "$<TARGET_FILE:gateway_bgm220p>" "$<TARGET_FILE_DIR:gateway_bgm220p>/$<TARGET_FILE_BASE_NAME:gateway_bgm220p>.hex"
    COMMAND ${CMAKE_OBJCOPY} ${OBJCOPY_BIN_CMD}  "$<TARGET_FILE:gateway_bgm220p>" "$<TARGET_FILE_DIR:gateway_bgm220p>/$<TARGET_FILE_BASE_NAME:gateway_bgm220p>.bin" 
)

# Run post-build pipeline to perform additional post-processing
if(post_build_command)
add_custom_command(TARGET gateway_bgm220p
    POST_BUILD
    WORKING_DIRECTORY ${CMAKE_CURRENT_LIST_DIR}/..
    COMMAND ${post_build_command}
)
endif()