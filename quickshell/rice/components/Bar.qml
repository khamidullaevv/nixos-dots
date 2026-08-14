import QtQuick

import "../config"
import "../dashboard"
import "../popups"

Item {
    id: root

    property var appState

    property int barHeight: 48
    property int dashboardHeight: 460

    width: parent ? parent.width : 0
    height: barHeight + dashboardHeight

    clip: false

    /*
     * =========================================================
     * MAIN BAR
     * =========================================================
     */

    Rectangle {
        id: barBackground

        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
        }

        height: root.barHeight

        radius: Theme.radiusMedium

        color: Theme.surface

        border.width: 1
        border.color: Theme.border
    }

    /*
     * =========================================================
     * LEFT SIDE
     * =========================================================
     */

    Row {
        id: leftSide

        anchors {
            left: parent.left
            leftMargin: 10
            top: parent.top
        }

        height: root.barHeight

        spacing: 8

        /*
         * Logo
         */

        Rectangle {
            width: 32
            height: 32

            anchors.verticalCenter: parent.verticalCenter

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

        /*
         * Name
         */

        Text {
            anchors.verticalCenter: parent.verticalCenter

            text: "SAIREX"

            color: Theme.text

            font.pixelSize: 13
            font.bold: true
        }

        /*
         * Divider
         */

        Rectangle {
            width: 1
            height: 20

            anchors.verticalCenter: parent.verticalCenter

            color: Theme.border
        }

        /*
         * Workspaces
         */

        Workspaces {
            anchors.verticalCenter: parent.verticalCenter
        }
    }

    /*
     * =========================================================
     * DASHBOARD BUTTON
     * =========================================================
     */

    Rectangle {
        id: dashboardButton

        anchors {
            top: parent.top
            horizontalCenter: parent.horizontalCenter
        }

        width: 130
        height: root.barHeight

        radius: 10

        color:
            dashboardMouse.containsMouse ||
            (root.appState && root.appState.dashboardOpen)
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

    /*
     * =========================================================
     * DASHBOARD PANEL
     * =========================================================
     */

    Rectangle {
    id: dashboardPanel

    anchors {
        top: dashboardButton.bottom
        horizontalCenter: dashboardButton.horizontalCenter
    }

    width: 560

    height:
        root.appState &&
        root.appState.dashboardOpen
        ? root.dashboardHeight
        : 0

    color: Theme.surface

    border.width: 1
    border.color: Theme.border

    radius: 24

    clip: true

    Dashboard {
        anchors.fill: parent
        appState: root.appState
    }

    Behavior on height {
        NumberAnimation {
            duration: 180
            easing.type: Easing.OutCubic
        }
    }
}
    /*
     * =========================================================
     * RIGHT SIDE
     * =========================================================
     */

    Row {
        id: rightSide

        anchors {
            right: parent.right
            rightMargin: 10
            top: parent.top
        }

        height: root.barHeight

        spacing: 3

        /*
         * =====================================================
         * WIFI BUTTON
         * =====================================================
         */

        Rectangle {
            id: wifiButton

            width: 92
            height: 34

            anchors.verticalCenter: parent.verticalCenter

            radius: 10

            color:
                wifiMouse.containsMouse ||
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

        /*
         * =====================================================
         * AUDIO BUTTON
         * =====================================================
         */

        Rectangle {
            id: audioButton

            width: 82
            height: 34

            anchors.verticalCenter: parent.verticalCenter

            radius: 10

            color:
                audioMouse.containsMouse ||
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

        /*
         * Divider
         */

        Rectangle {
            width: 1
            height: 20

            anchors.verticalCenter: parent.verticalCenter

            color: Theme.border
        }

        /*
         * =====================================================
         * CLOCK
         * =====================================================
         */

        Rectangle {
            width: 76
            height: 34

            anchors.verticalCenter: parent.verticalCenter

            radius: 10

            color:
                clockMouse.containsMouse
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
                    timeText.text =
                        Qt.formatDateTime(
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

    /*
     * =========================================================
     * WIFI PANEL
     * =========================================================
     */

    Rectangle {
        id: wifiPanel

        anchors {
            top: wifiButton.bottom
            right: wifiButton.right
        }

        width: 320

        height:
            root.appState &&
            root.appState.wifiOpen
            ? 360
            : 0

        color: Theme.surface

        border.width: 1
        border.color: Theme.border

        radius: 22

        clip: true

        WifiPopup {
            anchors.fill: parent

            appState: root.appState
        }

        Behavior on height {
            NumberAnimation {
                duration: 180

                easing.type: Easing.OutCubic
            }
        }
    }

    /*
     * =========================================================
     * AUDIO PANEL
     * =========================================================
     */

    Rectangle {
        id: audioPanel

        anchors {
            top: audioButton.bottom
            right: audioButton.right
        }

        width: 320

        height:
            root.appState &&
            root.appState.audioOpen
            ? 360
            : 0

        color: Theme.surface

        border.width: 1
        border.color: Theme.border

        radius: 22

        clip: true

        AudioPopup {
            anchors.fill: parent

            appState: root.appState
        }

        Behavior on height {
            NumberAnimation {
                duration: 180

                easing.type: Easing.OutCubic
            }
        }
    }
}