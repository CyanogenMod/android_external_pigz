LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE := pigz
LOCAL_MODULE_TAGS := optional
LOCAL_SRC_FILES := pigz.c yarn.c
LOCAL_C_INCLUDES := $(LOCAL_PATH) external/zlib external/zlib/zopfli
LOCAL_SHARED_LIBRARIES := libz libc
LOCAL_STATIC_LIBRARIES := libzopfli
LOCAL_MODULE_PATH := $(TARGET_OUT_OPTIONAL_EXECUTABLES)
include $(BUILD_EXECUTABLE)

PIGZ_TOOLS := unpigz
SYMLINKS := $(addprefix $(TARGET_OUT_OPTIONAL_EXECUTABLES)/,$(PIGZ_TOOLS))
$(SYMLINKS): PIGZ_BINARY := $(LOCAL_MODULE)
$(SYMLINKS): $(LOCAL_INSTALLED_MODULE)
	@echo "Symlink: $@ -> $(PIGZ_BINARY)"
	@mkdir -p $(dir $@)
	@rm -rf $@
	$(hide) ln -sf $(PIGZ_BINARY) $@

ALL_DEFAULT_INSTALLED_MODULES += $(SYMLINKS)

# We need this so that the installed files could be picked up based on the
# local module name
ALL_MODULES.$(LOCAL_MODULE).INSTALLED := \
    $(ALL_MODULES.$(LOCAL_MODULE).INSTALLED) $(SYMLINKS)

include external/pigz/zopfli/Android.mk
