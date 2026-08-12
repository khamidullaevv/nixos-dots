import Quickshell
import QtQuick
import "./components"

ShellRoot {
    PanelWindow {
        anchors {
            top: true
            left: true
            right: true
        }

        implicitHeight: 42

        Bar {}
    }
}
