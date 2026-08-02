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