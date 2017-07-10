QT += qml quick

CONFIG += c++11

SOURCES += main.cpp \
    cppmodel.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# The following define makes your compiler emit warnings if you use
# any feature of Qt which as been marked deprecated (the exact warnings
# depend on your compiler). Please consult the documentation of the
# deprecated API in order to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

# You can also make your code fail to compile if you use deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

HEADERS += \
    cppmodel.hpp

## Link mxnet-image-classification

win32:CONFIG(release, debug|release): LIBS += -L$$PWD/../mxnet-image-classification/src/release/ -lmxnet_predict
else:win32:CONFIG(debug, debug|release): LIBS += -L$$PWD/../mxnet-image-classification/src/debug/ -lmxnet_predict
else:unix: LIBS += -L$$PWD/../mxnet-image-classification/src/release/ -lmxnet_predict

INCLUDEPATH += $$PWD/../mxnet-image-classification/src
DEPENDPATH += $$PWD/../mxnet-image-classification/src

## Link MXNet library

unix|win32: LIBS += -L$(MXNET_HOME)/lib -llibmxnet

INCLUDEPATH += $(MXNET_HOME)/include
DEPENDPATH += $(MXNET_HOME)/include

## Link OpenCV library

win32:CONFIG(release, debug|release): LIBS += -L$(OPENCV_HOME)/build/x64/vc14/lib -lopencv_world320
else:win32:CONFIG(debug, debug|release): LIBS += -L$(OPENCV_HOME)/build/x64/vc14/lib -lopencv_world320d
else:unix: LIBS += -lopencv_world320

INCLUDEPATH += $(OPENCV_HOME)/build/include
DEPENDPATH += $(OPENCV_HOME)/build/include
