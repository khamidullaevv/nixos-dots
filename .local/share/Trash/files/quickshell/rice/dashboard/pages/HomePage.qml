import QtQuick
import QtQuick.Layouts

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

    GridLayout {
        anchors.fill: parent

        anchors.margins: 14

        columns: 2

        rowSpacing: 10
        columnSpacing: 10

        SystemCard {
            title: "MEMORY"
            value: SystemService.ramText
            progress: SystemService.ram
            icon: "󰍛"
        }

        SystemCard {
            title: "DISK"
            value: SystemService.diskText
            progress: SystemService.disk
            icon: "󰋊"
        }

        SystemCard {
            title: "NETWORK"
            value: SystemService.network
            progress: SystemService.network === "Online" ? 1 : 0
            icon: "󰖩"
        }

        SystemCard {
            title: "UPTIME"
            value: SystemService.uptime
            progress: 1
            icon: "󰅐"
        }
    }

    component SystemCard: Rectangle {
        id: card

        property string title
        property string value
        property real progress
        property string icon

        Layout.fillWidth: true
        Layout.fillHeight: true

        radius: 16

        color: Theme.surface

        border.width: 1
        border.color: Theme.border

        ColumnLayout {
            anchors.fill: parent

            anchors.margins: 14

            spacing: 6

            Text {
                text: card.icon

                color: Theme.accent

                font.pixelSize: 19
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

                font.pixelSize: 13
                font.bold: true

                elide: Text.ElideRight
            }

            Rectangle {
                Layout.fillWidth: true

                height: 4

                radius: 4

                color: Theme.surfaceVariant

                Rectangle {
                    width:
                        parent.width *
                        Math.max(
                            0,
                            Math.min(
                                1,
                                card.progress
                            )
                        )

                    height: parent.height

                    radius: 4

                    color: Theme.accent
                }
            }
        }
    }
}