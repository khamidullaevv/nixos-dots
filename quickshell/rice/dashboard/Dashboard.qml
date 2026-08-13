import QtQuick

import "../config"
import "./components"
import "./pages"

Item {
    id: root

    property var appState

    property int currentPage: 0

    anchors.fill: parent


    // =========================================================
    // DASHBOARD CONTENT
    // =========================================================

Rectangle {
    id: card

    anchors.fill: parent

    color: Theme.surface

    topLeftRadius: 0
    topRightRadius: 0
    bottomLeftRadius: 24
    bottomRightRadius: 24

    border.width: 0

    clip: true


        // =====================================================
        // HEADER
        // =====================================================

        DashboardHeader {
            id: header

            anchors {
                top: parent.top
                left: parent.left
                right: parent.right
            }

            appState: root.appState
        }


        // =====================================================
        // PAGE
        // =====================================================

        Loader {
            id: pageLoader

            anchors {
                top: header.bottom

                left: parent.left
                right: parent.right

                bottom: navigation.top

                topMargin: 10
                leftMargin: 16
                rightMargin: 16
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


        // =====================================================
        // NAVIGATION
        // =====================================================

        DashboardNavigation {
            id: navigation

            anchors {
                bottom: parent.bottom

                horizontalCenter: parent.horizontalCenter

                bottomMargin: 18
            }

            currentPage: root.currentPage

            onPageChanged: function(page) {
                root.currentPage = page
            }
        }
    }


    // =========================================================
    // PAGES
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