import QtQuick

import "../config"
import "./components"
import "./pages"

Item {
    id: root

    property var appState
    property int currentPage: 0

    anchors.fill: parent

    Rectangle {
        id: card

        anchors.fill: parent

        color: Theme.surface
        radius: Theme.radiusLarge

        border.width: 1
        border.color: Theme.border

        clip: true

        // ─────────────────────────────────────────────
        // Header
        // ─────────────────────────────────────────────

        DashboardHeader {
            id: header

            anchors {
                top: parent.top
                left: parent.left
                right: parent.right
            }

            appState: root.appState
        }

        // ─────────────────────────────────────────────
        // Page
        // ─────────────────────────────────────────────

        Loader {
            id: pageLoader

            anchors {
                top: header.bottom
                left: parent.left
                right: parent.right
                bottom: navigation.top

                topMargin: 8
                leftMargin: 16
                rightMargin: 16
                bottomMargin: 8
            }

            sourceComponent: {
                switch (root.currentPage) {
                case 0:
                    return homePage
                case 1:
                    return visualizerPage
                case 2:
                    return systemPage
                default:
                    return homePage
                }
            }
        }

        // ─────────────────────────────────────────────
        // Navigation
        // ─────────────────────────────────────────────

        DashboardNavigation {
            id: navigation

            anchors {
                bottom: parent.bottom
                horizontalCenter: parent.horizontalCenter
                bottomMargin: 12
            }

            currentPage: root.currentPage

            onPageChanged: function(page) {
                root.currentPage = page
            }
        }
    }

    // ─────────────────────────────────────────────────
    // Pages
    // ─────────────────────────────────────────────────

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