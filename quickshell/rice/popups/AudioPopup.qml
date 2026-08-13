import QtQuick

import "../config"

Item {
    id: root

    property var appState

    anchors.fill: parent

    Column {
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right

            topMargin: 20
            leftMargin: 20
            rightMargin: 20
        }

        spacing: 16

        /*
         * Header
         */

        Row {
            width: parent.width

            spacing: 10

            Text {
                text: "󰕾"

                color: Theme.accent

                font.pixelSize: 22
            }

            Column {
                spacing: 2

                Text {
                    text: "Audio"

                    color: Theme.text

                    font.pixelSize: 18
                    font.bold: true
                }

                Text {
                    text: "Sound output"

                    color: Theme.textSecondary

                    font.pixelSize: 11
                }
            }
        }

        /*
         * Output device
         */

        Rectangle {
            width: parent.width
            height: 62

            radius: 14

            color: Theme.surfaceVariant

            Row {
                anchors.fill: parent

                anchors.leftMargin: 16
                anchors.rightMargin: 16

                spacing: 12

                Text {
                    anchors.verticalCenter: parent.verticalCenter

                    text: "󰓃"

                    color: Theme.accent

                    font.pixelSize: 22
                }

                Column {
                    anchors.verticalCenter: parent.verticalCenter

                    spacing: 2

                    Text {
                        text: "Default Output"

                        color: Theme.text

                        font.pixelSize: 13
                        font.bold: true
                    }

                    Text {
                        text: "Speakers"

                        color: Theme.textSecondary

                        font.pixelSize: 11
                    }
                }
            }
        }

        /*
         * Volume
         */

        Text {
            text: "Volume"

            color: Theme.textSecondary

            font.pixelSize: 12
        }

        Rectangle {
            width: parent.width
            height: 10

            radius: 5

            color: Theme.surfaceVariant

            Rectangle {
                width: parent.width * 0.65

                height: parent.height

                radius: 5

                color: Theme.accent
            }
        }

        Text {
            text: "65%"

            color: Theme.text

            font.pixelSize: 12
        }

        /*
         * Output devices
         */

        Text {
            text: "Output devices"

            color: Theme.textSecondary

            font.pixelSize: 12
        }

        Rectangle {
            width: parent.width
            height: 50

            radius: 13

            color: Theme.surfaceVariant

            Row {
                anchors.fill: parent

                anchors.leftMargin: 14

                spacing: 12

                Text {
                    anchors.verticalCenter: parent.verticalCenter

                    text: "󰓃"

                    color: Theme.accent

                    font.pixelSize: 19
                }

                Text {
                    anchors.verticalCenter: parent.verticalCenter

                    text: "Speakers"

                    color: Theme.text

                    font.pixelSize: 12
                }
            }
        }
    }
}