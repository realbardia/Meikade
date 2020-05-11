import QtQuick 2.12
import AsemanQml.Base 2.0
import AsemanQml.MaterialIcons 2.0
import AsemanQml.Controls 2.0
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.0
import globals 1.0
import micros 1.0
import models 1.0

Item {
    id: booksList
    width: Constants.width
    height: Constants.height

    property alias listView: listView
    property alias headerItem: headerItem
    property alias headerBtn: headerBtn
    property alias navigationRepeater: navigationRepeater
    property alias menuBtn: menuBtn
    property alias avatar: avatar
    property alias avatarBtn: avatarBtn

    signal clicked(string link)
    signal navigationClicked(string link)

    Rectangle {
        anchors.fill: parent
        color: Colors.deepBackground
    }

    BusyIndicator {
        id: busyIndicator
        anchors.centerIn: parent
        running: listView.model && listView.model.refreshing !== undefined && listView.model.refreshing && listView.count == 0
    }

    FlexiList {
        id: listView
        anchors.top: headerItem.bottom
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.left: parent.left

        topMargin: 4 * Devices.density
        bottomMargin: 4 * Devices.density
    }

    Header {
        id: headerItem
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.left: parent.left
        color: Colors.header
        shadow: Devices.isAndroid

        RowLayout {
            anchors.fill: parent
            anchors.topMargin: Devices.statusBarHeight
            spacing: 4 * Devices.density

            HeaderMenuButton {
                id: headerBtn
                ratio: 1
            }

            Rectangle {
                Layout.preferredWidth: 32 * Devices.density
                Layout.preferredHeight: 32 * Devices.density
                radius: Constants.radius * 0.7
                Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
                color: Material.background

                Label {
                    anchors.centerIn: parent
                    color: Colors.primary
                    font.pixelSize: 18 * Devices.fontDensity
                    font.family: MaterialIcons.family
                    text: MaterialIcons.mdi_account
                }

                Image {
                    id: avatar
                    anchors.fill: parent
                    sourceSize.width: width * 1.2
                    sourceSize.height: height * 1.2
                    fillMode: Image.PreserveAspectCrop
                }

                ItemDelegate {
                    id: avatarBtn
                    anchors.fill: parent
                }
            }

            Repeater {
                id: navigationRepeater
                model: ListModel {
                    ListElement {
                        title: "Hello"
                    }
                    ListElement {
                        title: "World"
                    }
                }

                RowLayout {
                    spacing: 0

                    Label {
                        font.family: MaterialIcons.family
                        text: MaterialIcons.mdi_chevron_right
                        font.pixelSize: 14 * Devices.fontDensity
                        color: Colors.headerText
                    }

                    Label {
                        text: model.title
                        font.pixelSize: 9 * Devices.fontDensity
                        color: Colors.headerText
                        maximumLineCount: 1
                        wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                        elide: Text.ElideRight

                        ItemDelegate {
                            id: navDel
                            anchors.fill: parent
                            anchors.margins: -14 * Devices.density
                            z: -1

                            Connections {
                                target: navDel
                                onClicked: booksList.navigationClicked(model.link)
                            }
                        }
                    }
                }
            }

            Label {
                Layout.fillWidth: true
                font.pixelSize: 10 * Devices.fontDensity
                color: Colors.headerText
            }

            ItemDelegate {
                id: menuBtn
                Layout.preferredHeight: Devices.standardTitleBarHeight
                Layout.preferredWidth: Devices.standardTitleBarHeight

                Label {
                    anchors.centerIn: parent
                    font.family: MaterialIcons.family
                    font.pixelSize: 14 * Devices.fontDensity
                    text: MaterialIcons.mdi_dots_vertical
                    color: Colors.headerText
                }
            }
        }
    }

    HScrollBar {
        anchors.right: parent.right
        anchors.bottom: listView.bottom
        anchors.top: listView.top
        anchors.bottomMargin: Devices.standardTitleBarHeight
        color: Colors.primary
        scrollArea: listView
    }
}
