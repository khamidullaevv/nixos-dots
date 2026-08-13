import QtQuick
import "../config"

Rectangle {
    id: root

    property bool opened: true

    radius: Theme.radiusLarge
    color: Theme.surface
    border.width: 1
    border.color: Theme.border

    scale: opened ? 1.0 : 0.94
    opacity: opened ? 1.0 : 0.0

    Behavior on scale {
        NumberAnimation {
            duration: 170
            easing.type: Easing.OutCubic
        }
    }

    Behavior on opacity {
        NumberAnimation {
            duration: 130
        }
    }
}
