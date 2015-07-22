LOCAL_PATH:= $(call my-dir)
include $(CLEAR_VARS)

IWTOOLS := iwconfig iwlist iwspy iwpriv iwgetid iwevent

# From autoconf-generated Makefile
iwmulticall_SOURCES = iwmulticall.c \

LOCAL_SRC_FILES:= $(iwmulticall_SOURCES)

LOCAL_SHARED_LIBRARIES := 

LOCAL_C_INCLUDES := 

#LOCAL_CFLAGS+= -DWE_ESSENTIAL=y

LOCAL_MODULE := iwmulticall
LOCAL_MODULE_TAGS := debug eng optional

include $(BUILD_EXECUTABLE)

# Make #!/system/bin/iwmulticall launchers for each tool.
#
SYMLINKS := $(addprefix $(TARGET_OUT)/bin/,$(IWTOOLS))
$(SYMLINKS): IWMULTICALL_BINARY := $(LOCAL_MODULE)
$(SYMLINKS): $(LOCAL_INSTALLED_MODULE) $(LOCAL_PATH)/Android.mk
	@echo "Symlink: $@ -> $(IWMULTICALL_BINARY)"
	@mkdir -p $(dir $@)
	@rm -rf $@
	$(hide) ln -sf $(IWMULTICALL_BINARY) $@

ALL_DEFAULT_INSTALLED_MODULES += $(SYMLINKS)

# We need this so that the installed files could be picked up based on the
# local module name
ALL_MODULES.$(LOCAL_MODULE).INSTALLED := \
    $(ALL_MODULES.$(LOCAL_MODULE).INSTALLED) $(SYMLINKS)
