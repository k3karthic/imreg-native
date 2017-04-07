import QtQuick 2.7
import QtQuick.Controls 2.1
import QtQuick.Dialogs 1.0
import QtQuick.Layouts 1.1

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: qsTr("ImageRecognition")

    Shortcut {
        sequence: "Esc"
        enabled: stack.depth > 1
        onActivated: {
            stack.pop()
        }
    }

    header: ToolBar {
        background: Rectangle {
            implicitHeight: 50
            color: "#fff"

            Rectangle {
                width: parent.width
                height: 1
                anchors.bottom: parent.bottom
                color: "transparent"
                border.color: "#ddd"
            }
        }

        RowLayout {
            anchors.fill: parent

            Label {
                anchors.centerIn: parent
                text: "ImageRecognition"
                font.pixelSize: 20
            }
        }
    }

    StackView {
        id: stack

        anchors.fill: parent
        background: Image {
            fillMode: Image.Tile
            source: "qrc:/images/crossword.png"
        }

        initialItem: mainView
    }

    Component {
        id: mainView

        RowLayout {
            Rectangle {
                Layout.fillWidth: true
            }

            Button {
                text: "Select An Image"

                onClicked: {
                    fileDialog.visible = true;
                }
            }

            Rectangle {
                Layout.fillWidth: true
            }
        }
    }

    FileDialog {
        id: fileDialog
        title: "Please choose an image"
        nameFilters: [ "Image files (*.jpg *.png)" ]

        onAccepted: {
            CppModel.thumbnailSrc = fileDialog.fileUrl;
            stack.push(pictrueView);
        }
    }

    Component {
        id: pictrueView

        RowLayout {
            Rectangle {
                Layout.fillWidth: true
            }

            ColumnLayout {
                Image {
                    fillMode: Image.PreserveAspectFit
                    Layout.maximumHeight: stack.height * 0.3
                    Layout.maximumWidth: stack.width * 0.3

                    source: CppModel.thumbnailSrc
                }

                ListView {
                    id: tpm
                    width: childrenRect.width + 20
                    height: childrenRect.height + 20

                    model: CppModel.labels

                    delegate: Text {
                        text: modelData
                    }
                }
            }

            Rectangle {
                Layout.fillWidth: true
            }
        }
    }
}
