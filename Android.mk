LOCAL_PATH := $(call my-dir)

pigz_src_files := pigz.c yarn.c
zopfli_src_files := zopfli/blocksplitter.c \
					zopfli/cache.c \
					zopfli/deflate.c \
					zopfli/tree.c \
					zopfli/lz77.c \
					zopfli/hash.c \
					zopfli/util.c \
					zopfli/squeeze.c \
					zopfli/katajainen.c

include $(CLEAR_VARS)
LOCAL_MODULE := libzopfli
LOCAL_MODULE_TAGS := optional
LOCAL_SRC_FILES := $(zopfli_src_files)
LOCAL_C_INCLUDES := $(LOCAL_PATH) external/zlib external/pigz/zopfli
include $(BUILD_STATIC_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE := libpigz
LOCAL_MODULE_TAGS := optional
LOCAL_SRC_FILES := $(pigz_src_files)
LOCAL_C_INCLUDES := $(LOCAL_PATH) external/zlib external/pigz/zopfli
include $(BUILD_STATIC_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE := libminipigz
LOCAL_MODULE_TAGS := optional
LOCAL_SRC_FILES := $(pigz_src_files)
LOCAL_C_INCLUDES := $(LOCAL_PATH) external/zlib external/pigz/zopfli
LOCAL_CFLAGS := -DWITHOUT_ZOPFLI
include $(BUILD_STATIC_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE := pigz
LOCAL_MODULE_TAGS := optional
LOCAL_SRC_FILES := main.c
LOCAL_SHARED_LIBRARIES := libz libc
LOCAL_STATIC_LIBRARIES := libpigz libzopfli
LOCAL_MODULE_PATH := $(TARGET_OUT_OPTIONAL_EXECUTABLES)

PIGZ_TOOLS := unpigz gzip gunzip
LOCAL_POST_INSTALL_CMD := $(hide) $(foreach t,$(ALL_TOOLS),ln -sf pigz $(TARGET_OUT)/xbin/$(t);)

include $(BUILD_EXECUTABLE)
