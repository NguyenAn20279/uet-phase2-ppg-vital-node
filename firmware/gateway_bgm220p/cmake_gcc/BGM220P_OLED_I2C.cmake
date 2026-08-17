####################################################################
# Automatically-generated file. Do not edit!                       #
####################################################################

set(SDK_PATH "C:/Users/Admin/.silabs/slt/installs/conan/p/simpl508ee6c1a6569/p")
set(COPIED_SDK_PATH "simplicity_sdk_2026.6.0")
set(PKG_PATH "C:/Users/Admin/.silabs/slt/installs")

add_library(slc OBJECT
    "../${COPIED_SDK_PATH}/boards/hardware/board/src/sl_board_control_gpio.c"
    "../${COPIED_SDK_PATH}/boards/hardware/board/src/sl_board_init.c"
    "../${COPIED_SDK_PATH}/platform_core/app/common/util/app_log/app_log.c"
    "../${COPIED_SDK_PATH}/platform_core/hardware/driver/configuration_over_swo/src/sl_cos.c"
    "../${COPIED_SDK_PATH}/platform_core/platform/common/src/sl_assert.c"
    "../${COPIED_SDK_PATH}/platform_core/platform/common/src/sl_core_cortexm.c"
    "../${COPIED_SDK_PATH}/platform_core/platform/common/src/sl_slist.c"
    "../${COPIED_SDK_PATH}/platform_core/platform/common/src/sl_string.c"
    "../${COPIED_SDK_PATH}/platform_core/platform/common/src/sl_syscalls.c"
    "../${COPIED_SDK_PATH}/platform_core/platform/Device/SiliconLabs/BGM22/Source/startup_bgm22.c"
    "../${COPIED_SDK_PATH}/platform_core/platform/Device/SiliconLabs/BGM22/Source/system_bgm22.c"
    "../${COPIED_SDK_PATH}/platform_core/platform/driver/debug/src/sl_debug_swo.c"
    "../${COPIED_SDK_PATH}/platform_core/platform/driver/dma_channel/src/sl_dma_channel.c"
    "../${COPIED_SDK_PATH}/platform_core/platform/driver/dma_channel/src/sl_dma_descriptor_allocator.c"
    "../${COPIED_SDK_PATH}/platform_core/platform/driver/gpio/src/sl_gpio.c"
    "../${COPIED_SDK_PATH}/platform_core/platform/driver/i2c/src/sl_i2c.c"
    "../${COPIED_SDK_PATH}/platform_core/platform/driver/i2cspm/src/sl_i2cspm.c"
    "../${COPIED_SDK_PATH}/platform_core/platform/emlib/src/em_burtc.c"
    "../${COPIED_SDK_PATH}/platform_core/platform/emlib/src/em_cmu.c"
    "../${COPIED_SDK_PATH}/platform_core/platform/emlib/src/em_emu.c"
    "../${COPIED_SDK_PATH}/platform_core/platform/emlib/src/em_gpio.c"
    "../${COPIED_SDK_PATH}/platform_core/platform/emlib/src/em_i2c.c"
    "../${COPIED_SDK_PATH}/platform_core/platform/emlib/src/em_msc.c"
    "../${COPIED_SDK_PATH}/platform_core/platform/emlib/src/em_rtcc.c"
    "../${COPIED_SDK_PATH}/platform_core/platform/emlib/src/em_system.c"
    "../${COPIED_SDK_PATH}/platform_core/platform/emlib/src/em_timer.c"
    "../${COPIED_SDK_PATH}/platform_core/platform/emlib/src/em_usart.c"
    "../${COPIED_SDK_PATH}/platform_core/platform/peripheral/src/sl_hal_gpio.c"
    "../${COPIED_SDK_PATH}/platform_core/platform/peripheral/src/sl_hal_i2c.c"
    "../${COPIED_SDK_PATH}/platform_core/platform/peripheral/src/sl_hal_ldma.c"
    "../${COPIED_SDK_PATH}/platform_core/platform/peripheral/src/sl_hal_syscfg.c"
    "../${COPIED_SDK_PATH}/platform_core/platform/peripheral/src/sl_hal_system.c"
    "../${COPIED_SDK_PATH}/platform_core/platform/service/clock_manager/src/sl_clock_manager.c"
    "../${COPIED_SDK_PATH}/platform_core/platform/service/clock_manager/src/sl_clock_manager_hal_s2.c"
    "../${COPIED_SDK_PATH}/platform_core/platform/service/clock_manager/src/sl_clock_manager_init.c"
    "../${COPIED_SDK_PATH}/platform_core/platform/service/clock_manager/src/sl_clock_manager_init_hal_s2.c"
    "../${COPIED_SDK_PATH}/platform_core/platform/service/device_init/src/sl_device_init_dcdc_s2.c"
    "../${COPIED_SDK_PATH}/platform_core/platform/service/device_init/src/sl_device_init_emu_s2.c"
    "../${COPIED_SDK_PATH}/platform_core/platform/service/device_manager/clocks/sl_device_clock_efr32xg22.c"
    "../${COPIED_SDK_PATH}/platform_core/platform/service/device_manager/devices/sl_device_peripheral_hal_efr32xg22.c"
    "../${COPIED_SDK_PATH}/platform_core/platform/service/device_manager/dma/sl_device_dma_s2.c"
    "../${COPIED_SDK_PATH}/platform_core/platform/service/device_manager/src/sl_device_clock.c"
    "../${COPIED_SDK_PATH}/platform_core/platform/service/device_manager/src/sl_device_dma.c"
    "../${COPIED_SDK_PATH}/platform_core/platform/service/device_manager/src/sl_device_gpio.c"
    "../${COPIED_SDK_PATH}/platform_core/platform/service/device_manager/src/sl_device_peripheral.c"
    "../${COPIED_SDK_PATH}/platform_core/platform/service/dma_manager/src/sl_dma_manager.c"
    "../${COPIED_SDK_PATH}/platform_core/platform/service/dma_manager/src/sl_dma_manager_hal_ldma.c"
    "../${COPIED_SDK_PATH}/platform_core/platform/service/interrupt_manager/src/sl_interrupt_manager_cortexm.c"
    "../${COPIED_SDK_PATH}/platform_core/platform/service/iostream/src/sl_iostream.c"
    "../${COPIED_SDK_PATH}/platform_core/platform/service/iostream/src/sl_iostream_dmadrv.c"
    "../${COPIED_SDK_PATH}/platform_core/platform/service/iostream/src/sl_iostream_retarget_stdio.c"
    "../${COPIED_SDK_PATH}/platform_core/platform/service/iostream/src/sl_iostream_stdlib_config.c"
    "../${COPIED_SDK_PATH}/platform_core/platform/service/iostream/src/sl_iostream_uart.c"
    "../${COPIED_SDK_PATH}/platform_core/platform/service/iostream/src/sl_iostream_usart.c"
    "../${COPIED_SDK_PATH}/platform_core/platform/service/memory_manager/src/sl_memory_manager.c"
    "../${COPIED_SDK_PATH}/platform_core/platform/service/memory_manager/src/sl_memory_manager_dynamic_reservation.c"
    "../${COPIED_SDK_PATH}/platform_core/platform/service/memory_manager/src/sl_memory_manager_pool.c"
    "../${COPIED_SDK_PATH}/platform_core/platform/service/memory_manager/src/sl_memory_manager_pool_common.c"
    "../${COPIED_SDK_PATH}/platform_core/platform/service/memory_manager/src/sl_memory_manager_region.c"
    "../${COPIED_SDK_PATH}/platform_core/platform/service/memory_manager/src/sl_memory_manager_retarget.c"
    "../${COPIED_SDK_PATH}/platform_core/platform/service/memory_manager/src/sli_memory_manager_common.c"
    "../${COPIED_SDK_PATH}/platform_core/platform/service/sl_main/src/sl_main_init.c"
    "../${COPIED_SDK_PATH}/platform_core/platform/service/sl_main/src/sl_main_init_memory.c"
    "../${COPIED_SDK_PATH}/platform_core/platform/service/sl_main/src/sl_main_process_action.c"
    "../${COPIED_SDK_PATH}/platform_core/platform/service/sleeptimer/src/sl_sleeptimer.c"
    "../${COPIED_SDK_PATH}/platform_core/platform/service/sleeptimer/src/sl_sleeptimer_hal_burtc.c"
    "../${COPIED_SDK_PATH}/platform_core/platform/service/sleeptimer/src/sl_sleeptimer_hal_prortc.c"
    "../${COPIED_SDK_PATH}/platform_core/platform/service/sleeptimer/src/sl_sleeptimer_hal_rtcc.c"
    "../${COPIED_SDK_PATH}/platform_core/platform/service/sleeptimer/src/sl_sleeptimer_hal_timer.c"
    "../${COPIED_SDK_PATH}/platform_core/platform/service/udelay/src/sl_udelay.c"
    "../${COPIED_SDK_PATH}/platform_core/platform/service/udelay/src/sl_udelay_armv6m_gcc.S"
    "../app.c"
    "../autogen/sl_board_default_init.c"
    "../autogen/sl_dma_manager_instances.c"
    "../autogen/sl_event_handler.c"
    "../autogen/sl_i2cspm_init.c"
    "../autogen/sl_iostream_handles.c"
    "../autogen/sl_iostream_init_usart_instances.c"
    "../main.c"
)

