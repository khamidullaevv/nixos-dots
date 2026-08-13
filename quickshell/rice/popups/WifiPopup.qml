import QtQuick
import Quickshell
import Quickshell.Networking
import "../config"
import "../components"

PanelWindow {
    id: root

    required property var targetScreen
    property var appState
    property bool opened: appState ? appState.wifiOpen : false

    screen: targetScreen

    anchors {
        top: true
        right: true
    }

    margins {
        top: 64
        right: 16
    }

    implicitWidth: 360
    implicitHeight: 480

    color: "transparent"

    // Ищем Wi-Fi адаптер
    property var wifiDevice: {
        for (var i = 0; i < Networking.devices.values.length; ++i) {
            var device = Networking.devices.values[i]

            if (device.mode !== undefined) {
                return device
            }
        }

        return null
    }

    // Включаем сканирование
    Component.onCompleted: {
        if (wifiDevice) {
            wifiDevice.scannerEnabled = true
        }
    }

    PopupSurface {
        anchors.fill: parent
        opened: root.opened

        Column {
            anchors.fill: parent
            anchors.margins: Theme.spacingLarge
            spacing: Theme.spacingMedium

            // Заголовок
            Row {
                width: parent.width
                spacing: 10

                Text {
                    text: "󰖩"
                    color: Theme.accent
                    font.pixelSize: 24
                    anchors.verticalCenter: parent.verticalCenter
                }

                Column {
                    spacing: 2

                    Text {
                        text: "Wi-Fi"
                        color: Theme.text
                        font.pixelSize: 21
                        font.bold: true
                    }

                    Text {
                        text: root.wifiDevice
                              ? (root.wifiDevice.scannerEnabled
                                 ? "Scanning networks..."
                                 : "Scanner disabled")
                              : "No Wi-Fi adapter"
                        color: Theme.textSecondary
                        font.pixelSize: 12
                    }
                }
            }

            // Кнопка обновления
            Rectangle {
                width: parent.width
                height: 42
                radius: Theme.radiusMedium
                color: refreshMouse.containsMouse
                       ? Theme.surfaceVariant
                       : Theme.surfaceVariant

                Row {
                    anchors.centerIn: parent
                    spacing: 8

                    Text {
                        text: "󰑐"
                        color: Theme.accent
                        font.pixelSize: 17
                    }

                    Text {
                        text: "Scan for networks"
                        color: Theme.text
                        font.pixelSize: 13
                    }
                }

                MouseArea {
                    id: refreshMouse

                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor

                    onClicked: {
                        if (root.wifiDevice) {
                            root.wifiDevice.scannerEnabled = false
                            root.wifiDevice.scannerEnabled = true
                        }
                    }
                }
            }

            Text {
                text: "Available networks"
                color: Theme.textSecondary
                font.pixelSize: 13
                font.bold: true
            }

            // Список сетей
            ListView {
                id: networkList

                width: parent.width
                height: parent.height - 160

                clip: true
                spacing: 6

                model: root.wifiDevice
                       ? root.wifiDevice.networks
                       : null

                delegate: Rectangle {
                    required property var modelData

                    width: networkList.width
                    height: 58

                    radius: Theme.radiusMedium

                    color: modelData.connected
                           ? Theme.accentVariant
                           : networkMouse.containsMouse
                             ? Theme.surfaceVariant
                             : Theme.surfaceVariant

                    Row {
                        anchors.fill: parent
                        anchors.margins: 12
                        spacing: 12

                        Text {
                            text: modelData.connected
                                  ? "󰤨"
                                  : "󰤯"

                            color: modelData.connected
                                   ? Theme.accent
                                   : Theme.textSecondary

                            font.pixelSize: 22

                            anchors.verticalCenter: parent.verticalCenter
                        }

                        Column {
                            anchors.verticalCenter: parent.verticalCenter

                            width: parent.width - 50
                            spacing: 3

                            Text {
                                text: modelData.name || "Hidden network"

                                color: Theme.text
                                font.pixelSize: 13
                                font.bold: modelData.connected

                                width: parent.width
                                elide: Text.ElideRight
                            }

                            Text {
                                text: modelData.connected
                                      ? "Connected"
                                      : modelData.known
                                        ? "Saved network"
                                        : "Available"

                                color: Theme.textSecondary
                                font.pixelSize: 11
                            }
                        }
                    }

                    MouseArea {
                        id: networkMouse

                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor

                        onClicked: {
                            if (!modelData.connected) {
                                modelData.connect()
                            }
                        }
                    }
                }

                Text {
                    anchors.centerIn: parent

                    visible: networkList.count === 0

                    text: root.wifiDevice
                          ? "No networks found"
                          : "Wi-Fi adapter not found"

                    color: Theme.textSecondary
                    font.pixelSize: 13
                }
            }
        }
    }
}