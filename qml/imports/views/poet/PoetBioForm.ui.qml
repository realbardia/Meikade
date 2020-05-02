import QtQuick 2.12
import AsemanQml.Base 2.0
import AsemanQml.Controls 2.0
import AsemanQml.MaterialIcons 2.0
import QtQuick.Controls.Material 2.0
import QtQuick.Controls.IOSStyle 2.0
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
import globals 1.0

Page {
    width: Constants.width
    height: Constants.height

    AsemanFlickable {
        id: flickable
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: headerItem.bottom
        anchors.bottom: parent.bottom
        contentHeight: flickColumn.height
        contentWidth: flickColumn.width
        flickableDirection: Flickable.VerticalFlick

        ColumnLayout {
            id: flickColumn
            width: flickable.width

            Label {
                id: bioText
                Layout.margins: 14
                Layout.fillHeight: true
                Layout.fillWidth: true
                font.pixelSize: 9 * Devices.fontDensity
                wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                text: "Wissen Sie, wie Sie Pensionsrisiken minimieren sowie Pensionsverpflichtungen und #Volatilität reduzieren? Melden Sie sich jetzt an zum Webinar am 12. Mai! "
            }
        }
    }

    HScrollBar {
        anchors.right: flickable.right
        anchors.bottom: flickable.bottom
        anchors.top: flickable.top
        color: Colors.primary
        scrollArea: flickable
    }

    Rectangle {
        id: headerItem
        color: Colors.deepBackground
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        height: Devices.standardTitleBarHeight + Devices.statusBarHeight

        RowLayout {
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.leftMargin: 14 * Devices.density
            anchors.rightMargin: 2 * Devices.density
            anchors.bottom: parent.bottom
            height: Devices.standardTitleBarHeight

            Label {
                id: bioTitle
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: 12 * Devices.fontDensity
                horizontalAlignment: Text.AlignLeft
                text: qsTr("Biography") + Translations.refresher
                Layout.fillWidth: true
            }

            RoundButton {
                id: closeBtn
                Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                text: qsTr("Close") + Translations.refresher
                highlighted: true
                radius: 6 * Devices.density
                font.pixelSize: 8 * Devices.fontDensity
                IOSStyle.accent: Qt.darker(Colors.deepBackground, 1.3)
                Material.accent: Qt.darker(Colors.deepBackground, 1.3)
                Material.theme: Material.Dark
                Material.elevation: 0
            }
        }
    }
}