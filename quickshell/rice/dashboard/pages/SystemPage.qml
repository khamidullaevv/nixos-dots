import QtQuick
import "../../config"

Item {
    Rectangle {
        anchors.fill: parent

        radius: 22

        color: Theme.surface


        Column {
            anchors.centerIn: parent

            spacing: 12


            Text {
                anchors.horizontalCenter: parent.horizontalCenter

                text: "SYSTEM"

                color: Theme.accent

                font.pixelSize: 20
                font.bold: true
            }


            Text {
                anchors.horizontalCenter: parent.horizontalCenter

                text: "RAM • SSD • Network"

                color: Theme.textSecondary

                font.pixelSize: 13
            }
        }
    }
}