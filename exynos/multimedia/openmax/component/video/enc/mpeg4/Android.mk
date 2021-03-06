LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)

LOCAL_MODULE_TAGS := optional

LOCAL_SRC_FILES := \
	SEC_OMX_Mpeg4enc.c \
	library_register.c

LOCAL_PRELINK_MODULE := false
LOCAL_MODULE := libOMX.SEC.M4V.Encoder
LOCAL_MODULE_PATH := $(TARGET_OUT_SHARED_LIBRARIES)/omx

LOCAL_CFLAGS := -Wno-error

ifeq ($(BOARD_NONBLOCK_MODE_PROCESS), true)
LOCAL_CFLAGS += -DNONBLOCK_MODE_PROCESS
endif

ifeq ($(BOARD_USE_METADATABUFFERTYPE), true)
LOCAL_CFLAGS += -DUSE_METADATABUFFERTYPE
endif

LOCAL_ARM_MODE := arm

LOCAL_STATIC_LIBRARIES := libSEC_OMX_Venc libsecosal libsecbasecomponent \
	libseccscapi
LOCAL_SHARED_LIBRARIES := libc libdl libcutils libutils libui liblog \
	libSEC_OMX_Resourcemanager

LOCAL_HEADER_LIBRARIES := libseccscapi_headers

ifeq ($(TARGET_SOC),exynos4x12)
LOCAL_SHARED_LIBRARIES += libsecmfcdecapi libsecmfcencapi
LOCAL_HEADER_LIBRARIES += libsecmfcdecapi_headers libsecmfcencapi_headers
else
LOCAL_STATIC_LIBRARIES += libsecmfcapi
LOCAL_HEADER_LIBRARIES += libsecmfcapi_headers
endif

LOCAL_C_INCLUDES := $(SEC_OMX_INC)/khronos \
	$(SEC_OMX_INC)/sec \
	$(SEC_OMX_TOP)/osal \
	$(SEC_OMX_TOP)/core \
	$(SEC_OMX_COMPONENT)/common \
	$(SEC_OMX_COMPONENT)/video/enc

include $(BUILD_SHARED_LIBRARY)