target_include_directories(slc PUBLIC
   "../config"
   "../autogen"
   "../."
    "../${COPIED_SDK_PATH}/platform_core/platform/Device/SiliconLabs/BGM22/Include"
    "../${COPIED_SDK_PATH}/platform_core/app/common/util/app_log"
    "../${COPIED_SDK_PATH}/platform_core/platform/common/inc"
    "../${COPIED_SDK_PATH}/boards/hardware/board/inc"
    "../${COPIED_SDK_PATH}/platform_core/platform/service/clock_manager/inc"
    "../${COPIED_SDK_PATH}/platform_core/platform/service/clock_manager/src"
    "../${COPIED_SDK_PATH}/cmsis/Core/Include"
    "../${COPIED_SDK_PATH}/cmsis/Core/Include/m-profile"
    "../${COPIED_SDK_PATH}/cmsis/Core/Include/a-profile"
    "../${COPIED_SDK_PATH}/platform_core/hardware/driver/configuration_over_swo/inc"
    "../${COPIED_SDK_PATH}/platform_core/platform/driver/debug/inc"
    "../${COPIED_SDK_PATH}/platform_core/platform/service/device_manager/inc"
    "../${COPIED_SDK_PATH}/platform_core/platform/service/device_init/inc"
    "../${COPIED_SDK_PATH}/platform_core/platform/driver/dma_channel/inc"
    "../${COPIED_SDK_PATH}/platform_core/platform/service/dma_manager/inc"
    "../${COPIED_SDK_PATH}/platform_core/platform/service/dma_manager/src"
    "../${COPIED_SDK_PATH}/platform_core/platform/emlib/inc"
    "../${COPIED_SDK_PATH}/platform_core/platform/common/errno_error_codes/inc"
    "../${COPIED_SDK_PATH}/platform_core/platform/driver/gpio/inc"
    "../${COPIED_SDK_PATH}/platform_core/platform/peripheral/inc"
    "../${COPIED_SDK_PATH}/platform_core/platform/driver/i2c/inc"
    "../${COPIED_SDK_PATH}/platform_core/platform/driver/i2c/src"
    "../${COPIED_SDK_PATH}/platform_core/platform/driver/i2cspm/inc"
    "../${COPIED_SDK_PATH}/platform_core/platform/service/interrupt_manager/inc"
    "../${COPIED_SDK_PATH}/platform_core/platform/service/interrupt_manager/src"
    "../${COPIED_SDK_PATH}/platform_core/platform/service/interrupt_manager/inc/arm"
    "../${COPIED_SDK_PATH}/platform_core/platform/service/iostream/inc"
    "../${COPIED_SDK_PATH}/platform_core/platform/service/memory_manager/inc"
    "../${COPIED_SDK_PATH}/platform_core/platform/service/memory_manager/src"
    "../${COPIED_SDK_PATH}/platform_core/platform/service/sl_main/inc"
    "../${COPIED_SDK_PATH}/platform_core/platform/service/sl_main/src"
    "../${COPIED_SDK_PATH}/platform_core/platform/service/sleeptimer/inc"
    "../${COPIED_SDK_PATH}/platform_core/platform/service/sleeptimer/src"
    "../${COPIED_SDK_PATH}/platform_core/platform/service/udelay/inc"
)

