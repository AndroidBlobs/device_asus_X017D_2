LOCAL_PATH := $(call my-dir)
ifeq ($(TARGET_DEVICE),X017D_2)
include $(call all-makefiles-under,$(LOCAL_PATH))
include $(CLEAR_VARS)
endif