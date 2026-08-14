import QtQuick
import "../../config"
import "../../services"

Item {
    id: root

    anchors.fill: parent

    function formatTime(seconds) {
        if (!seconds || seconds < 0)
            return "0:00"

        var total = Math.floor(seconds)
        var minutes = Math.floor(total / 60)
        var secs = total % 60

        return minutes + ":" + (secs < 10 ? "0" : "") + secs
    }

    Rectangle {
        anchors.fill: parent

        radius: 20
        color: Theme.background

        border.width: 1
        border.color: Theme.border
    }

    Column {
        anchors {
            fill: parent
            leftMargin: 22
            rightMargin: 22
            topMargin: 20
            bottomMargin: 18
        }

        spacing: 14

        // ─────────────────────────────────────
        // HEADER
        // ─────────────────────────────────────

        Item {
            width: parent.width
            height: 26

            Text {
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter

                text: "Now Playing"
                color: Theme.text

                font.pixelSize: 17
                font.bold: true
            }

            Rectangle {
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter

                width: 8
                height: 8
                radius: 4

                color: CavaService.running
                    ? Theme.success
                    : Theme.warning
            }
        }

        // ─────────────────────────────────────
        // PLAYER
        // ─────────────────────────────────────

        Item {
            width: parent.width
            height: 145

            // Album art
            Rectangle {
                id: cover

                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter

                width: 145
                height: 145

                radius: 18

                color: Theme.surfaceVariant

                clip: true

                Image {
                    anchors.fill: parent

                    source: MprisService.artUrl

                    fillMode: Image.PreserveAspectCrop

                    visible: MprisService.artUrl !== ""

                    asynchronous: true
                    cache: true
                }

                // Fallback icon
                Text {
                    anchors.centerIn: parent

                    visible: MprisService.artUrl === ""

                    text: "♫"

                    color: Theme.textSecondary
                    font.pixelSize: 42
                }
            }

            // Track information
            Column {
                anchors {
                    left: cover.right
                    right: parent.right
                    top: parent.top
                    bottom: parent.bottom

                    leftMargin: 18
                }

                spacing: 5

                Text {
                    width: parent.width

                    text: MprisService.title

                    color: Theme.text

                    font.pixelSize: 19
                    font.bold: true

                    elide: Text.ElideRight
                }

                Text {
                    width: parent.width

                    text: MprisService.artist !== ""
                        ? MprisService.artist
                        : "Unknown artist"

                    color: Theme.textSecondary

                    font.pixelSize: 13

                    elide: Text.ElideRight
                }

                Text {
                    width: parent.width

                    text: MprisService.album !== ""
                        ? MprisService.album
                        : MprisService.playerName

                    color: Theme.textSecondary

                    font.pixelSize: 11

                    elide: Text.ElideRight
                }

                Item {
                    width: parent.width
                    height: 10
                }

                // Progress
                Rectangle {
                    width: parent.width
                    height: 5

                    radius: 3

                    color: Theme.surfaceVariant

                    Rectangle {
                        width: parent.width * MprisService.progress
                        height: parent.height

                        radius: 3

                        color: Theme.accent

                        Behavior on width {
                            NumberAnimation {
                                duration: 150
                            }
                        }
                    }
                }

                Item {
                    width: parent.width
                    height: 4
                }

                Row {
                    width: parent.width

                    Text {
                        text: formatTime(MprisService.position)

                        color: Theme.textSecondary
                        font.pixelSize: 10
                    }

                    Item {
                        width: parent.width - 80
                        height: 1
                    }

                    Text {
                        text: formatTime(MprisService.length)

                        color: Theme.textSecondary
                        font.pixelSize: 10
                    }
                }

                Item {
                    width: parent.width
                    height: 4
                }

                // Controls
                Row {
                    spacing: 7

                    Rectangle {
                        width: 32
                        height: 30

                        radius: 10

                        color: Theme.surfaceVariant

                        Text {
                            anchors.centerIn: parent

                            text: "⏮"

                            color: Theme.text

                            font.pixelSize: 15
                        }

                        MouseArea {
                            anchors.fill: parent

                            cursorShape: Qt.PointingHandCursor

                            onClicked: MprisService.previous()
                        }
                    }

                    Rectangle {
                        width: 38
                        height: 30

                        radius: 10

                        color: Theme.accent

                        Text {
                            anchors.centerIn: parent

                            text: MprisService.isPlaying
                                ? "Ⅱ"
                                : "▶"

                            color: Theme.background

                            font.pixelSize: 14
                            font.bold: true
                        }

                        MouseArea {
                            anchors.fill: parent

                            cursorShape: Qt.PointingHandCursor

                            onClicked:
                                MprisService.togglePlaying()
                        }
                    }

                    Rectangle {
                        width: 32
                        height: 30

                        radius: 10

                        color: Theme.surfaceVariant

                        Text {
                            anchors.centerIn: parent

                            text: "⏭"

                            color: Theme.text

                            font.pixelSize: 15
                        }

                        MouseArea {
                            anchors.fill: parent

                            cursorShape: Qt.PointingHandCursor

                            onClicked: MprisService.next()
                        }
                    }
                }
            }
        }

        // ─────────────────────────────────────
        // LYRICS
        // ─────────────────────────────────────

        Rectangle {
            width: parent.width
            height: 105

            radius: 16

            color: Theme.surface

            border.width: 1
            border.color: Theme.border

            Column {
                anchors.centerIn: parent

                width: parent.width - 32

                spacing: 5

                Text {
                    width: parent.width

                    text: LyricsService.previousLine !== ""
                        ? LyricsService.previousLine
                        : "♪"

                    horizontalAlignment: Text.AlignHCenter

                    color: Theme.textSecondary

                    font.pixelSize: 11

                    elide: Text.ElideRight
                }

                Text {
                    width: parent.width

                    text: LyricsService.currentLine !== ""
                        ? LyricsService.currentLine
                        : (
                            LyricsService.loading
                                ? "Loading lyrics..."
                                : "Lyrics unavailable"
                        )

                    horizontalAlignment: Text.AlignHCenter

                    color: Theme.text

                    font.pixelSize: 15
                    font.bold: true

                    elide: Text.ElideRight
                }

                Text {
                    width: parent.width

                    text: LyricsService.nextLine !== ""
                        ? LyricsService.nextLine
                        : "♪"

                    horizontalAlignment: Text.AlignHCenter

                    color: Theme.textSecondary

                    font.pixelSize: 11

                    elide: Text.ElideRight
                }
            }
        }

        // ─────────────────────────────────────
        // CAVA
        // ─────────────────────────────────────

        Item {
            width: parent.width
            height: parent.height - 290

            clip: true

            Row {
                anchors {
                    left: parent.left
                    right: parent.right
                    bottom: parent.bottom
                }

                height: parent.height

                spacing: 4

                Repeater {
                    model: CavaService.barCount

                    Item {
                        required property int index

                        width: (
                            parent.width -
                            (CavaService.barCount - 1) * 4
                        ) / CavaService.barCount

                        height: parent.height

                        Rectangle {
                            anchors {
                                left: parent.left
                                right: parent.right
                                bottom: parent.bottom
                            }

                            width: parent.width

                            height: Math.max(
                                3,
                                parent.height *
                                CavaService.values[index] / 100
                            )

                            radius: width / 2

                            color:
                                index >= 12 &&
                                index <= 19
                                    ? Theme.accent
                                    : Theme.textSecondary

                            opacity:
                                0.25 +
                                CavaService.values[index] / 100 * 0.75

                            Behavior on height {
                                NumberAnimation {
                                    duration: 55
                                    easing.type: Easing.OutCubic
                                }
                            }

                            Behavior on opacity {
                                NumberAnimation {
                                    duration: 70
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}