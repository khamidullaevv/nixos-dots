import QtQuick
import QtQuick.Controls
import Quickshell
import Quickshell.Services.Pipewire
import "../config"
import "../components"

PanelWindow {
    id: root

    required property var targetScreen
    property var appState
    property bool opened: appState ? appState.audioOpen : false

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
    implicitHeight: 300

    color: "transparent"

    // Привязываем текущий audio sink,
    // чтобы volume и muted были доступны для изменения.
    PwObjectTracker {
        objects: [Pipewire.defaultAudioSink]
    }

    property var sink: Pipewire.defaultAudioSink

    PopupSurface {
        anchors.fill: parent
        opened: root.opened

        Column {
            anchors.fill: parent
            anchors.margins: Theme.spacingLarge
            spacing: 16

            // Header
            Row {
                width: parent.width
                spacing: 10

                Text {
                    text: root.sink && root.sink.audio && root.sink.audio.muted
                          ? "󰖁"
                          : "󰕾"

                    color: Theme.accent
                    font.pixelSize: 25

                    anchors.verticalCenter: parent.verticalCenter
                }

                Column {
                    spacing: 2

                    Text {
                        text: "Audio"
                        color: Theme.text
                        font.pixelSize: 21
                        font.bold: true
                    }

                    Text {
                        text: root.sink
                              ? (root.sink.description || root.sink.name)
                              : "No audio device"

                        color: Theme.textSecondary
                        font.pixelSize: 12

                        width: 270
                        elide: Text.ElideRight
                    }
                }
            }

            // Volume
            Row {
                width: parent.width
                spacing: 10

                Text {
                    text: root.sink && root.sink.audio && root.sink.audio.muted
                          ? "Muted"
                          : Math.round(
                                root.sink && root.sink.audio
                                ? root.sink.audio.volume * 100
                                : 0
                            ) + "%"

                    color: Theme.text
                    font.pixelSize: 14
                    font.bold: true

                    width: 45
                    anchors.verticalCenter: parent.verticalCenter
                }

                Slider {
                    id: volumeSlider

                    width: parent.width - 55

                    from: 0
                    to: 1

                    value: root.sink && root.sink.audio
                           ? root.sink.audio.volume
                           : 0

                    onMoved: {
                        if (root.sink && root.sink.audio) {
                            root.sink.audio.volume = value
                        }
                    }
                }
            }

            // Mute button
            Rectangle {
                width: parent.width
                height: 48

                radius: Theme.radiusMedium

                color: muteMouse.containsMouse
                       ? Theme.surfaceVariant
                       : Theme.surfaceVariant

                Row {
                    anchors.centerIn: parent
                    spacing: 10

                    Text {
                        text: root.sink &&
                              root.sink.audio &&
                              root.sink.audio.muted
                              ? "󰖁"
                              : "󰕾"

                        color: Theme.accent
                        font.pixelSize: 20
                    }

                    Text {
                        text: root.sink &&
                              root.sink.audio &&
                              root.sink.audio.muted
                              ? "Unmute"
                              : "Mute"

                        color: Theme.text
                        font.pixelSize: 13
                    }
                }

                MouseArea {
                    id: muteMouse

                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor

                    onClicked: {
                        if (root.sink && root.sink.audio) {
                            root.sink.audio.muted =
                                !root.sink.audio.muted
                        }
                    }
                }
            }

            // Device status
            Text {
                width: parent.width

                text: root.sink
                      ? "Output device connected"
                      : "No output device detected"

                color: Theme.textSecondary
                font.pixelSize: 12
            }
        }
    }
}