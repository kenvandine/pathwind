TEMPLATE = app
TARGET = pathwind

QT += qml quick

SOURCES += main.cpp

RESOURCES += pathwind.qrc

OTHER_FILES += pathwind.apparmor \
               pathwind.desktop \
               pathwind.png

#specify where the config files are installed to
config_files.path = /pathwind
config_files.files += $${OTHER_FILES}
message($$config_files.files)
INSTALLS+=config_files

# Default rules for deployment.
include(../deployment.pri)

