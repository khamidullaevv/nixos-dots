import QtQuick

Text {
    property string currentTime: ""

    text: currentTime

    color: "#ffffff"
    font.pixelSize: 13

    Timer {
        interval: 1000
        running: true
        repeat: true

        onTriggered: {
            currentTime = Qt.formatTime(new Date(), "HH:mm")
        }
    }

    Component.onCompleted: {
        currentTime = Qt.formatTime(new Date(), "HH:mm")
    }
}