target_compile_definitions(slc PUBLIC
    "DEBUG_EFM=1"
    "BGM220PC22HNA=1"
    "SL_CODE_COMPONENT_SYSTEM=system"
    "HARDWARE_BOARD_DEFAULT_RF_BAND_2400=1"
    "HARDWARE_BOARD_SUPPORTS_1_RF_BAND=1"
    "HARDWARE_BOARD_SUPPORTS_RF_BAND_2400=1"
    "SL_BOARD_NAME=\"BRD4314A\""
    "SL_BOARD_REV=\"A02\""
    "SL_CODE_COMPONENT_CLOCK_MANAGER=clock_manager"
    "SL_COMPONENT_CATALOG_PRESENT=1"
    "SL_CODE_COMPONENT_DEVICE_PERIPHERAL=device_peripheral"
    "SL_CODE_COMPONENT_DMA_CHANNEL=dma_channel"
    "SL_CODE_COMPONENT_DMA_MANAGER=dma_manager"
    "SL_CODE_COMPONENT_GPIO=gpio"
    "SL_CODE_COMPONENT_HAL_COMMON=hal_common"
    "SL_CODE_COMPONENT_HAL_GPIO=hal_gpio"
    "SL_CODE_COMPONENT_HAL_LDMA=hal_ldma"
    "SL_CODE_COMPONENT_INTERRUPT_MANAGER=interrupt_manager"
    "CMSIS_NVIC_VIRTUAL=1"
    "CMSIS_NVIC_VIRTUAL_HEADER_FILE=\"cmsis_nvic_virtual.h\""
    "SL_CODE_COMPONENT_MEMORY_MANAGER=memory_manager"
    "SL_CODE_COMPONENT_CORE=core"
    "SL_CODE_COMPONENT_SLEEPTIMER=sleeptimer"
)

