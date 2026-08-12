import Quickshell
import QtQuick
import "./components"

ShellRoot {
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
}