import Quickshell
import QtQuick
import "./components"
import "./config"
import "./popups"

ShellRoot {
    ShellState {
        id: shellState
    }

    // =========================
    // TOP BAR
    // =========================

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

            Bar {
                shellState: shellState
            }
        }
    }

    // =========================
    // WIFI POPUP
    // =========================

    Variants {
        model: Quickshell.screens

        WifiPopup {
            required property var modelData

            targetScreen: modelData
            shellState: shellState

            visible: shellState.wifiOpen
        }
    }

    // =========================
    // AUDIO POPUP
    // =========================

    Variants {
        model: Quickshell.screens

        AudioPopup {
            required property var modelData

            targetScreen: modelData
            shellState: shellState

            visible: shellState.audioOpen
        }
    }
}