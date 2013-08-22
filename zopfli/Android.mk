LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)
LOCAL_MODULE := libzopfli
LOCAL_MODULE_TAGS := optional
LOCAL_SRC_FILES := blocksplitter.c cache.c deflate.c tree.c lz77.c hash.c util.c squeeze.c katajainen.c
include $(BUILD_STATIC_LIBRARY)

