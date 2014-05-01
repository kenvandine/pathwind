# Add more folders to ship with the application, here
folder_01.source = qml
folder_01.target = qml
DEPLOYMENTFOLDERS = folder_01

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

ANDROID_EXTRA_LIBS = 

#ARCH = $$system($$quote(dpkg-architecture -qDEB_BUILD_ARCH))
#manifest.files = manifest.json
#QMAKE_SUBSTITUTES += $${manifest.files}.in
#manifest.CONFIG = no_check_exist
#QMAKE_EXTRA_TARGETS += manifest
#QMAKE_CLEAN += $${manifest.files}

OTHER_FILES +=
