# Auto-generated by IDE. All changes by user will be lost!
# Created at 2012/12/21 8:55 PM

BASEDIR = $$_PRO_FILE_PWD_

INCLUDEPATH +=  \
    $$BASEDIR/src/objects \
    $$BASEDIR/src

SOURCES +=  \
    $$BASEDIR/src/HttpContactList.cpp \
    $$BASEDIR/src/main.cpp \
    $$BASEDIR/src/objects/Employee.cpp

HEADERS +=  \
    $$BASEDIR/src/HttpContactList.hpp \
    $$BASEDIR/src/objects/Employee.h

CONFIG += precompile_header
PRECOMPILED_HEADER = $$BASEDIR/precompiled.h

lupdate_inclusion {
    SOURCES += \
        $$BASEDIR/../assets/*.qml
}

TRANSLATIONS = \
    $${TARGET}.ts

