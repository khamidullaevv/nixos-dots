import QtQuick

QtObject {
    property bool wifiOpen: false
    property bool audioOpen: false

    function toggleWifi() {
        wifiOpen = !wifiOpen
        audioOpen = false
    }

    function toggleAudio() {
        audioOpen = !audioOpen
        wifiOpen = false
    }

    function closePopups() {
        wifiOpen = false
        audioOpen = false
    }
}