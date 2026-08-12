import QtQuick
import Quickshell
import Quickshell.Hyprland

Row {
    spacing: 6

    Repeater {
        model: Hyprland.workspaces

        delegate: Rectangle {
            required property var modelData

            width: 28
            height: 28
            radius: 8

            color: modelData.active
                ? "#ffffff"
                : "#252830"

            Text {
                anchors.centerIn: parent

                text: modelData.name
                color: modelData.active
                    ? "#111318"
                    : "#ffffff"

                font.pixelSize: 13
                font.bold: modelData.active
            }

            MouseArea {
                anchors.fill: parent

                onClicked: modelData.activate()
            }
        }
    }
}
