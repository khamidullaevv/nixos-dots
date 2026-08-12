import QtQuick
import Quickshell
import Quickshell.Services.Pipewire
import QtQuick.Controls

PanelWindow {
    id: root

    required property var targetScreen
    property var shellState
    property bool opened: shellState ? shellState.audioOpen : false
    screen: targetScreen

    anchors {
        top: true
        right: true
    }

    margins {
        top: 60
        right: 16
    }

    implicitWidth: 340
    implicitHeight: 300

    color: "transparent"

    property bool opened: true

    Rectangle {
        id: panel

        anchors.fill: parent

        radius: 18

        color: "#15171c"

        border.width: 1
        border.color: "#2b2f38"

        scale: root.opened ? 1 : 0.94
        opacity: root.opened ? 1 : 0

        Behavior on scale {
            NumberAnimation {
                duration: 180
                easing.type: Easing.OutCubic
            }
        }

        Behavior on opacity {
            NumberAnimation {
                duration: 140
            }
        }

        Column {
            anchors.fill: parent
            anchors.margins: 20

            spacing: 18

            Text {
                text: "Audio"

                color: "white"
                font.pixelSize: 22
                font.bold: true
            }

            Rectangle {
                width: parent.width
                height: 64

                radius: 14

                color: "#20232a"

                Row {
                    anchors.fill: parent
                    anchors.margins: 14

                    spacing: 14

                    Text {
                        text: "󰕾"

                        color: "white"
                        font.pixelSize: 26

                        anchors.verticalCenter: parent.verticalCenter
                    }

                    Column {
                        anchors.verticalCenter: parent.verticalCenter

                        spacing: 3

                        Text {
                            text: Pipewire.defaultAudioSink
                                  ? Pipewire.defaultAudioSink.description
                                  : "No audio device"

                            color: "white"
                            font.pixelSize: 13
                            font.bold: true

                            width: 220
                            elide: Text.ElideRight
                        }

                        Text {
                            text: "Output"

                            color: "#8f96a3"
                            font.pixelSize: 12
                        }
                    }
                }
            }

            Text {
                text: "Volume"

                color: "#8f96a3"
                font.pixelSize: 13
            }

            Slider {
                width: parent.width

                from: 0
                to: 1

                value: Pipewire.defaultAudioSink &&
                       Pipewire.defaultAudioSink.audio
                       ? Pipewire.defaultAudioSink.audio.volume
                       : 0

                onMoved: {
                    if (Pipewire.defaultAudioSink &&
                        Pipewire.defaultAudioSink.audio) {
                        Pipewire.defaultAudioSink.audio.volume = value
                    }
                }
            }
        }
    }
}