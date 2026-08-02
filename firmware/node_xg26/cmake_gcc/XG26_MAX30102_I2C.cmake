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
    "../${COPIED_SDK_PATH}/platform_core/platform/Device/SiliconLabs/EFR32MG26/Source/startup_efr32mg26.c"
    "../${COPIED_SDK_PATH}/platform_core/platform/Device/SiliconLabs/EFR32MG26/Source/system_efr32mg26.c"
    "../${COPIED_SDK_PATH}/platform_core/platform/driver/debug/src/sl_debug_swo.c"
    "../${COPIED_SDK_PATH}/platform_core/platform/driver/dma_channel/src/sl_dma_channel.c"
    "../${COPIED_SDK_PATH}/platform_core/platform/driver/dma_channel/src/sl_dma_descriptor_allocator.c"
    "../${COPIED_SDK_PATH}/platform_core/platform/driver/gpio/src/sl_gpio.c"
    "../${COPIED_SDK_PATH}/platform_core/platform/driver/i2c/src/sl_i2c.c"
    "../${COPIED_SDK_PATH}/platform_core/platform/driver/i2cspm/src/sl_i2cspm.c"
    "../${COPIED_SDK_PATH}/platform_core/platform/emdrv/gpiointerrupt/src/gpiointerrupt.c"
    "../${COPIED_SDK_PATH}/platform_core/platform/emlib/src/em_burtc.c"
    "../${COPIED_SDK_PATH}/platform_core/platform/emlib/src/em_cmu.c"
    "../${COPIED_SDK_PATH}/platform_core/platform/emlib/src/em_emu.c"
    "../${COPIED_SDK_PATH}/platform_core/platform/emlib/src/em_gpio.c"
    "../${COPIED_SDK_PATH}/platform_core/platform/emlib/src/em_i2c.c"
    "../${COPIED_SDK_PATH}/platform_core/platform/emlib/src/em_msc.c"
    "../${COPIED_SDK_PATH}/platform_core/platform/emlib/src/em_prs.c"
    "../${COPIED_SDK_PATH}/platform_core/platform/emlib/src/em_system.c"
    "../${COPIED_SDK_PATH}/platform_core/platform/emlib/src/em_timer.c"
    "../${COPIED_SDK_PATH}/platform_core/platform/emlib/src/em_usart.c"
    "../${COPIED_SDK_PATH}/platform_core/platform/peripheral/src/sl_hal_gpio.c"
    "../${COPIED_SDK_PATH}/platform_core/platform/peripheral/src/sl_hal_i2c.c"
    "../${COPIED_SDK_PATH}/platform_core/platform/peripheral/src/sl_hal_ldma.c"
    "../${COPIED_SDK_PATH}/platform_core/platform/peripheral/src/sl_hal_syscfg.c"
    "../${COPIED_SDK_PATH}/platform_core/platform/peripheral/src/sl_hal_sysrtc.c"
    "../${COPIED_SDK_PATH}/platform_core/platform/peripheral/src/sl_hal_sysrtc_subsystem.c"
    "../${COPIED_SDK_PATH}/platform_core/platform/peripheral/src/sl_hal_system.c"
    "../${COPIED_SDK_PATH}/platform_core/platform/service/clock_manager/src/sl_clock_manager.c"
    "../${COPIED_SDK_PATH}/platform_core/platform/service/clock_manager/src/sl_clock_manager_hal_s2.c"
    "../${COPIED_SDK_PATH}/platform_core/platform/service/clock_manager/src/sl_clock_manager_init.c"
    "../${COPIED_SDK_PATH}/platform_core/platform/service/clock_manager/src/sl_clock_manager_init_hal_s2.c"
    "../${COPIED_SDK_PATH}/platform_core/platform/service/device_init/src/sl_device_init_dcdc_s2.c"
    "../${COPIED_SDK_PATH}/platform_core/platform/service/device_init/src/sl_device_init_emu_s2.c"
    "../${COPIED_SDK_PATH}/platform_core/platform/service/device_manager/clocks/sl_device_clock_efr32xg26.c"
    "../${COPIED_SDK_PATH}/platform_core/platform/service/device_manager/devices/sl_device_peripheral_hal_efr32xg26.c"
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
    "../${COPIED_SDK_PATH}/platform_core/platform/service/sleeptimer/src/sl_sleeptimer_hal_sysrtc.c"
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
    "../${COPIED_SDK_PATH}/platform_core/platform/Device/SiliconLabs/EFR32MG26/Include"
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
    "../${COPIED_SDK_PATH}/platform_core/platform/emdrv/common/inc"
    "../${COPIED_SDK_PATH}/platform_core/platform/emlib/inc"
    "../${COPIED_SDK_PATH}/platform_core/platform/common/errno_error_codes/inc"
    "../${COPIED_SDK_PATH}/platform_core/platform/driver/gpio/inc"
    "../${COPIED_SDK_PATH}/platform_core/platform/emdrv/gpiointerrupt/inc"
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
    "EFR32MG26B510F3200IM48=1"
    "SL_CODE_COMPONENT_SYSTEM=system"
    "HARDWARE_BOARD_DEFAULT_RF_BAND_2400=1"
    "HARDWARE_BOARD_SUPPORTS_1_RF_BAND=1"
    "HARDWARE_BOARD_SUPPORTS_RF_BAND_2400=1"
    "HFXO_FREQ=39000000"
    "SL_BOARD_NAME=\"BRD2709A\""
    "SL_BOARD_REV=\"A03\""
    "SL_CODE_COMPONENT_CLOCK_MANAGER=clock_manager"
    "SL_COMPONENT_CATALOG_PRESENT=1"
    "SL_CODE_COMPONENT_DEVICE_PERIPHERAL=device_peripheral"
    "SL_CODE_COMPONENT_DMA_CHANNEL=dma_channel"
    "SL_CODE_COMPONENT_DMA_MANAGER=dma_manager"
    "SL_CODE_COMPONENT_GPIO=gpio"
    "SL_CODE_COMPONENT_HAL_COMMON=hal_common"
    "SL_CODE_COMPONENT_HAL_GPIO=hal_gpio"
    "SL_CODE_COMPONENT_HAL_LDMA=hal_ldma"
    "SL_CODE_COMPONENT_HAL_SYSRTC=hal_sysrtc"
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
    -Wl,-Map=$<TARGET_FILE_DIR:XG26_MAX30102_I2C>/XG26_MAX30102_I2C.map
    "SHELL:-Wl,--wrap=_free_r -Wl,--wrap=_malloc_r -Wl,--wrap=_calloc_r -Wl,--wrap=_realloc_r"
    -fno-lto
    -Wl,--gc-sections
)

# BEGIN_SIMPLICITY_STUDIO_METADATA=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=END_SIMPLICITY_STUDIO_METADATA