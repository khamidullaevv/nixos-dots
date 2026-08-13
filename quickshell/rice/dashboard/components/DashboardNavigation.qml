import QtQuick
import "../../config"

Item {
    id: root

    property int currentPage: 0

    signal pageChanged(int page)

    width: 150
    height: 44


    Rectangle {
        anchors.fill: parent

        radius: 22

        color: Theme.surfaceVariant
    }


    Row {
        anchors.centerIn: parent

        spacing: 8


        Repeater {
            model: 3

            Rectangle {
                required property int index

                width: root.currentPage === index
                       ? 30
                       : 8

                height: 8

                radius: 8

                color: root.currentPage === index
                       ? Theme.accent
                       : Theme.border


                Behavior on width {
                    NumberAnimation {
                        duration: 180

                        easing.type: Easing.OutCubic
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