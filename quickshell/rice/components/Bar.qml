import QtQuick
import Quickshell
import "."

Rectangle {
    id: root

    property var shellState

    anchors.fill: parent

    radius: 12

    color: "#111318"

    border.width: 1
    border.color: "#292d35"

    // =========================
    // LEFT
    // =========================

    Row {
        anchors.left: parent.left
        anchors.leftMargin: 14
        anchors.verticalCenter: parent.verticalCenter

        spacing: 10

        Text {
            text: "SAIREX"

            color: "#ffffff"

            font.pixelSize: 14
            font.bold: true

            anchors.verticalCenter: parent.verticalCenter
        }

        Rectangle {
            width: 1
            height: 20

            color: "#33363d"

            anchors.verticalCenter: parent.verticalCenter
        }

        Workspaces {
            anchors.verticalCenter: parent.verticalCenter
        }
    }

    // =========================
    // CENTER
    // =========================

    Text {
        anchors.centerIn: parent

        text: "Desktop"

        color: "#ffffff"

        font.pixelSize: 13
    }

    // =========================
    // RIGHT
    // =========================

    Row {
        anchors.right: parent.right
        anchors.rightMargin: 14
        anchors.verticalCenter: parent.verticalCenter

        spacing: 8

        // WIFI
        Rectangle {
            width: 82
            height: 30

            radius: 9

            color: wifiMouse.containsMouse
                ? "#252830"
                : "transparent"

            Text {
                anchors.centerIn: parent

                text: "󰖩  Online"

                color: "#ffffff"

                font.pixelSize: 13
            }

            MouseArea {
                id: wifiMouse

                anchors.fill: parent

                hoverEnabled: true

                cursorShape: Qt.PointingHandCursor

                onClicked: {
                    shellState.toggleWifi()
                }
            }
        }

        // AUDIO
        Rectangle {
            width: 62
            height: 30

            radius: 9

            color: audioMouse.containsMouse
                ? "#252830"
                : "transparent"

            Text {
                anchors.centerIn: parent

                text: "󰕾 40%"

                color: "#ffffff"

                font.pixelSize: 13
            }

            MouseArea {
                id: audioMouse

                anchors.fill: parent

                hoverEnabled: true

                cursorShape: Qt.PointingHandCursor

                onClicked: {
                    shellState.toggleAudio()
                }
            }
        }

        Rectangle {
            width: 1
            height: 20

            color: "#33363d"

            anchors.verticalCenter: parent.verticalCenter
        }

        Clock {
            anchors.verticalCenter: parent.verticalCenter
        }
    }
}