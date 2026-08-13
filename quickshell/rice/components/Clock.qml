import QtQuick

Text {
    id: root

    property string timeText: Qt.formatDateTime(new Date(), "HH:mm")

    text: timeText
    color: "#f4f6f8"
    font.pixelSize: 13
    font.bold: true

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: root.timeText = Qt.formatDateTime(new Date(), "HH:mm")
    }
}
