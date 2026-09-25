import QtQuick

import "../../config"

Item {
    id: root

    property int currentPage: 0

    signal pageChanged(int page)

    width: 156
    height: 34

    Rectangle {
        anchors.fill: parent

        radius: 17

        color: Theme.surfaceVariant

        border.width: 1
        border.color: Theme.border
    }

    Row {
        anchors.centerIn: parent

        spacing: 8

        Repeater {
            model: 3

            Rectangle {
                required property int index

                width: root.currentPage === index ? 28 : 7
                height: 7

                radius: 7

                color:
                    root.currentPage === index
                    ? Theme.accent
                    : Theme.border

                Behavior on width {
                    NumberAnimation {
                        duration: 180
                        easing.type: Easing.OutCubic
                    }
                }

                Behavior on color {
                    ColorAnimation {
                        duration: 140
                    }
                }

                MouseArea {
                    anchors.fill: parent

                    cursorShape: Qt.PointingHandCursor

                    onClicked: {
                        root.pageChanged(index)
                    }
                }
            }
        }
    }
}