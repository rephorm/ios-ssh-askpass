include theos/makefiles/common.mk

TOOL_NAME = ios-ssh-askpass
ios-ssh-askpass_FILES = main.mm
ios-ssh-askpass_INSTALL_PATH = /usr/libexec

include $(THEOS_MAKE_PATH)/tool.mk

after-stage::
	$(ECHO_NOTHING)ln -sf $(THEOS_STAGING_DIR)/usr/libexec/ios-ssh-askpass $(THEOS_STAGING_DIR)/usr/libexec/ssh-askpass$(ECHO_END)
