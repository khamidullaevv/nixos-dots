import QtQuick
import Quickshell.Hyprland
import "../config"

Row {
    id: root

    spacing: 5

    Repeater {
        model: 5

        delegate: Rectangle {
            required property int index

            property int workspaceId: index + 1

            property bool active:
                Hyprland.focusedWorkspace &&
                Hyprland.focusedWorkspace.id === workspaceId

            width: active ? 30 : 24
            height: 24
            radius: 7

            color: active
                   ? Theme.accent
                   : workspaceMouse.containsMouse
                     ? Theme.surfaceVariant
                     : "transparent"

            Behavior on width {
                NumberAnimation {
                    duration: 120
                    easing.type: Easing.OutCubic
                }
            }

            Text {
                anchors.centerIn: parent

                text: workspaceId

                color: active
                       ? Theme.background
                       : Theme.textSecondary

                font.pixelSize: 11
                font.bold: active
            }

            MouseArea {
                id: workspaceMouse

                anchors.fill: parent
                hoverEnabled: true

                cursorShape: Qt.PointingHandCursor

                onClicked: {
                    Hyprland.dispatch(
                        "workspace " + workspaceId
                    )
                }
            }
        }
    }
}