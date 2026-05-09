export ARCHS = arm64 arm64e
export TARGET = iphone:clang:latest:14.0

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = PESAutoPlayMod
PESAutoPlayMod_FILES = Tweak.xm
PESAutoPlayMod_CFLAGS = -fobjc-arc
PESAutoPlayMod_LDFLAGS = -lsubstrate

include $(THEOS_MAKE_PATH)/tweak.mk
