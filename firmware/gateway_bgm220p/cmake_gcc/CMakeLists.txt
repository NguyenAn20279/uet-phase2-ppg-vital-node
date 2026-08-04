# Define minimal required version of CMake.
cmake_minimum_required(VERSION "3.25")

# Project definition
project(
	BGM220P_OLED_I2C
	VERSION 1.0
	LANGUAGES C CXX ASM
)

# Include the definition of the slc_BGM220P_OLED_I2C target,
# which contains the content of the SLC project
include(BGM220P_OLED_I2C.cmake)

add_executable(BGM220P_OLED_I2C
    # Add additional sources here
    ../ssd1306.c
    ../ssd1306_font.c
)

target_include_directories(BGM220P_OLED_I2C PUBLIC
    # Add additional include paths here
)

target_compile_definitions(BGM220P_OLED_I2C PUBLIC
    # Add additional macros here
)

target_compile_options(BGM220P_OLED_I2C PUBLIC
    # Set additional compiler flags here
)

target_link_options(BGM220P_OLED_I2C PUBLIC
    # Set additional linker flags here
)

# Link with the content defined in the SLC project
target_link_libraries(BGM220P_OLED_I2C PRIVATE
    slc
)

# Include managed project content if available
include(BGM220P_OLED_I2C_project.cmake OPTIONAL RESULT_VARIABLE managed_project)
if(managed_project)
    message(STATUS "Using managed project content from ${managed_project}")
endif()

# Force the gcc linker command
set_target_properties(BGM220P_OLED_I2C PROPERTIES LINKER_LANGUAGE C)

# Create .bin, .hex and .s37 artifacts after building the project
add_custom_command(TARGET BGM220P_OLED_I2C
    POST_BUILD
    COMMAND ${CMAKE_OBJCOPY} ${OBJCOPY_SREC_CMD} "$<TARGET_FILE:BGM220P_OLED_I2C>" "$<TARGET_FILE_DIR:BGM220P_OLED_I2C>/$<TARGET_FILE_BASE_NAME:BGM220P_OLED_I2C>.s37"
    COMMAND ${CMAKE_OBJCOPY} ${OBJCOPY_IHEX_CMD} "$<TARGET_FILE:BGM220P_OLED_I2C>" "$<TARGET_FILE_DIR:BGM220P_OLED_I2C>/$<TARGET_FILE_BASE_NAME:BGM220P_OLED_I2C>.hex"
    COMMAND ${CMAKE_OBJCOPY} ${OBJCOPY_BIN_CMD}  "$<TARGET_FILE:BGM220P_OLED_I2C>" "$<TARGET_FILE_DIR:BGM220P_OLED_I2C>/$<TARGET_FILE_BASE_NAME:BGM220P_OLED_I2C>.bin" 
)

# Run post-build pipeline to perform additional post-processing
if(post_build_command)
add_custom_command(TARGET BGM220P_OLED_I2C
    POST_BUILD
    WORKING_DIRECTORY ${CMAKE_CURRENT_LIST_DIR}/..
    COMMAND ${post_build_command}
)
endif()