TARGET := iphone:clang:latest:7.0


include $(THEOS)/makefiles/common.mk

TWEAK_NAME = FLEXInject

FLEXInject_FILES = Tweak.xm
FLEXInject_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
