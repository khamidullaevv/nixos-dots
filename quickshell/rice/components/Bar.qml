import QtQuick
import Quickshell
import "../config"

Rectangle {
    id: root

    property var appState

    anchors.fill: parent

    radius: Theme.radiusMedium
    color: Theme.surface

    border.width: 1
    border.color: Theme.border


    // =========================================================
    // LEFT SIDE
    // =========================================================

    Row {
        id: leftSide

        anchors {
            left: parent.left
            leftMargin: 10
            verticalCenter: parent.verticalCenter
        }

        spacing: 8


        // Logo
        Rectangle {
            width: 32
            height: 32
            radius: 10

            color: Theme.accentVariant

            Text {
                anchors.centerIn: parent

                text: "S"

                color: Theme.accent
                font.pixelSize: 15
                font.bold: true
            }
        }


        // Name
        Text {
            anchors.verticalCenter: parent.verticalCenter

            text: "SAIREX"

            color: Theme.text

            font.pixelSize: 13
            font.bold: true
        }


        // Separator
        Rectangle {
            width: 1
            height: 20

            anchors.verticalCenter: parent.verticalCenter

            color: Theme.border
        }


        // Workspaces
        Workspaces {
            anchors.verticalCenter: parent.verticalCenter
        }
    }


    // =========================================================
    // CENTER
    // =========================================================

    Rectangle {
        id: dashboardButton

        anchors.centerIn: parent

        width: 130
        height: 32

        radius: 10

        color: dashboardMouse.containsMouse
               ? Theme.surfaceVariant
               : "transparent"


        Row {
            anchors.centerIn: parent

            spacing: 8


            Text {
                anchors.verticalCenter: parent.verticalCenter

                text: "󰕮"

                color: Theme.accent

                font.pixelSize: 17
            }


            Text {
                anchors.verticalCenter: parent.verticalCenter

                text: "Dashboard"

                color: Theme.text

                font.pixelSize: 12
            }
        }


        MouseArea {
            id: dashboardMouse

            anchors.fill: parent

            hoverEnabled: true

            cursorShape: Qt.PointingHandCursor

            onClicked: {
                if (root.appState)
                    root.appState.toggleDashboard()
            }
        }


        Behavior on color {
            ColorAnimation {
                duration: 120
            }
        }
    }


    // =========================================================
    // RIGHT SIDE
    // =========================================================

    Row {
        id: rightSide

        anchors {
            right: parent.right
            rightMargin: 10
            verticalCenter: parent.verticalCenter
        }

        spacing: 3


        // =====================================================
        // WIFI
        // =====================================================

        Rectangle {
            width: 92
            height: 34

            radius: 10

            color: wifiMouse.containsMouse ||
                   (root.appState && root.appState.wifiOpen)
                   ? Theme.surfaceVariant
                   : "transparent"


            Row {
                anchors.centerIn: parent

                spacing: 7


                Text {
                    anchors.verticalCenter: parent.verticalCenter

                    text: "󰖩"

                    color: Theme.accent

                    font.pixelSize: 17
                }


                Text {
                    anchors.verticalCenter: parent.verticalCenter

                    text: "Online"

                    color: Theme.text

                    font.pixelSize: 12
                }
            }


            MouseArea {
                id: wifiMouse

                anchors.fill: parent

                hoverEnabled: true

                cursorShape: Qt.PointingHandCursor

                onClicked: {
                    if (root.appState)
                        root.appState.toggleWifi()
                }
            }


            Behavior on color {
                ColorAnimation {
                    duration: 120
                }
            }
        }


        // =====================================================
        // AUDIO
        // =====================================================

        Rectangle {
            width: 82
            height: 34

            radius: 10

            color: audioMouse.containsMouse ||
                   (root.appState && root.appState.audioOpen)
                   ? Theme.surfaceVariant
                   : "transparent"


            Row {
                anchors.centerIn: parent

                spacing: 7


                Text {
                    anchors.verticalCenter: parent.verticalCenter

                    text: "󰕾"

                    color: Theme.accent

                    font.pixelSize: 17
                }


                Text {
                    anchors.verticalCenter: parent.verticalCenter

                    text: "Audio"

                    color: Theme.text

                    font.pixelSize: 12
                }
            }


            MouseArea {
                id: audioMouse

                anchors.fill: parent

                hoverEnabled: true

                cursorShape: Qt.PointingHandCursor

                onClicked: {
                    if (root.appState)
                        root.appState.toggleAudio()
                }
            }


            Behavior on color {
                ColorAnimation {
                    duration: 120
                }
            }
        }


        // =====================================================
        // SEPARATOR
        // =====================================================

        Rectangle {
            width: 1
            height: 20

            anchors.verticalCenter: parent.verticalCenter

            color: Theme.border
        }


        // =====================================================
        // CLOCK
        // =====================================================

        Rectangle {
            width: 76
            height: 34

            radius: 10

            color: clockMouse.containsMouse
                   ? Theme.surfaceVariant
                   : "transparent"


            Column {
                anchors.centerIn: parent

                spacing: 0


                Text {
                    id: timeText

                    anchors.horizontalCenter: parent.horizontalCenter

                    text: Qt.formatDateTime(
                        new Date(),
                        "HH:mm"
                    )

                    color: Theme.text

                    font.pixelSize: 12
                    font.bold: true
                }


                Text {
                    anchors.horizontalCenter: parent.horizontalCenter

                    text: Qt.formatDateTime(
                        new Date(),
                        "ddd, d MMM"
                    )

                    color: Theme.textSecondary

                    font.pixelSize: 9
                }
            }


            MouseArea {
                id: clockMouse

                anchors.fill: parent

                hoverEnabled: true

                cursorShape: Qt.PointingHandCursor

                onClicked: {
                    if (root.appState)
                        root.appState.toggleDashboard()
                }
            }


            Timer {
                interval: 1000

                running: true
                repeat: true

                onTriggered: {
                    timeText.text = Qt.formatDateTime(
                        new Date(),
                        "HH:mm"
                    )
                }
            }


            Behavior on color {
                ColorAnimation {
                    duration: 120
                }
            }
        }
    }
}