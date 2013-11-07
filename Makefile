ARCHS = armv7

SDKVERSION := 6.1
TARGET_IPHONEOS_DEPLOYMENT_VERSION := 6.0

TWEAK_NAME = AlarmControl
AlarmControl_FILES = Tweak.xm
AlarmControl_FRAMEWORKS = UIKit

THEOS_DEVICE_IP = 192.168.1.3
THEOS_BUILD_DIR = debs
GO_EASY_ON_ME=1

include theos/makefiles/common.mk
include theos/makefiles/tweak.mk
include theos/makefiles/bundle.mk
include $(THEOS_MAKE_PATH)/aggregate.mk