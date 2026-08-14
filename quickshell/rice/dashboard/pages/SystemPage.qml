import QtQuick
import QtQuick.Layouts

import "../../config"

Item {
    id: root

    Rectangle {
        anchors.fill: parent

        radius: 18

        color: Theme.background

        border.width: 1
        border.color: Theme.border
    }

    GridLayout {
        anchors.fill: parent

        anchors.margins: 16

        columns: 2

        rowSpacing: 10
        columnSpacing: 10

        StatCard {
            title: "RAM"
            value: "—"
            icon: "󰍛"
        }

        StatCard {
            title: "CPU"
            value: "—"
            icon: "󰻠"
        }

        StatCard {
            title: "DISK"
            value: "—"
            icon: "󰋊"
        }

        StatCard {
            title: "NETWORK"
            value: "Online"
            icon: "󰖩"
        }
    }

    component StatCard: Rectangle {
        id: card

        Layout.fillWidth: true
        Layout.fillHeight: true

        radius: 15

        color: Theme.surface

        border.width: 1
        border.color: Theme.border

        property string title
        property string value
        property string icon

        ColumnLayout {
            anchors.fill: parent

            anchors.margins: 14

            spacing: 5

            Text {
                text: card.icon

                color: Theme.accent

                font.pixelSize: 20
            }

            Item {
                Layout.fillHeight: true
            }

            Text {
                text: card.title

                color: Theme.textSecondary

                font.pixelSize: 9
                font.bold: true
            }

            Text {
                text: card.value

                color: Theme.text

                font.pixelSize: 15
                font.bold: true
            }
        }
    }
}