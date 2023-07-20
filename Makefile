TARGET := iphone:14.5:10.0
SYSROOT := $(THEOS)/sdks/iPhoneOS15.5.sdk
FINALPACKAGE = 1

define find_sources
	$(wildcard $(1)/*.*m $(1)/*.c) $(foreach dir,$(wildcard $(1)/*),$(call find_sources,$(dir)))
endef

define find_header_dirs
	$(sort $(dir $(wildcard $(1)/*.h)) $(foreach dir,$(wildcard $(1)/*),$(call find_header_dirs,$(dir))))
endef

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = FLEX

SRC_DIR := Source
HEADER_DIRS := $(call find_header_dirs,$(SRC_DIR))

FLEX_FILES += FLEXRootListController.m FlexInjectCenter.m FlexInjectApp.m $(call find_sources, $(SRC_DIR))
FLEX_FRAMEWORKS = UIKit CoreServices
FLEX_PRIVATE_FRAMEWORKS = UIKitCore Preferences 
FLEX_INSTALL_PATH = /Library/PreferenceBundles
FLEX_CFLAGS += -fobjc-arc
FLEX_CFLAGS += -Wno-deprecated-declarations -Wno-strict-prototypes -Wno-unsupported-availability-guard -Wno-unused-but-set-variable
FLEX_CFLAGS += $(foreach header_dir,$(HEADER_DIRS),-I$(header_dir))

include $(THEOS_MAKE_PATH)/bundle.mk

SUBPROJECTS += flexinject
include $(THEOS_MAKE_PATH)/aggregate.mk

after-install::
	install.exec "killall -9 Preferences"
