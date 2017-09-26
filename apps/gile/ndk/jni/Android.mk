LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE := gile

LOCAL_SRC_FILES := app_main.c \
                    udp_client.c \
                    screen_capture.c

ifeq ($(TARGET_ARCH_ABI),$(filter $(TARGET_ARCH_ABI), armeabi-v7a x86))
    LOCAL_CFLAGS := -DHAVE_NEON=1
ifeq ($(TARGET_ARCH_ABI),x86)
    LOCAL_CFLAGS += -mssse3
endif
    LOCAL_SRC_FILES += helloneon-intrinsics.c.neon
endif

LOCAL_STATIC_LIBRARIES := cpufeatures

LOCAL_LDLIBS := -llog

include $(BUILD_EXECUTABLE)

$(call import-module,android/cpufeatures)
