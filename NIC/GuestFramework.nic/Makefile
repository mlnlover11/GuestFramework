ARCHS = armv7 armv7s arm64
CFLAGS = -fobjc-arc
TARGET = iphone:clang:7.1:7.1

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = @@PROJECTNAME@@
@@PROJECTNAME@@_FILES = Plugin.xm
@@PROJECTNAME@@_FRAMEWORKS = UIKit
@@PROJECTNAME@@_LIBRARIES = guest substrate
@@PROJECTNAME@@_INSTALL_PATH = /Library/GuestFramework/Plugins

include $(THEOS_MAKE_PATH)/bundle.mk