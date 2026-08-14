import QtQuick

import "../../config"
import "../../services"

Item {
    id: root

    Rectangle {
        anchors.fill: parent

        radius: 18

        color: Theme.background

        border.width: 1
        border.color: Theme.border
    }

    Column {
        anchors.centerIn: parent

        width: parent.width - 60

        spacing: 22

        Text {
            anchors.horizontalCenter: parent.horizontalCenter

            text: "AUDIO VISUALIZER"

            color: Theme.textSecondary

            font.pixelSize: 10
            font.bold: true
        }

        Row {
            anchors.horizontalCenter: parent.horizontalCenter

            spacing: 4

            Repeater {
                model: CavaService.values.length

                Rectangle {
                    required property int index

                    width: 7

                    height:
                        Math.max(
                            5,
                            CavaService.values[index] *
                            120
                        )

                    radius: 4

                    color:
                        index % 5 === 0
                        ? Theme.accent
                        : Theme.surfaceVariant

                    anchors.verticalCenter:
                        parent.verticalCenter

                    Behavior on height {
                        NumberAnimation {
                            duration: 70
                            easing.type: Easing.OutCubic
                        }
                    }
                }
            }
        }

        Text {
            anchors.horizontalCenter: parent.horizontalCenter

            text:
                MprisService.hasPlayer
                ? MprisService.title
                : "Нет активного трека"

            color: Theme.text

            font.pixelSize: 15
            font.bold: true

            elide: Text.ElideRight
        }

        Text {
            anchors.horizontalCenter: parent.horizontalCenter

            text: MprisService.artist

            color: Theme.textSecondary

            font.pixelSize: 11
        }
    }
}