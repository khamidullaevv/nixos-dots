import Quickshell
import QtQuick
import "./components"
import "./popups"

ShellRoot {
    property bool wifiOpen: false
    property bool audioOpen: false

    Variants {
        model: Quickshell.screens

        PanelWindow {
            required property var modelData

            screen: modelData

            anchors {
                top: true
                left: true
                right: true
            }

            margins {
                top: 8
                left: 8
                right: 8
            }

            implicitHeight: 44

            color: "transparent"

            Bar {}
        }
    }

    Variants {
        model: Quickshell.screens

        WifiPopup {
            required property var modelData

            targetScreen: modelData

            visible: wifiOpen
        }
    }

    Variants {
        model: Quickshell.screens

        AudioPopup {
            required property var modelData

            targetScreen: modelData

            visible: audioOpen
        }
    }
}