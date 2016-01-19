# Add more folders to ship with the application, here
folder_01.source = qml
#folder_01.target = qml
DEPLOYMENTFOLDERS = folder_01

#load Ubuntu specific features
load(ubuntu-click)

SUBDIRS += app

# specify the manifest file, this file is required for click
# packaging and for the IDE to create runconfigurations
UBUNTU_MANIFEST_FILE=manifest.json.in

QT += qml multimedia

QML_IMPORT_PATH =

# The .cpp file which was generated for your project. Feel free to hack it.
SOURCES += main.cpp

RESOURCES += \
    qml/resources.qrc

# Installation path
# target.path =

include(plugins/Bacon2D/src/Bacon2D-static.pri)

# Please do not modify the following two lines. Required for deployment.
include(qtquick2applicationviewer/qtquick2applicationviewer.pri)
qtcAddDeployment()

PKG_FILES += pathwind.apparmor \
             pathwind.desktop \
             pathwind.png

#specify where the pkg files are installed to
pkg_files.path = /
pkg_files.files += $${PKG_FILES}
message($$pkg_files.files)
INSTALLS+=pkg_files

ANDROID_EXTRA_LIBS = 

OTHER_FILES += \
    android/AndroidManifest.xml

ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android
