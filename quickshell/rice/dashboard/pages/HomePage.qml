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

                text: "SAIREX"

                color: Theme.accent

                font.pixelSize: 30
                font.bold: true
            }


            Text {
                anchors.horizontalCenter: parent.horizontalCenter

                text: "Welcome back"

                color: Theme.text

                font.pixelSize: 18
            }


            Text {
                anchors.horizontalCenter: parent.horizontalCenter

                text: "Home"

                color: Theme.textSecondary

                font.pixelSize: 13
            }
        }
    }
}