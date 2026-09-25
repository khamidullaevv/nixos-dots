import QtQuick

import "../config"

Item {
    id: root

    property var appState

    anchors.fill: parent

    Rectangle {
        anchors.fill: parent

        color: "transparent"

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
                    text: "󰖩"

                    color: Theme.accent

                    font.pixelSize: 22
                }

                Column {
                    spacing: 2

                    Text {
                        text: "Wi-Fi"

                        color: Theme.text

                        font.pixelSize: 18
                        font.bold: true
                    }

                    Text {
                        text: "Network connection"

                        color: Theme.textSecondary

                        font.pixelSize: 11
                    }
                }
            }

            /*
             * Current connection
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

                        text: "󰤨"

                        color: Theme.success

                        font.pixelSize: 22
                    }

                    Column {
                        anchors.verticalCenter: parent.verticalCenter

                        spacing: 2

                        Text {
                            text: "Connected"

                            color: Theme.text

                            font.pixelSize: 13
                            font.bold: true
                        }

                        Text {
                            text: "Online"

                            color: Theme.success

                            font.pixelSize: 11
                        }
                    }

                    Item {
                        width: 1
                        height: 1
                    }
                }
            }

            Text {
                text: "Networks"

                color: Theme.textSecondary

                font.pixelSize: 12
            }

            /*
             * Network
             */

            Rectangle {
                width: parent.width
                height: 52

                radius: 13

                color: Theme.surfaceVariant

                Row {
                    anchors.fill: parent

                    anchors.leftMargin: 14
                    anchors.rightMargin: 14

                    spacing: 12

                    Text {
                        anchors.verticalCenter: parent.verticalCenter

                        text: "󰤨"

                        color: Theme.accent

                        font.pixelSize: 20
                    }

                    Column {
                        anchors.verticalCenter: parent.verticalCenter

                        spacing: 2

                        Text {
                            text: "Current Network"

                            color: Theme.text

                            font.pixelSize: 12
                            font.bold: true
                        }

                        Text {
                            text: "Connected"

                            color: Theme.textSecondary

                            font.pixelSize: 10
                        }
                    }
                }
            }

            /*
             * Footer
             */

            Rectangle {
                width: parent.width
                height: 42

                radius: 12

                color: Theme.surfaceVariant

                Text {
                    anchors.centerIn: parent

                    text: "Network settings"

                    color: Theme.textSecondary

                    font.pixelSize: 11
                }
            }
        }
    }
}