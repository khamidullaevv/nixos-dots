import Quickshell
import QtQuick

import "./config"
import "./components"
import "./popups"
import "./dashboard"

ShellRoot {
    id: root

    property var appState: ShellState {
        id: state
    }


    // =========================================================
    // TOP BAR
    // =========================================================

    Variants {
        model: Quickshell.screens

        PanelWindow {
            required property var modelData

            screen: modelData
            color: "transparent"

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

            implicitHeight: 48

            Bar {
                appState: root.appState
            }
        }
    }


    // =========================================================
    // WIFI POPUP
    // =========================================================

    Variants {
        model: Quickshell.screens

        WifiPopup {
            required property var modelData

            targetScreen: modelData
            appState: root.appState

            visible: root.appState.wifiOpen
        }
    }


    // =========================================================
    // AUDIO POPUP
    // =========================================================

    Variants {
        model: Quickshell.screens

        AudioPopup {
            required property var modelData

            targetScreen: modelData
            appState: root.appState

            visible: root.appState.audioOpen
        }
    }


    // =========================================================
    // DASHBOARD
    // =========================================================

    Variants {
        model: Quickshell.screens

        Dashboard {
            required property var modelData

            targetScreen: modelData
            appState: root.appState

            visible: root.appState.dashboardOpen
        }
    }
}