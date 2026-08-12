import QtQuick
import Quickshell
import "."

Rectangle {
    anchors.fill: parent

    color: "#111318"

    // Левая часть
    Row {
        anchors.left: parent.left
        anchors.leftMargin: 12
        anchors.verticalCenter: parent.verticalCenter

        spacing: 10

        // Название rice
        Text {
            text: "SAIREX"

            color: "#ffffff"
            font.pixelSize: 14
            font.bold: true

            anchors.verticalCenter: parent.verticalCenter
        }

        // Разделитель
        Rectangle {
            width: 1
            height: 20

            color: "#33363d"

            anchors.verticalCenter: parent.verticalCenter
        }

        // Workspaces
        Workspaces {
            anchors.verticalCenter: parent.verticalCenter
        }
    }

    // Центральная часть
    Text {
        anchors.centerIn: parent

        text: "Desktop"

        color: "#ffffff"
        font.pixelSize: 14
    }

    // Правая часть
    Row {
        anchors.right: parent.right
        anchors.rightMargin: 12
        anchors.verticalCenter: parent.verticalCenter

        spacing: 12

        Text {
            text: "󰖩  Online"

            color: "#ffffff"
            font.pixelSize: 13

            anchors.verticalCenter: parent.verticalCenter
        }

        Text {
            text: "󰕾  40%"

            color: "#ffffff"
            font.pixelSize: 13

            anchors.verticalCenter: parent.verticalCenter
        }

        Rectangle {
            width: 1
            height: 20

            color: "#33363d"

            anchors.verticalCenter: parent.verticalCenter
        }

        Text {
            text: "18:49"

            color: "#ffffff"
            font.pixelSize: 13

            anchors.verticalCenter: parent.verticalCenter
        }
    }
}