target_link_libraries(slc PUBLIC
    "-Wl,--start-group"
    "gcc"
    "c"
    "m"
    "nosys"
    "-Wl,--end-group"
)
target_compile_options(slc PUBLIC
    $<$<COMPILE_LANGUAGE:C>:-mcpu=cortex-m33>
    $<$<COMPILE_LANGUAGE:C>:-mthumb>
    $<$<COMPILE_LANGUAGE:C>:-mfpu=fpv5-sp-d16>
    $<$<COMPILE_LANGUAGE:C>:-mfloat-abi=hard>
    $<$<COMPILE_LANGUAGE:C>:-mcmse>
    $<$<COMPILE_LANGUAGE:C>:-Wall>
    $<$<COMPILE_LANGUAGE:C>:-Wextra>
    $<$<COMPILE_LANGUAGE:C>:-Os>
    $<$<COMPILE_LANGUAGE:C>:-fdata-sections>
    $<$<COMPILE_LANGUAGE:C>:-ffunction-sections>
    $<$<COMPILE_LANGUAGE:C>:-fomit-frame-pointer>
    $<$<COMPILE_LANGUAGE:C>:-g>
    $<$<COMPILE_LANGUAGE:C>:--specs=nano.specs>
    $<$<COMPILE_LANGUAGE:C>:-fno-lto>
    $<$<COMPILE_LANGUAGE:CXX>:-mcpu=cortex-m33>
    $<$<COMPILE_LANGUAGE:CXX>:-mthumb>
    $<$<COMPILE_LANGUAGE:CXX>:-mfpu=fpv5-sp-d16>
    $<$<COMPILE_LANGUAGE:CXX>:-mfloat-abi=hard>
    $<$<COMPILE_LANGUAGE:CXX>:-fno-rtti>
    $<$<COMPILE_LANGUAGE:CXX>:-fno-exceptions>
    $<$<COMPILE_LANGUAGE:CXX>:-mcmse>
    $<$<COMPILE_LANGUAGE:CXX>:-Wall>
    $<$<COMPILE_LANGUAGE:CXX>:-Wextra>
    $<$<COMPILE_LANGUAGE:CXX>:-Os>
    $<$<COMPILE_LANGUAGE:CXX>:-fdata-sections>
    $<$<COMPILE_LANGUAGE:CXX>:-ffunction-sections>
    $<$<COMPILE_LANGUAGE:CXX>:-fomit-frame-pointer>
    $<$<COMPILE_LANGUAGE:CXX>:-g>
    $<$<COMPILE_LANGUAGE:CXX>:--specs=nano.specs>
    $<$<COMPILE_LANGUAGE:CXX>:-fno-lto>
    $<$<COMPILE_LANGUAGE:ASM>:-mcpu=cortex-m33>
    $<$<COMPILE_LANGUAGE:ASM>:-mthumb>
    $<$<COMPILE_LANGUAGE:ASM>:-mfpu=fpv5-sp-d16>
    $<$<COMPILE_LANGUAGE:ASM>:-mfloat-abi=hard>
    "$<$<COMPILE_LANGUAGE:ASM>:SHELL:-x assembler-with-cpp>"
)

set(post_build_command )
set_property(TARGET slc PROPERTY C_STANDARD 17)
set_property(TARGET slc PROPERTY CXX_STANDARD 17)
set_property(TARGET slc PROPERTY CXX_EXTENSIONS OFF)

target_link_options(slc INTERFACE
    -mcpu=cortex-m33
    -mthumb
    -mfpu=fpv5-sp-d16
    -mfloat-abi=hard
    "-T${CMAKE_CURRENT_LIST_DIR}/../autogen/linkerfile.ld"
    --specs=nano.specs
    -Wl,-Map=$<TARGET_FILE_DIR:BGM220P_OLED_I2C>/BGM220P_OLED_I2C.map
    "SHELL:-Wl,--wrap=_free_r -Wl,--wrap=_malloc_r -Wl,--wrap=_calloc_r -Wl,--wrap=_realloc_r"
    -fno-lto
    -Wl,--gc-sections
)

# BEGIN_SIMPLICITY_STUDIO_METADATA=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=END_SIMPLICITY_STUDIO_METADATA