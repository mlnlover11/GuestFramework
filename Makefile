THEOS_DEVICE_IP=192.168.7.146
THEOS_PACKAGE_DIR_NAME = debs

include $(THEOS)/makefiles/common.mk

after-install::
	install.exec "killall -9 Preferences"

#core projects
SUBPROJECTS += libguest
SUBPROJECTS += libguestactivationmethods

#preferences
SUBPROJECTS += guestframeworksettings

#plugins / samples / etc
SUBPROJECTS += plugins/sample_plugin
SUBPROJECTS += plugins/spotlightplugin
SUBPROJECTS += plugins/iconrestrictorplugin
SUBPROJECTS += plugins/notificationcenter
SUBPROJECTS += plugins/controlcenter
SUBPROJECTS += plugins/appswitcher
SUBPROJECTS += plugins/phoneplugin/lgphoneapphelper
SUBPROJECTS += plugins/phoneplugin/mobilephone
SUBPROJECTS += plugins/newsstand
SUBPROJECTS += plugins/siri

include $(THEOS_MAKE_PATH)/aggregate.mk
