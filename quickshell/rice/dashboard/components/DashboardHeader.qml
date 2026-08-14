import QtQuick
import QtQuick.Layouts

import "../../config"

Item {
    id: root

    property var appState

    implicitHeight: 82

    property string currentTime:
        Qt.formatDateTime(new Date(), "HH:mm")

    property string currentDate:
        Qt.formatDateTime(new Date(), "dddd, d MMMM")

    readonly property string greeting: {
        const hour = new Date().getHours()

        if (hour < 5)
            return "Доброй ночи"

        if (hour < 12)
            return "Доброе утро"

        if (hour < 18)
            return "Добрый день"

        return "Добрый вечер"
    }

    Timer {
        interval: 1000
        running: true
        repeat: true

        onTriggered: {
            root.currentTime =
                Qt.formatDateTime(new Date(), "HH:mm")

            root.currentDate =
                Qt.formatDateTime(new Date(), "dddd, d MMMM")
        }
    }

    RowLayout {
        anchors.fill: parent

        anchors.leftMargin: 20
        anchors.rightMargin: 20

        spacing: 14

        // ─────────────────────────────────────────────
        // Avatar
        // ─────────────────────────────────────────────

        Rectangle {
            Layout.preferredWidth: 48
            Layout.preferredHeight: 48

            radius: 15

            color: Theme.surfaceVariant

            border.width: 1
            border.color: Theme.accent

            Text {
                anchors.centerIn: parent

                text: "S"

                color: Theme.accent

                font.pixelSize: 17
                font.bold: true
            }
        }

        // ─────────────────────────────────────────────
        // Greeting
        // ─────────────────────────────────────────────

        ColumnLayout {
            Layout.fillWidth: true

            spacing: 1

            Text {
                text: root.greeting

                color: Theme.text

                font.pixelSize: 16
                font.bold: true
            }

            Text {
                text: root.currentDate

                color: Theme.textSecondary

                font.pixelSize: 11
            }
        }

        // ─────────────────────────────────────────────
        // Time
        // ─────────────────────────────────────────────

        Text {
            text: root.currentTime

            color: Theme.text

            font.pixelSize: 18
            font.bold: true
        }
    }

    Rectangle {
        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom

            leftMargin: 20
            rightMargin: 20
        }

        height: 1

        color: Theme.border
    }
}