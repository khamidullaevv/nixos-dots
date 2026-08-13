import QtQuick

QtObject {
    property bool wifiOpen: false
    property bool audioOpen: false
    property bool bluetoothOpen: false

    property bool dashboardOpen: false
    property bool launcherOpen: false
    property bool controlCenterOpen: false
    property bool notificationsOpen: false

    function closeAllPopups() {
        wifiOpen = false
        audioOpen = false
        bluetoothOpen = false

        dashboardOpen = false
        launcherOpen = false
        controlCenterOpen = false
        notificationsOpen = false
    }

    function toggleWifi() {
        var next = !wifiOpen

        closeAllPopups()

        wifiOpen = next
    }

    function toggleAudio() {
        var next = !audioOpen

        closeAllPopups()

        audioOpen = next
    }

    function toggleBluetooth() {
        var next = !bluetoothOpen

        closeAllPopups()

        bluetoothOpen = next
    }

    function toggleDashboard() {
        var next = !dashboardOpen

        closeAllPopups()

        dashboardOpen = next
    }

    function toggleLauncher() {
        var next = !launcherOpen

        closeAllPopups()

        launcherOpen = next
    }

    function toggleControlCenter() {
        var next = !controlCenterOpen

        closeAllPopups()

        controlCenterOpen = next
    }

    function toggleNotifications() {
        var next = !notificationsOpen

        closeAllPopups()

        notificationsOpen = next
    }
}