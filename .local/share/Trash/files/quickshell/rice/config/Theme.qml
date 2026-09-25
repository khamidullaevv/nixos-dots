pragma Singleton

import QtQuick 2.15

QtObject {
    property color background: "#0d0f12"
    property color surface: "#15181d"
    property color surfaceVariant: "#20242b"

    property color border: "#2d323b"

    property color text: "#f4f6f8"
    property color textSecondary: "#969eaa"

    property color accent: "#8ab4ff"
    property color accentVariant: "#304b76"

    property color success: "#8bd5a8"
    property color warning: "#e8c77a"
    property color error: "#ef8b8b"

    property int radiusSmall: 9
    property int radiusMedium: 14
    property int radiusLarge: 20

    property int spacingSmall: 6
    property int spacingMedium: 12
    property int spacingLarge: 20
}