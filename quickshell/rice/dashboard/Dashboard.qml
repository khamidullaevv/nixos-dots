import QtQuick
import Quickshell
import "../config"

PanelWindow {
    id: root

    required property var targetScreen
    property var appState

    screen: targetScreen

    color: "transparent"

    anchors {
        top: true
        bottom: true
        left: true
        right: true
    }

    visible: appState ? appState.dashboardOpen : false

    property int currentPage: 0

    Rectangle {
        id: card

        width: 760
        height: 560

        anchors.centerIn: parent

        radius: 28

        color: Theme.background

        border.width: 1
        border.color: Theme.border

        scale: root.visible ? 1 : 0.94
        opacity: root.visible ? 1 : 0

        Behavior on scale {
            NumberAnimation {
                duration: 220
                easing.type: Easing.OutCubic
            }
        }

        Behavior on opacity {
            NumberAnimation {
                duration: 180
                easing.type: Easing.OutCubic
            }
        }


        // Header

        DashboardHeader {
            id: header

            anchors {
                top: parent.top
                left: parent.left
                right: parent.right
            }

            appState: root.appState
        }


        // Pages

        Loader {
            id: pageLoader

            anchors {
                top: header.bottom
                left: parent.left
                right: parent.right
                bottom: navigation.top

                topMargin: 10
                leftMargin: 20
                rightMargin: 20
                bottomMargin: 10
            }

            sourceComponent: {
                if (root.currentPage === 0)
                    return homePage

                if (root.currentPage === 1)
                    return visualizerPage

                return systemPage
            }
        }


        // Navigation

        DashboardNavigation {
            id: navigation

            anchors {
                bottom: parent.bottom
                horizontalCenter: parent.horizontalCenter
            }

            currentPage: root.currentPage

            onPageChanged: function(page) {
                root.currentPage = page
            }
        }
    }


    // =========================================================
    // PAGE COMPONENTS
    // =========================================================

    Component {
        id: homePage

        HomePage {}
    }


    Component {
        id: visualizerPage

        VisualizerPage {}
    }


    Component {
        id: systemPage

        SystemPage {}
    }
}