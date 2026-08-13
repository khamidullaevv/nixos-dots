import Quickshell
import QtQuick

import "./config"
import "./components"

ShellRoot {
    id: root

    property var appState: ShellState {
        id: state
    }

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

            /*
             * Только верхние 48px занимают место
             * в layout.
             *
             * Dashboard / Wi-Fi / Audio
             * находятся поверх приложений.
             */
            exclusiveZone: 48

            aboveWindows: true

            /*
             * 48px bar + 460px dashboard/popup space
             */
            implicitHeight: 508

            Bar {
                id: bar

                anchors {
                    left: parent.left
                    right: parent.right
                    top: parent.top
                }

                appState: root.appState
            }
        }
    }
}