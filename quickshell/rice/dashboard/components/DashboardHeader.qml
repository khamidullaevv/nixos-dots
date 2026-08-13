import QtQuick
import "../../config"

Item {
    id: root

    property var appState

    height: 72


    Text {
        anchors {
            left: parent.left
            leftMargin: 24
            verticalCenter: parent.verticalCenter
        }

        text: "Dashboard"

        color: Theme.text

        font.pixelSize: 19
        font.bold: true
    }


    Rectangle {
        width: 36
        height: 36

        anchors {
            right: parent.right
            rightMargin: 20
            verticalCenter: parent.verticalCenter
        }

        radius: 11

        color: closeMouse.containsMouse
               ? Theme.surfaceVariant
               : "transparent"


        Text {
            anchors.centerIn: parent

            text: "×"

            color: Theme.textSecondary

            font.pixelSize: 22
        }


        MouseArea {
            id: closeMouse

            anchors.fill: parent

            hoverEnabled: true

            cursorShape: Qt.PointingHandCursor

            onClicked: {
                if (root.appState)
                    root.appState.dashboardOpen = false
            }
        }
    }
}