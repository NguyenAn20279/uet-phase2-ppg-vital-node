# Define minimal required version of CMake.
cmake_minimum_required(VERSION "3.25")

# Project definition
project(
	new_soc_empty_freertos
	VERSION 1.0
	LANGUAGES C CXX ASM
)
add_compile_options(-mfp16-format=ieee)
# Include the definition of the slc_new_soc_empty_freertos target,
# which contains the content of the SLC project
include(new_soc_empty_freertos.cmake)

add_executable(new_soc_empty_freertos
    # Add additional sources here
    ../max30102.c
    ../ppg_task.c
    ../ai_task.c
    ../filter_task.c
    ../filter.c
    ../bluetooth_data_task.c
    ../vitals.c
    ../app_ml.cpp
)

target_include_directories(new_soc_empty_freertos PUBLIC
    # Add additional include paths here
)

target_compile_definitions(new_soc_empty_freertos PUBLIC
    # Add additional macros here
)

target_compile_options(new_soc_empty_freertos PUBLIC
    # Set additional compiler flags here
)

target_link_options(new_soc_empty_freertos PUBLIC
    # Set additional linker flags here
    -u _printf_float
)

# Link with the content defined in the SLC project
target_link_libraries(new_soc_empty_freertos PRIVATE
    slc
)

# Include managed project content if available
include(new_soc_empty_freertos_project.cmake OPTIONAL RESULT_VARIABLE managed_project)
if(managed_project)
    message(STATUS "Using managed project content from ${managed_project}")
endif()

# Force the gcc linker command
set_target_properties(new_soc_empty_freertos PROPERTIES LINKER_LANGUAGE C)

# Create .bin, .hex and .s37 artifacts after building the project
add_custom_command(TARGET new_soc_empty_freertos
    POST_BUILD
    COMMAND ${CMAKE_OBJCOPY} ${OBJCOPY_SREC_CMD} "$<TARGET_FILE:new_soc_empty_freertos>" "$<TARGET_FILE_DIR:new_soc_empty_freertos>/$<TARGET_FILE_BASE_NAME:new_soc_empty_freertos>.s37"
    COMMAND ${CMAKE_OBJCOPY} ${OBJCOPY_IHEX_CMD} "$<TARGET_FILE:new_soc_empty_freertos>" "$<TARGET_FILE_DIR:new_soc_empty_freertos>/$<TARGET_FILE_BASE_NAME:new_soc_empty_freertos>.hex"
    COMMAND ${CMAKE_OBJCOPY} ${OBJCOPY_BIN_CMD}  "$<TARGET_FILE:new_soc_empty_freertos>" "$<TARGET_FILE_DIR:new_soc_empty_freertos>/$<TARGET_FILE_BASE_NAME:new_soc_empty_freertos>.bin" 
)

# Run post-build pipeline to perform additional post-processing
if(post_build_command)
add_custom_command(TARGET new_soc_empty_freertos
    POST_BUILD
    WORKING_DIRECTORY ${CMAKE_CURRENT_LIST_DIR}/..
    COMMAND ${post_build_command}
)
endif()