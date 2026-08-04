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

# BEGIN_SIMPLICITY_STUDIO_METADATA=eJztfQtz4ziS5l+pcGxc7N6WJb4fddU94bbdPd6zyw7bNXMT6w0GTdEyt0lRS1Iuezbmvx/A91MCQICEZmceVSWKyvwyASQSQCLzv08erm7urq/Orx7/Yj08fr+4urXuLm4eTr6cfP3De+A/PX16c6PYCzc/PZ2IC+HpBDxxN0648jZr8Oj746+nxtPJH35+enqKwP83X7dR+J+uk4DXNnbggld2ziIIVzvfXcRustsuds55uHnx1otffruRJOHOur2+vLCupPPF2nFS+oDE1o2SjwcH/A0oFCRPSi7gJfC/ry+hv3KjipWTEu68V7zt+W71buxbjh86v1uBvbHXbmSFseP5vp2EkZXRWbymaNbuxo3sxF2BHyXRzk0f+t7m9/TJi+3H4NGSiGUSuS5DZs+hHa0g/SQKfYZ8Vu6b57iWt/ESa+WsnIlYucGOIafADcLoo2yqyF2DQcCyZ4QRs75gb7eWH66Ztsvzbm3FP8LpWoQdIy+Mwci0A2sX21FivTlhwJKb5MTbwAp9d8WQS+y77jbxAiqK+7rMLG/7sbdx/N3KvbOTV/BxF3mQd7JbeeGXZW7El4WNrmh+Lb4rn3xiN/c8usEWGHmXwexj75IQqBNt+jn77fLb48Ppw/XZL4tglTJ+3nl+4m3qDdFtHTzbv3Jf7J2fpPZy4VDmcv94aZ2HwTbcuJskzvsTVSGcgrrl2IkNLBgLJqvALm2Kt4kTe+O4MXVlDTJiIJH7BlX2am9WvhuxZ8BAVblNZNJt6+QZNkI5iWRqmoYHC10VPFKfaxqVpayyyZfpiNzPkLaE6awawWcLf4TFHzP5llPULLPv1tskYegTTL3LCcBlL9y4ib0Ck83c/gF4cZFz8tz4f2JvKSf/h/Qj/faIPeAKeo6XfFjx6ndLEiRtoUHoA+3T+jl0I1/CKEhXbgM/OvDTvb8a+O1FugJG+OXA7x88IHO4ubafY2QiA6TSJsEkMoQq3EUYUvVRbBr3BNjy3dZ6XgeSlE8d7VVNt9/bzu/AO4NLFHuz3C7TDqIKhutqjmhrqmaCh41mLz8ts2ZZ1rS7TNWzzCRbdgD1Txkkon7EiRtwJGkLD4mgA1aLqGtdZZaOXt9KJRO2jiS9buzcS5hH47loyw4iap0rpWzZpTfEgZwFGsoyPu8iO+BIyhIPfTkThy85MzyU5XSCHUdS5mhoyxh9bJPQdnhqzwYmyvLCwwWORC3g0JYScN+8hDwJWiGiLWtgA+qxE3mg00Q8idwBRlvyre/zJG8Oh7KULldW2GVihd1044gnMUtAlCV9iSOHJ7tU4qEs53rrRDxNNCUe6nJ6PDVnAYeBlNY25GqINjBRlvf1ha9RWuKhLuc7X2K+s5DSk3iyRDka2jLaXPn1BRzaUjq28+ryJGcJiLKkPvCeOZKzgMNAyvdnm6dVSx0SI2lhTIm34WpDsA8abendNHaKJ6ErRLRl5cx/8Bn5Dz5f/oPPxn8IYp6m1hwNZRm3K5527nM0tGWMeDK5ORr6Mlqxt94AufiStY6KssxRwtX2fQGHspQxV/uAMZN9wPgjdl7WPIlZAqIsKW++ECtPaMebK7Rj5QvxtoXNagf7xyrkaYQWcKhJ6Qb5FSkuhGygYRPwxIOYbUCTRTxh/gj5dfQXuzcwgyAcCnFF+L23cbCjEttR3XYSBt4kPlUm7RKAXjb44nWAnss73iS2uAk/ZzoWuxOuXMvx7Tj2XjzHTrxwM70sAyBGyuZxIdwgirEt5252kyyjm01VcB2LHmjDncaFaY36ku/4kQPpzjFYCr4UJNh6/jRLg44MJefxUkSTuE9tCSICN6nnom8SeZtJfNwm/orvaAl8L55hIJdsx7eAnewm2cBqt0DBF1UCXP+x7a25UbQJLfBnmjNj5Y6+UYLv/vU2QgfXhI3R4Z02Ty8izI7GyNkfaIo4ouCJZ3PjBJdScuUD0MsGXxpzAfwjcd+D6eVoc6c0N0wuR8V3tAQfsWP7fjyDDDXOdGa46UUo2FKfH8g3DMBAHXefsZFRaez8g2/0Bg1HI9FTLZEB0/bOtblscC+tSS8kos2qnpVxh7j1ak8S4L5P5n24qAg+QN+KJ7mKidncNWQMhOdLYGZdm8NezbBDc9mXSbsx2R47ozVKv0GerWcVuxC9kFhYC64kpSakx5eUPXC4XnTm6R258+ZyXKkypzSGTX0U1rCNhs7wzKnCWGleJMyxUJUvvWTEi4AFGKoSbt3I2766EfAKeJGzCem4Z+3G6JvQvrcUnE9jbTTUbQEvEo64w7HfFvAi4Jjbj8OJkqe5PYYk4Ii7Yyi2jhcxm5AYSWslH9tpjjUwZa6AzWHlUzOIewqFYugt9yWSpff1NCm2BnSeSde2+k1oc2gdmGa6KofJN6bddWhpGgBY9sGZRbspCMqdujZg4W4KD707l7PfqnRAHsMyFm6fcHIi3lOlYYbJA/JuOwV1OHRdn7xGBEdyEuWfoWNFqO+FVNU+ZrHUqYqbi8w2Iia9iS9pK0B828Mq8z1He3oVqElbtGJbtmgTCaWN6Ga5gcSNNhMvkjqCDmOiNFRr1KHD4E+9l7m3aRuQjnwLrNZhZ+pRxezaRMK1FUw7fLTbJrRsIXmDtjPTI6UiR+wfThB7sbUBLWa9eVGym9bqdJSc9hQbxkL14po8O3WnBkUb8PzaGkJ11H6rx5umizmRgqqR+9aUoayHJN+Pjm9LnteN4ceZLRBN2rA5z7I9axgo9d+iPk/kJna0dhMrTlbTHt8OCdkDibLMgK7vPRfV+ngQuYOIssQ7e5rLAgcFLYBQlg84q6vojQsJKyi02zDmphFjolbkba1VWtUpnZVCp4U3WMNAaXeCA7E8+nIN2UoO2q6LiIX15kHQ3YjUMXt66twC9iChLWE+K3AhY4WFyQzFRUclS3I08WKnWXabnyVPE9eULkeTc+F4dPHQ6bitsuerD/CV54D1B4STJf/gTPYhjJTMVacOfJq+Ym4d7MHFpB8U68/ZBd8HjEmLT2m7kZqa3iTVUuUWVsvlrX0LUMwk5mVEH8DGaFSveTToFazjXkxzY0hyV3AiO5I3H2fi1mCx8QzATORuoPMBF71JFE56ENmrATSIXC8HYDPaHnqKxyEy9NYBAM3kCRZyvqW5rGOgNIQLknmX4UG6GhRaI7ZNesIR2pSyHwvFttxGoePGsWU7U6/Z+pqzi+bIZ/ZyBM7Qg4rprY6BkRXgQLpJhsfMcnbRcD4pu+42zYLPz7xcYZrW1hVcq6xXdRyU5q2K6NQJYToC9oGhMy6bdLPSIJw0ZQMQE2mBBYCF6XmSt4LEROLnHW8Cl4iYyMuVbWoiOm5frGZx5zGMZUbfOg7qln9W4dpAuHZPdivXtz/4cU0yPFMO/YxjMewr/nQMW0bPsqPgTQusNZgVH+YVrQXluM1Z3loTjvZcpbkZq/jzMcjJk72uIu8NY4nSc6/6ebfmx4ykcKz4xyQByZnulinP6ipoDcBxD7JKlAnGWUOX5T3tGgA+BtrQKAhsy3m1NxvX52gsVKCmHA0V1/qNyxoQejdLV27sRN42CSPL9v3QscG/5hd1CNWRW4NaI05oD2oqrt0vrQGh15tyohNW60MScmS9voFr6Dw0ZQcJY8swe4sOoeJ6boNJ8PiZ1KbKFZo3JGRX2HayzKC82fGpEizWFZgPAbJ0ilNfJJXwi+ywu0MqTbL7m7cV4FZe2ZLobfJ6U6W87IjhkSW45G3ITq++4lrEBNqjMF7jLU/XvlM8045awLA2cHP2R9/noRyTdnuoxqrn5+z56PzkG3xu4HvP5Pt7o2vOwSrcU51iprKmI6HOdVRpMEDICXaTg895joXuzgDdpQN9Kke/gZ3Qxe+An8hva2Anctm60IN4eug5z7HQp4qGaWAni3jpgo8/4sSdxG9owK/YjhVgstiNBn7S+IwO/MmyZDTgY2fEGJ/xjtZ8PoFrlqkqLdZb40pjPp8avEOUZrgPOrzutrUnialuS1BjPbLcqmfN0Q5NvmPbIq9oPHU7VGzHCvA8TUX01iAmKUTRHQfZlc/Jx0DJdrSrYgcvu830RrTGd6wIYNEcT3QtoCFCje/4bhRNcs7X6kQRwWFeP3hr7W7cyJu+H7WZ01ioTi0DWer//oXq1NgJj1J6F6pTYyfbVe5dqE4NPedJAfpcblyTNZUV9+RzWM6UworbeZkkEVwDfsWW0pbBDALkbOkIMNsk1mVPZw9kajlIbxwM7IFMDR8759oEpyZVnSvyo5PRWy2xn1+5mmSdVolcHILVmI9c76ekpnKU+gWh4jHltCbymvoFoeE+5aT8iarJ9gtScKchyXRzeb8slCb1itpEE/ugNDRm+Aa1KWf5fVKRTPejcwGMPUSv27AJjihq+svDSurcaVnQ2QShcVJat2GzCUJYumqfBZ1Nloo/RQs6pzSYx6o0nVqUVzoFp7ZbBBvVLe+cbomTO8m7xBt9ZQpAt/wQ9xZib/fJSTHsOIDDMlPaEsq+zDkua5wpRN0W1NhNtofkoHadYz5RmsyPJhCQZPS/2tHqhx25JCZg7BXirPzBLkqTUlshoAXvfPIT0euEMUN7UGi+iEPt10Yxt+RYjju2FwrBbjQjKjRfGORY/j4G9/4v2w36HAJN7S9iT9VOpPxmjEQGrZ1CoJ+ZNNNk1fPSz8WQbfIc69xm1PLMtPQXhAiStHkfTeRaWwKqNqhfcbmR6bCl0wuo59ZEEAI3lyanti+tPItn+s5DMrN3tXH83QrlpwMEgtNtFKZdYFT3z4rtrh3HoruzmNJdQu0sc1GXJeJli+mofg8TGBmBFWzphorsxd/kyczUdcIjM72t3G3kOnbirizb9+zYpes39Uh+iDeyBvr6How7AI/pHpD2CNHlNgo2i0C3QdQE0W0t0Mlf05nGfac7N/QgbnIapeM15TiSQf2u8WJH2mBh2JsTyDJzsHVGh8EymjyHHnf2mpB90Cj8T9dJlvlP2oL1EEbVc41wj8ZahCPXXgXuIljhEa/97ACDs98uvz0+FAzSEydoSeHojHZuL9cDFGEK7FzLZOTc97Rnre7s5PXnEt/XZeN56zde1hvhV4NK6WGF8rN0IHiOl3xY8ep3SxIkbaEthOZa/ump+Pj0dJFmwXl6evDAz8LNtf0cPz398tuNJD09lS4WSyhwg/wp3+5+Sretn8qN52lUUDBPV0JUWeZbAU/l8v4pW6wzYDUoXZ5pEYjph87vZXFDHiCkWw9UIWTrj6d0TcGo+/ayeKotJibgZjPi1mrBqtvme9FPA3vKU3amAkqWIXOWbpxlDpt3KOUY4L7BPOqvpWacRwEAwLwtUAdA35QNAsgyT0wpcjFBulG0CS3wZwhrfq7ceJaelyZOm5JxLWh1Dnlh5qzZ+E7Yr2t8YeahWca0B5bdUbTbJvOalh4YEzbEIW082eCtybHkpcTnaZBWZXAuMMzRI4qSiLMooGQ+j+Rl3amZhK/4zyF/XthiQPbAdqLwwn2B7qgHXYVif+Xi8pfvv1mXv97g/CjdfhDuziXpj9/OcH74cG2d315cgj9u7m6/XX57tB7+8vB4eZNu5bzZ/i49B0hjCHHI/vHs/uLPZ/eX1i+34F/WxeWvZ9+vH637X61fzr5dWJIiCCPIPXy/u7u9f3ywxIIiDWKk4IAKM0rfzm4uG3r7X/+1C5P/88v9hSKLyln2iYjy/eWfegifCRIRzVaDn1/fnv9f6+bs29lvl/cNNs3NB1wmJf2zx7Pr29+su/vLB/B5HNiLyz9dnV9ad5f3V3d/vLw/u24Azpd49TtTo5jdnFnnfzz79u2yxaaeZH8sgz7F1xdKoxj8dnd126Cc5VAeQ/KPZ2nj3tx+axCGscZFCO5Y8h3URdD/eNLXQOUd0jB6fRzpq2+Pl/f33+8ee5uz6xViMDu/ebh6sL6Bbm/96er+8Tvs8mN+bf3x8uzi8t769eq6z1plh1MbMI6sNy9KdrBmIA0rc3N5c3v/l171tNy0ccbs9r4pVTo9j5sQry8v7x6vblqo62U1O+R97zmyo49fGycna6fPEeh9FfnFvlm598VNCGbxnpeTMPRvt7kO4Ier9DSnfLrYOQv4Cdg7WNgbvBSmz/e9tnC2u3YjJO77aSDLUyF4aSF42b6pp/F2MvZ+aCeW/ey1bE3Ud2KHgqCIIdgPoIw0iF1nB89tw5XbQJCd0hEhSM/1DvDP3sn/ekgrDDTY/1N5OrpLwrW7WWZvwn35hT+RamDWoXQvHugI/h3TUhAmjpWd2HNj2Nib0HIsYDCoIYBZwYLngxDK11hgwOiqDLhjtkEYeIn1EgErbW3D1FOYqzOElvvuuNtZO2RoRUnizdERWEiPx38myYsojht7m7oM87S8Y8WJvVmlM2TdcxCNifi/vw8g+Nd/FfVpMPywo423WccL2/dnaoYSgvueRPbcILbuyt4kntN05Qbiipg2CHCm0lO8eC4o8I3A+2saRtBch3h/ncBIsGCP6zClRRh9981tDo6V+2Lv/AQZRGD/7qYepx0FCxiFmdjR2k3aKAZe66xtTgPw5CeCFc5IHMnrLnhuIcmfTQOgvcQ6DcCTn/KF1ulK1CYD0rvYAnDg81Pw/CeshVeHTTVHHERUvTo0oZ3GyeonnFltDw94UR4ZEAx0HZrjMlBYEx1lWH3uz+nLJjzNns4GasAnTKHVv5u2bxUumzW0zgdGKcCYmSjqbUJoOBorZnKr7Vqd/jl9Mr2i2CMi0k/X7zv9c/5sRh0xRYWjp0E/6PSWihXA1RBrPDi6Gd7ROn2B351W302vqEnB4Wht/37k6Uvx/azamwUk1rjcv4t2+gJfOE1fOC1fmGG4zgMTaxQPLLNO+26XsB+2TNHg6GVop/gUrHZcJ/4Jfr9I/zmHnqZA179dMPDa8CHQuLOfkahSPXGkpdJdzj5bgb1tuTn+59Mbe/vTP/3z7ffHu++P1sXV/b8s/+mf7+5v/+3y/BHGHP3LIv0VIuAswG3hrdxFfhrXxppH0YTbpkfxvA4kSdg6kvS6GeF3DejHi4eSaqSEr704KYk3lHP6IwLqAUbVdS3w20/1h0Fa3Lzz2Ol/HLnF84GLrnuQwPWgn/QEqKDJsHb2zZzLSrWYSn8N4+R4tY4vOLCJi9jz7ec47eCxJ0uZrVwliyy+ZPW88/xVelS/WG92i3IkPtv5lduafmrkqncX2QvAaL349noodwcP+mPda8Gv4QrtNPrxDrrvOnA3CZXuS9CKYArEaMf87aIl/9GObNqxYft9/y04TjPEUP3/L1cIwMJsDmj7i3S0PygzjW6yx0PnGWyP0z43XJIJsRQIaUpsnFACYwpFXoTJqxv5QDiKwh/85WAKuH3cAjeOgRZOfXezTl5/6ov8n2j+wlJ7/f1/KH7Q5g1Go5ENzHfwoSR5+sNLXk/TQc/CrBwNdHY+Ny45x4ucnW9HK3frblbuxvkgD2DhR6oNWMOtOlsWeKEnYzxqCqJU3jlmE30t7uGVTz59/cN74MOfZPnJwI/EhZASAdTClbdZg0ffH389NZ5O/lARKvY6qnzvziIIVzsw5GI32W0X5+nllbvstTug819SIfKbddbt9eWFdSWdL9IofkAGENy6UfLx4IC/Ab1yM6XdIltAK1XIQ+JufwYSNT7PICkFGZfsUeZhPQ9ukqQhWFyC3Dm5Min0k04xgWyfdMjUt19fxH4acpLsz87Zyua1cCJYhhHmqIH/TBHDzgl0Xg7Hp75MXwMTPmL6tm5vP/l8km9pWve3t48nX07+++nk/vL67PHqT5dW/aunky8A9+Lp5G/gNw9XN3fXV+dXj3+xHh6/X1zdWje3F9+vLx8AgX8HFHJZLrPcYsCEfvn3//gM864F4Zu7Ah9TO/q5fPEh3EVO9V7W2CnHojN8ublJH34CPWoTf8mf/gRkOHlNku2X5fLHjx+FgQS2chnHy6KTuNll4aeTSsdPuULhQ2+Vfm53sq23SU1pbxeDv9uuggahn1Odbj7lN5xhj48/be0kcaOM4+J/wz+X+XtlYxSi/fx0UmkECA/p/u3z34k2cez8P5SLqdy/L7UWFSGKOhyFoXxNeeXfddKRD7zUuExthbHj+b6dpHmBEN5P4A7X0Jtpis7+77Lz0/hHOPxCmRXLWjkrB+U9N9gNvZalorFC310NvpLnJcnKbVpvoOMNvdq8GYr4VuSuYaTCwMvVtc3aG9yMn51znoE68nFTnPFm6T1PH67PfklzkH6uvrp/vLSALd6GG7jdnLfTwNlw7ZtyuOX+YVnPoPmOU1C2HDux88I5zVdql+wBERgXC+B3KfW/1qHmvkFmr/Zmle9b7vu68+t82PTLUn45yLwcUhmDHik6bwzTSIc4CrP0xWwQ79Hf/tf5GnyPbgATubh/L8MP/H+Rrz88+B03qs5Z3LiJDYPv+NR3I3syuvJrP/pc5qT+XCaR/lylUP7cSAD9GV6m2ZcVF7WmxzhCRV0NbCp7a7OMo1azi3vTvh7Kvk/y+zxPO8lPayn0MX9eT7qO99OhihGkVFp1M/DIHCrigEetmeV/z2+x6xxSo0UDV7PYHzI5ompjtKk3i8MhUy9rmGa51Ze11OrLdGoo+0AjCA1LAkweln2wi46j/wyUd2hIjeaQHLJd4zg4wSHbMpJ+9LFNQvugBR7HBS572TIAr21eQrY8wDIF+C1puG14aLIbyWrrH/IzxjFwGXcrN12FMGXxAiwh2wZfb52IbbdNfTfWDKxtyLgpXl9YN8XryztbBrBOPFP6NmML6Dm28+oyZZGWoGfN4P3ZZmtbCyZwe8vbMHZBfDfdCGXLg/no81mPviBmOzi2K7Z+4DZi240AfSv21hvbZ8sHeLNsGyJm7HfEH7Hzgreqw2XBfkDv2I9o9u7ZjxXm6hqdgRvkZ2WM6GfJuK1UDsossm3MZZwA9e+2OQu66/iCRV0IIg75zkmnwEq6wdF5SqaonEe+ZQKjJ0m7ZYtSEgYeoSlrUno+uFeLRAbqyHJ8IKH3Aly15PCmJSJZ+IkSJZRNXERaEeHYbNJxNzvCebtJJ4bh2lQIJXayo9LV4yTyNoQGskHJo9618h3GfDCOMR3lXmUaPQHTdwU06GXNSYNQ1gg0KAG/w/Z9wj3ZfMc3jSQpOkgZVkLWlg2SOciK5CiUVWr+Emv1aBzavaRHTfr7OVTbelZ6R80m3uAb5OMx0VLRsjXStNq2RrpXPWP4wG2pQv/ke2B1YjlahMPQ/cQ8ySmAEW8J1UjlsCCpsagyUh4NWPE2qAkJPtEgWIkKCRJJm1YRzNzLYJQz2CA04pCmRYdw5m9QIT7QaVNJPTabhoLGOJEtQqR+X4eMlcbDk7rwDXLEZx0NKuRmqkGGePQ2qBDvl7Wp0OtEkR3AFFU0KBFvQjXIjNkKahMCK2lqhCj27BFbUQ06I3aDGnTQonEOUoKz3HhLCeej0vqPmI5yOhDNeCouFSrkXk6DDLFX0qACbdF4KumgH08mH6vjCWVDazydbGgR0alqrBXOGqykReyF9JMjn9b66RHPb/3kyI8c++mNmRQGKRLPDvsojpsmapRzv7xs7LF9sUaP2ID0k0sbmyK9vLHpUiQ2L3nV0mXj1lG5Y1p/SNbk6PRRApAJmHjspCg2Ehv0KbZCH/2swQnPTjDYIERe02HCTCCvqzj6jd9mUkg0jlPtzl218dq8rseUAfHatI9+uc3bum84ts0P8IB3FSmxKJo8beq4xihre/clkqX3NemB5gCz7GOdW2X80zHDiG1g11jCbVbKSmx2t1SDVPpaP31iRw2JOrmbikSe2GtFol51p0mYWMnHlvQ8foBVc9RnXYlmV23SJ3YDkaiTO8FI5GuNPY5JdSm2flJFxbmq064d81BxrPbTHunnDzPxWreI4W3FseOtU1Q6bQgbHv72lHCmzwmeprS/oM2nOLVpfzHuvP4QP4+6YPkV6FJv+Wc2VK0sXZjVSIBAm8eOeE/2MGny/d4B2h4bjVdk4fBeRW+sqFNUdjGiCn2MG0ADVAt1sCEeuVndN9jPx06Wg0yaY4gNjx3x5uth0uQbuwXtZlaVYpQ2n47rlCgc8mwuDBh5XU6Ju0ny1DEId+nxmOYt1NIfzRbq5WCtPjZ2ADyByIU/y+Lv2HPdwnxl07ApAgTYc8u74hSMilqj1Fm1ez2DPt4ZWDQaCCrJ9soAVfhvChvFQ1RzCegT30ah48axZTvkgbBt+kUfKlVCRdFtqoVKqBNvqYQifY96gxapw6rQ7eIJZcoeC9JlgHJJeaSyhynnh8HEwQ3IPEDvYc+E/PgfmQWL9vBaTMZ1pN3K9e2Poudnn6hQzBWSUxylgj6KFsyDowVpHp8HjlJglRnqHtKPXGbAOrr8o0hJo49Fq1Uetyq387KTsJkb3R/IhT2Z1v/j5POJE249d/Wr57txngi6zGCdv/a5zMR9Zyevqepwc7WGkbf2NrZfEkif5mGG4IH4OaUJV5Xg06mombIoiJImpB1jBKBuMlg8KKIomrIh6IqJj2RPrltMELogCrJhqhI+CISMr9iNo4uaIuuKTtA4YTv/LiZz3RB1WVI1EZ/3/vS9uEpQVUnQREFTxwHp5AfGxaGbgmSiq2NPtlk8zqYO5FdAp8TlHO/JSosrvAiEVwRdxQbRm1EXj7tuKqoJBgI273amUSK5TVMDI1Dr8C6myDZzTC+R5N477kjWFVWRJb1rRaaSoXuxHtMsy7qoirKmdEcfaxH25fjDbAcNdmNF6xlDkwpRSyKIKYAsipIhSLoyswD1LIW4A1oyFFmT1B5rOrkM5RU7zMGgmoaqiKY2/XgeSrSIJ4CkKZphGl0Xa2L4rTyOmLOyJGmGZgpdv3laKWrxlngCGAaY1mRZmnsgNPNQ4s4LpqwqwD+a2yL1JrrEdnQFQZMEVZ57YNRSaWKKIAm6LhnAYZpbBJfQNMmgBYC/bRhz46/Hm2DP0oIqAW9vepd1ONso9iytmqZoSsrc47qezxTX61Y1Cfqt84vgkbeCIRm6asztaLRTsuLJoSimIBq62d0/mFaKespXzJYwwNpbUjRNnl2Ed0IJJF0A/9XnXsDVwtax9+JUQQcdSZ57PNfS4mI6SxLoRhJYOMw9uTXy7uLbJEVUdUGd2++uXbPF3kgEPoYhCPrcBqmVOxizN2mmYkim2bMrN48UreTEuGNDFmRDN+Ye3M3kx5gdSxUMUxX7TgsmFoJ4ohN1AfQpSZ/d7/NJJzpJEBRDU6TZp4kq3w2uAIZsqqowuwBVAmrMJZyma4Km6XPPclWCa8wxYMIdSlmYexR3E2hjtgOwRbJs6nNP1LXcSNgH0pqp6po49wwXE25miMDZ0zUwRc/dBI0UIrjekgLEAEuf2VthxMQsioakG6Imzb1+25FPzaemKSqmDhpjbhnId8bA+hOs4Qx5bse7lugde4NVFcHsYMzo47VTyePaJEHVJcWccf3Wk6sedztGAEsF02DnYpDlQsHdJwYzgyqYMrMtmRG5STA7lWAogib3RAjN0x7NtDHYG02iYIqaITMb4tgJg7DjHODYUNjFm5Bl1sHcNTYEE8YKzN8IY3qTpqiGJisas0mbLIUW7pxh6qqiSuwmPexEY9gOoKxqisBw6xU/yxjubCHJimhoKvPZAjmPCu6kbRiyoGk9gc5TClBLpYK5LyOCYayrgsrcIiHnRMLd1xAlQxM0dudwuGmRcAexoZmaqhs6s5XouNReuP1JFARNNUzmUwN6wjjsQAfQGIJsTjUiDmekw13NmaZsKroy1YhAS3mHG42oiMD5NqeaF5BS6mFGwmmqYmi6ydy9IMiOhLtlaaq6qssSs9gf4vRL+BsdimAqYs99C+aSHEq4hNsmKrCzgsJ+2iBOVYW7E6hJhi4ZEvPxgp8AA/NiiQHmQFU1mUUrkieVwd80UE1R0NivuQ8keMAeG6osyjp7JwQtgwTugbssa4aos7sPgZlCAg8+WJGassHc90BOr4E9Q2iKDOY6dTLtD6R5wQ7/UWVJMPT5cI/pNKKmSmDMSjJzpxs5Uw2mAMBdBX63wW7QolYxxew3YLDKuiLIzPYvkGtk4roLugrW/Sa7gIbBCqiY3oCmG2BJLDDznfdU7sW1IaYIcIKph5n13lMzF/f2MviPpJoTabVVkxf35EIFPpTGbiE4WPMXF6dmgCU3u9DLPSV8ca2WLMiyoYusO2pfBV7suDFF1WR1IqR5fgbyZZgoG4IK15asJ4T+er24FkswNElQDIXZWmugZCSuVwkcM0lRRWbman9NSlxnTDAMYFtVZsdKeyrM4W43S7KmyRK7S8vDlVBxo4Q0Q5IUg11cxECJVNzhL6iKLhrsjnaHC57i7hBLhghWyuw2JfdU1cSdruAhrSqy24/YU/wRO05bMjQVTAITtT+hrwL8P03QdXY3gg/VwcXtrKKgamACYOZbDRTaxQ6L1TV4JM9uF2GolC/2xA97gK6JzDYMBsr84mZDMDRZN9jlZtlfRhg3lsEUBWD7J7KoI8K3RU1VRE3R2N0mGa47jLtNoQKVKhq7y86HCxtjDy1NlxWBYXKqgXK+uNGZigymf5W1BejUC8bOv6GZaf4Nxt50tyIxdgi1DPop64m/U6sYO15JEzSFYQTlcBVj3GMceFEJeCjMFLqKPMB8CVu8WE0Tt75mygJcSTFTax1svgE0JoWELKuGobK7WHuo5DO2TRU0QTbZHQkfrCmNuwzQ4GagqU8MeIxPAHcsFFVll7QJoew0dgSyJKoKu4gHjLLWmIe8qmqApSK7ELODZbOxZ2FdhaGu7AKNESpfY6dC0HVDMNidHCGU1sa/hiWCuVkar+U0xWy8fAV//rAB6PRzATPLPzsi76yg6MCHoLDKRYDp5PmjyWO0BbDOTQPXGMHNbUMDLuEKUgGK1VUK2f8QkBIHS8iqpBuGSWFVngZYLs/hqCruAQan4Mcvnu/m0Zdrx7HIpgdTEExBFIXxPtlemLBmhAE88i3hdXBD0jVBECi0eQ/MNGQg1ePK3UauAylbtu/ZMWlKFhhpD9PYjZ90e+BmUMedFou6qpuKIVM4gRtEOGaLWJRE4BfCgwIW+JK/phbIfSfNyiboui5o4xfbg7pbEyZ+kAzQ90zgVzOBlp77BrJMBE3TVE1VTIxTVHu7JfMQFNNQYSZM9KkXsiIzTAboDJpsoo+jyLVXgUuWT/9UNBVNl2HcKTK/LIk/GT8dLBzADIE+OcBQN9I06WCNohjYxTxAy1l+uLacEZUzDBVecZR6jk0RyjQ879ZW/CMcA+BUkyVdUPs6LG7pjhEodEWTRL0v5crhYg3NctxxYm8clzTcwhRhIiqzJ5qFFAfZeapoghbRe+4+HIbhvgEiYKGzWZHO0AosXyKbPTHOh7mXVWszAMRhLyZYFopGz14HBoQ0aHdcSwBzLhkaUAW2Lnxv87sbQQd04ZOYPxjer2qSwm67pxVXmYQB8YkKcJlgyR12p79NrM/EQeSqAG/haOyyt7dDACNvQ2YRNVWXTQn4LRMh9b2YMJpKNE1DMZkHWLtRtAkt8GdaumvlxtmZYPspYQ5IUdVAx5gqJjDrFoR5TnS4btbYZQJqYU07BpFbZUhgGlF09ndl9qYOgAlnyeBrsqyzPCZGgl/tYZJd0gUD09BB3541ewBx0l/omYJ1gDx1GzTh19qAzIkwZDgQpk6hMSSElXxsCQ2lCU/QQXtM3Z1AB2p2J+I8UQZYVIq6bEydkCX7GPc3CDyWGJeXQlRlQVNMc4I8LdUypzRV1SPCAwBYHkvU2d11GgbvtdZtsFwp6ThXgcemy7rEfnTsbYO0O/mk855uaIIsm+xzLtWFKExVrSMROviwuJTGsNxAmTUgX2WWyQLyz0Q6N03JVE2Nvac0hNqK3MSO1m4CfNMVaYCVKCmmLqvsu/+gFAC87z0XG1FkXp+siDDulrkdHRRiZxNexVJh5JgyQaqrQehg/K6iNyLwigTTUYL/Tga+yLxSDFwiky9LEtxApXAegwfbG4nbNAU5DYCaS92tsUomhKSZCrzePZsQO+KkygZAr4IRyz69zVDHIQcvmtCDliT2WQ2HweemhvAEWjMUVWd4BxQnFQ/hPKUbkqjI7HKjY2UTWn1s7MBzgBsBf2aTpyeBWSYMeYK8aL1ied0jrfT+HtGiRlEFTZsgnS9iuqfMvyMLnobH5zrDHBpYjUK2nW7AgggTrAuQWmMbhmTbeTC6R9VlWWLubyDLMWaMnIqSKJpwk3XqdunNJUZ6T1cQRWWC/Ka9InRMFhjpABhAOirSESykdVmXFXYnZfmFiTSIodrzziMaCFPz64ahGSK7y/INzOX2aoGZRM+yqasC6DzMNrgLyIFtOa/2ZuP69R2j/BHhlqMmioYgsxu7+7FXhaMt2/dDx4YlpAmD5+FMLaky885ek6S25VW0AunRpSjrDBN0I2EfU9xE01VFNjR2yUMGJfDGq18DXjjwj9gVtN+v/t5BQBZvAGYwg+FN7v67OuT1QA2w8lcUld0ORv/tEeJ9dVjfUBDp30C0t9viyH6XeH4RlFj8TWYRdRjUIdEIzccDS9QTJAH0BFPQDNobz0NoYbjUCMCSrAiqKVGvVFPeJclNRra1tovS5bgVgkfQTakyaZEF50FvV4SVRWj3DUT4ZRY40quqsNqrZho9ZY8OBrxWW2ewmpr1BjrHqA1MSYKlpQmiC/siLUkQKKZu6rLU05a4cZaZRsbG3xqyIguS0JP2cCwesr6iKCaw2zK7WfHwaVBMehx0qiswlllkV8fy8PY4cdFBURfB4lNU2cU/NvKKkAM1TVWCB+aMEzXl+RrIe4MqiQZQaM+F98NWT3LibWCFvrsaY+00SRWBrekJEj6IIPZdd5tWEh0DQBHgoYuAroLCuCxi30nTebrLhRM55flyRFYHwABTkGD2RCAdtnHw5l24gQH+wNO3iT0mUdIV4DKZIgmG5gUDslJ3uirJal/pEAQzn/VG8svRqgg8GNXoObLFYD5yWhF0UddxblKxiAgEwhDGM+qmZOoC+wIQ1bivwpGLJ6RhcoYMmp75fN5B7tWNGGl1RRUmAGFf22Wf2tNFcFocnGjxALpNWn1gdhEAHyAF6amFooAlkEl9eYwvxvOOVApVFQwJ9CfmodUHZRgznCXTFCSJfaHOmhDljZnSEpEZUUFRVJ1hir9B6N5Y7KeGpugC+56zW7m+/VH0muwTWXylAm8Ty+yKsO9DbMEEFFqQ3qt/ILKZqqhIErsjohb4vH/n6iY7k1DAgkgV2S2K8i0i4MGUC2aJ0Jinm8hgBcdsSupg9cg9L1h7XNT7rubSB1ss5gmxAqi6ARZcrA9jM5e81g3AJ+Jk+4oggDXyRJArBUPIJDrW03IWDGvDNjYfyH2NUxHgFERJFqbZJiE2BmBWVjXdENnNFA2cxH60phgyy8xpDZTk/pmkw8NpkUImHZRNvKx/EtlVDUwBqtq3Ec8CKKlJPYUnL4Yo6xMVWUi7JxlQHRh+EcYMTgJ0hBsuqTLMlzVFosfasTdpD5ANXRd0Q5g4y+MIewpPuEwJOCz/cfL55OHq5u766vzq8S/Ww+P3i6tb6+7+9u7y/vHq8uHkywkQ6ZffbiRJuLNury8vrCvpPOXx309PQBD7zV09JKHz+5/syLOffTeGj7/AP+AL8D8n6cac71+HWeW14vGX4h8wH8eX5fmX5Xfg9MbLs1Xgwe1dz7ef4dVMWKc6JRAv7ch5BZP18k07fbZj9/RNW0gL4VQypOVDqdKHZLfywlNtGSex9WzD6uKb1bJg9rn4x/b39VVGN1VbP6glEqwO7Q/XjjoUYSt3UdhRcrvt6uR5HQCVbx1Jet3YnV+tQieeV50AQQeVE2490BtWvw9CG+j3HUo5QgB/XikrHAXbv2V/wPF14b7YOz/5x2D4x2D4Hz4Y/gZmETBn/Nvl+aP1cPv9/jydOL7+4T3wP+Wz0E9PJyKQ7eSTu3HClbdZgwffH389NZ5O/vDzU/S0+ZrPkZ/A32C+AyCABt2fyrnz6SR97dOnry+hv3KjTxs7gF9nx37lt/B7oIziW3g654MBWQZih7Hj+T4MyKsdWn7aRd5PhRYvwP9uz7/fwCR51sXtn79d355dPCwfb2+vH5aduXLZnhuX1QEpAuclIuwkct2pAbd4DkNtZhxmjnKI3TDA4mgNhqCsnJXDHuMejmgw3bSa3oQomwyHQfYWemcP9RDbPQMpTVLKfOg0uQzA6eamZAGny2Vfn+umq2TW27qskPvZ1B0MBeL+wENGOPcz3QO2N16IFcheZsPgekOJGGHr5VVA+7rMvIt+XyOPOWk4G40Xqpik2jstcTvBSlTlRImOqrVDU9wW0ixR8OnD9dkvabZgJkDbTA65Gats1VWGGjEBNchtAN3946V1XkSBxdQ7bwGry2bftNcTlMZKWb3M9kw6Q8mBWeEbZIiLkaEOBxkOY+xkFWaFrcMIFRPDNu0wOjj3sTYZLTYIeCboVn28EFya2v0FZsh6eGEgY9mQPbwQkHVTWzMH2GWJirPnasg0aHsYk2KeTMM9jAcwtzKMM4HX4jGABLy5yPfSPDdmBKXNBM2PHtr5HPSrG+diLde698XGO523LtJ9j9Y7nbcePIAx3Fzbz3Hn1c7LqYZ6XutSDXdRD++ehQLobFGy21rp7jf18Yl5BJmpbFnTSUZymcmz7IBdIgiYlQQ8DvlaWPvE66ymBjtBXkAHpRc0zj6oWzxaWioqAnXQInSD9DeWzcCeM5GuQIos2fMuyhICHoFsJVYc6bL4nuOQLsOKLB2sE34csuVI0SWLPrZJaDvH0nYNvMhSwrOXIxGwgIouG6C7eQmPRbwKLbqEjVwqxyJoBzS6vFvfPxYpc6jIsrlHY0ldTEvqlvfUj0G4EiyyfC9x5ByLlSmxIku33jrRsUwRJVYM6bxjaboCKpZs1jY8mqHXwIss5evL8Yy+EiuGdO/HI9w7nmx5OPkRiJYjRZfMPhqvuoCKLptjO6/usUhXgkWWr8jtdwTSFVCxZHt/to9lpVCHiy0jDE3wNkezadYHG11mt7xLdAyiVmjRJTyiWd7HnuX945nlfdxZPoiPZSrMkSJLtl0dy651jhRdsuhYzGaOFEcyK/bWG9s/IgnriJElLa7BHoGIBVRk2eKj2SuLMffK4o/YeaEfishIuBIssnzH5Kfgeym7Y3JTdvh+yjFt5OLv4/5YMQgCZiNcARVBNjeoVTngWrQGUtzwGN6Fa4PFio8Z+KL3cf/D9p1QmB7+UHyXt3F647qaEYh2Egbe7J5GnvA+T1ZRYeqquXNrwpvdojXB54AOI3fClWs5vh3H3ouXXXzmS5IBgAcl87gXbRDh4VZzN7vZl43NZioQHcYOpHXndwBaY73EhDJi0qJvXOGvMCHh33osrrKMlaBEhSJDNLsr0sYfDbgcnWuYSeRtZvcRm+grTAj4fS/mbPiWkFC0bye72bdt2tovMLXxD/lsTR/LjaJNaIE/06wXKxchkr7fLWt7/W26nKitgytLhtaHtqdDYLjB3TsVEZI3m80mMwfb58rKc5lVmNCsK/wjcd8DvqRoI0O2tlxJUWFCwP8ROzCnEGcS1FChzhh8CVBAQrK4KMvhPJX0ofVwI/vPYTvdb3AOJTJicgeXMLV2A1k5jnvh9m5ndFZ1nZ8WNSV4lXYfZgSRB35txbNf58Js4hpqbLGPR1TCjnxkfZi4+x5dz93XaYf3Wgm87X6zyGWfKNa8vXDxx/bRyIgonnc88vVApbxkatbhoufx5HRT+LyYk1bNsaJiewspygDJf5NXXOZethwnhmTpRYRjEK0AiiFblUn8KCRswmU/yzXGAye2cW+1wBIp5sg9Btn2RH/vG7nHINq+u05DWWHnv02CU7+SzCYdg4BNuERyWsnHdv4ta0xpK9Dkdjg1V31nAPtNseW+RLL0vp4/TcyAzjK52na5CZtca8AQ4qgMXkDnZx3b0hQAt+yDOkI7KSmsTlXr1HANzXvvyiXsH5UdAdgskuASmtLZXU96dM5MIcTVntbqUHGm7Ty3+pFIOJj7AHU0Yq6RqwT53FmsVEXN5UgbLUE/OB45K7C0LUqV6JbinktFlBv9VpBK/TZRIm3YNfMCJ2604chR7og4jBdpsNR+Cyc2n6ddpr3N2YA7wUZFrSNx2BeKmaWJkrIdSTtXtNsm6NZkWL3NPP+dBKK97eAEsRdbGyC99eZFyY6fcdlRTdoiNow16MWMnc2y2Rs77PjWwxBi5l6Pd0yaKstio6kKoVfwErh1SOb9yGlbsTzRND1XqKDIjZpzPKV2a/iQ+lGRijtyEztau4kVJyt+jmiGxOuBiyUt+JXvPZeFWzgXtoMWS9adPX9Q6kERC5BYkgEXaBW9cS9bBROv3eKjaLh4sOVo++WlbeNlWi90Uvg9NXxIq0/OBfJwJRqyWHyKtwctvn3lXcTdngvtg/2SZ9F6UOLJlltl7qWrcBLMHnxK14OSsuPfLDhJz/1v0uVlcm6iKqboLlaUDtQq1bn6AF95DvC3IbPsqvIRST2EH8lUdKqWppdteZZ+D2aCti/WWFyLvA80QSvzYjGRmhd1UmipaBuG3EQoIrVpAZhQ1mMYuQdwE43e9bEZ6woy+8XkUQz73F2iMupz5R6RoDXIJPM1mAncTZJXsk+ikJsDpF7Z0eDTvtcOVG573WRO5P4xoMbVNdQcU2lw6viQBlHxg7x5eJerBhNtzLR/yMkYacrXjxO5/bZR6LhxbNkOT+uXvibsIp1gJizHBGdtX0wKdXxEY5ZzuSh0aY4l7CKlPom57jbNt0pvHqto8mMtCkRVLos6RiRrX/2Ep4vnHdH6gKKMjOavstTQR9B8DbAEcoIRBktvHoukFVwCWbMqo8ciaomWQNKjsT5NtOz9lZrd48+AlZnp6hgxbTO3YrVBUp7IdyvXtz/oTeIZPV6GUIamGD4VNhTTkL1t2VHwpgXWGswUD/wK1YLJ3iDkuuRk1OQqyQ1BhW3cYEFJRbaKvLceJ7hz5+x5t6aZjwOQs+Ifs4cMZtIvUzzVlZsauCkyHBTsZu6LDV2UN9Fq4BjcOnJe7c3G9eneOsqJ8tK3KkT1Wyo1kKj3cKoa1pbt+6Fjw2rWXAs5hHia6ziFijkZVzUV1W7j1ECi9oP8J5xU2UAS70Cdjd4rdrw3XwflqHHMq5R7EVOeEWASFnpTAQ9Zo3K1QiiFXRzOEUXbBvKQfKeugLxDDafaGXdtR+pPt012Y0eafb8o1xxAUobPS6jbQh4PyYk6AnjDqYioR/1zJX4RwIopPXK/j7c0L6ul9Pjp/QBMbQDk0CbpQZAXN50IqqHqRzk09tsDbuB7z4d2BxAqHcBKZDzswqfypP2pjuhAWnrwqhPsuIKe4zkM3OUMuIsKnAf3rYF8j+PWgs6B99BAPug4tIHDgtQ8Ac/xHAbOw6ltA/nwyWwbelankSvwFaTD8Lk4cWyg33eq2ALPxW3ZBvjBm7GoGVjQZ+KZXZtM7LQYUw0R2kzME3RnMEFbFzgMzt/as8fMtfHXYCGUyuStDZqYDrcDHzUlG22AXFIyHSqz56ltDd2hFLTt/s9FLcxm30cthQlndDt42W34Mps1TIcFAAvJmIOwz4YANUwoHWj+Qp6t7oNUxzN/01q7Gzeav3J1R4Q6MLQFJU8SDCdI7VtQ8oR8z0Z4z4KSJ+TDO5k9C0qegOd4kIDz6Kw1YSGui3kSoACEtC52XmZPA9MAX0FCXtZzBj+HhAqfyymrCw11l4InKfbFw/buUvAEfjADC/E5Q5U//9BhA8IWR+zngfSzr5QqsYrDmxqww8Vw4cs8uC39YiD6L/nbHPgw/WKgOTP5yz4HtZr6xSiQocnBx+zaLwnyNFu9z8FUOygL2pzbeJ+XeXefTPsmYMQ7mIePjeuWZuZt+pou8nCEOjJ0G8ilGGgnhHVLw6UYe9L9D9tALiWpsGHZQF5lGThORHUX+x61CgRsty1b0i50lm71HnIud4mHcBkBMLP8sO8+TKtx8hdnahbAfZmJvYRyLXM0yxqqg7GExbvzTESHJEAMuuZTiCYw6qFch8fMqx2tftiRu3/goF0Qy9Lg7qI0WaIVgl/AW0P0ohKdMJ5pFBVaKmLx+iUt68FnONnHJ0JG8/RnRIUUNdFDvAqVxN27+6Cp2OcQ4G4WJSQaDykdChGRQDcpqWkzX2VaqNow/Vx03iaew45H9n6eaWxaJx1BjjYuZhE1bY6Tjct+JeQDrwMJtT0nzeqEIMJQFidmliKtyLTPUJyHh4zE1cbxd6v2S53XgtNtFEIFH+piWZGoteNY0+1zpDyXUNZlLs6yxLtsATrQt+DlfiOwgu10R8d70TfxIBuGViBUpoOVu41cx07clWX7nh1PWEa6R8ZDuDqydnsZPF8ED6c7LukRo4sEAfjUAS6DuPdEtTRgJ39N7bP7Pp297cHcRIGg5/WEZ8qDOl73nyM34cLgFieQ5Vnh1kEsx05W7Y+ttTp1/yunuRziR1uxOc1efpFrrwJ3Eawo86zR7eV79hukTJ9vjW4vX5gJkXqDFkRLjo3lW8H6wn2xd34CePv2s+s3nqRe2XkahOI9ez4YA3BVFK0UWVTsL8IC/vdMkMCbWztK2i8Gzm4Bpt9FWiF98QxLpD+vA4Bx60jS68YGP0vC0HdeAc72b8F8sIg9gChexPHiJQJYf4TR7wswrf+n64BFC4zH24SP4Pfn8PcZGEARjNF9tFa/L+LEdsCfHvj3l2I0L6xT0RQ1U9NNVZJkXVEk1TS1mq/21X1PB/nqzk5efy7b8+uy8bx8u7hGDxT989dl/VMxuBuNkT79usylSz+d/O3/A1A8MTo==END_SIMPLICITY_STUDIO_METADATA