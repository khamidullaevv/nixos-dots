import QtQuick
import Quickshell
import QtQuick.Controls

PanelWindow {
    id: root

    required property var targetScreen

    screen: targetScreen

    anchors {
        top: true
        right: true
    }

    margins {
        top: 60
        right: 16
    }

    implicitWidth: 340
    implicitHeight: 420

    color: "transparent"

    property bool opened: true

    Rectangle {
        id: panel

        anchors.fill: parent

        radius: 18

        color: "#15171c"

        border.width: 1
        border.color: "#2b2f38"

        scale: root.opened ? 1 : 0.94
        opacity: root.opened ? 1 : 0

        Behavior on scale {
            NumberAnimation {
                duration: 180
                easing.type: Easing.OutCubic
            }
        }

        Behavior on opacity {
            NumberAnimation {
                duration: 140
            }
        }

        Column {
            anchors.fill: parent
            anchors.margins: 20

            spacing: 16

            Text {
                text: "Wi-Fi"

                color: "white"
                font.pixelSize: 22
                font.bold: true
            }

            Rectangle {
                width: parent.width
                height: 1

                color: "#2b2f38"
            }

            Text {
                text: "Connected"

                color: "#8f96a3"
                font.pixelSize: 13
            }

            Rectangle {
                width: parent.width
                height: 64

                radius: 14

                color: "#20232a"

                Row {
                    anchors.fill: parent
                    anchors.margins: 14

                    spacing: 14

                    Text {
                        text: "󰖩"

                        color: "#ffffff"
                        font.pixelSize: 26

                        anchors.verticalCenter: parent.verticalCenter
                    }

                    Column {
                        anchors.verticalCenter: parent.verticalCenter

                        spacing: 3

                        Text {
                            text: "Wi-Fi"

                            color: "white"
                            font.pixelSize: 14
                            font.bold: true
                        }

                        Text {
                            text: "Connected"

                            color: "#8f96a3"
                            font.pixelSize: 12
                        }
                    }
                }
            }

            Text {
                text: "Available networks"

                color: "#8f96a3"
                font.pixelSize: 13
            }

            Text {
                text: "Network scanning will be added next."

                color: "#ffffff"
                font.pixelSize: 13
                wrapMode: Text.WordWrap

                width: parent.width
            }
        }
    }
}