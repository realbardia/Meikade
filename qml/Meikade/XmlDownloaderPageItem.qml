/*
    Copyright (C) 2017 Aseman Team
    http://aseman.co

    Meikade is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    Meikade is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

import QtQuick 2.7
import QtQuick.Controls 2.1
import AsemanTools 1.0
import Meikade 1.0
import AsemanTools.Awesome 1.0
import QtQuick.Layouts 1.3
import "globals"

Item {
    clip: true

    LayoutMirroring.enabled: false
    LayoutMirroring.childrenInherit: true

    property alias type: proxyModel.type
    property alias count: listv.count

    XmlDownloaderProxyModel{
        id: proxyModel
        model: xml_model
    }

    AsemanListView {
        id: listv
        anchors.fill: parent
        topMargin: spacing
        model: proxyModel
        spacing: 8*Devices.density

        delegate: Item {
            x: listv.spacing
            width: listv.width - 2*x
            height: 54*Devices.density

            MaterialFrame {
                anchors.fill: parent
                color: MeikadeGlobals.backgroundAlternativeColor
            }

            PoetImageProvider {
                id: image_provider
                poet: model.poetId
            }

            RowLayout {
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.margins: 16*Devices.density
                anchors.verticalCenter: parent.verticalCenter
                spacing: 10*Devices.density
                layoutDirection: View.layoutDirection

                RoundedImage {
                    anchors.verticalCenter: parent.verticalCenter
                    Layout.preferredHeight: 38*Devices.density
                    Layout.preferredWidth: Layout.preferredHeight

                    radius: 5*Devices.density
                    fillMode: Image.PreserveAspectFit
                    source: "icons/menu-back.jpg"
                    smooth: true
                }

                Text {
                    anchors.verticalCenter: parent.verticalCenter
                    Layout.fillWidth: true

                    text: model.poetName
                    horizontalAlignment: View.defaultLayout? Text.AlignLeft : Text.AlignRight
                    font.pixelSize: 10*globalFontDensity*Devices.fontDensity
                    font.family: AsemanApp.globalFont.family
                    color: MeikadeGlobals.foregroundColor
                }

                Text {
                    anchors.verticalCenter: parent.verticalCenter
                    font.pixelSize: 9*globalFontDensity*Devices.fontDensity
                    font.family: AsemanApp.globalFont.family
                    color: Meikade.nightTheme? Qt.darker(MeikadeGlobals.foregroundColor) : Qt.lighter(MeikadeGlobals.foregroundColor)
                    text: {
                        if(model.installing)
                            return qsTr("Installing")
                        else
                        if(model.removingState)
                            return qsTr("Removing")
                        else
                        if(model.downloadingState)
                            return qsTr("Downloading")
                        else
                        if(model.updateAvailable)
                            return qsTr("Update")
                        else
                        if(model.installed)
                            return qsTr("Installed")
                        else
                        if(model.downloadError)
                            return qsTr("Error")
                        else
                            return qsTr("Free")
                    }
                }

                Item {
                    Layout.preferredHeight: parent.height
                    Layout.preferredWidth: Layout.preferredHeight

                    Text {
                        id: img
                        anchors.centerIn: parent
                        font.pixelSize: 15*globalFontDensity*Devices.fontDensity
                        font.family: Awesome.family
                        color: {
                            if(model.updateAvailable)
                                return "#0d80ec"
                            else
                            if(model.installed)
                                return "#3c994b"
                            else
                                return MeikadeGlobals.backgroundColor
                        }
                        text: {
                            if(model.updateAvailable)
                                return Awesome.fa_download
                            else
                            if(model.installed)
                                return Awesome.fa_check_square_o
                            else
                                return Awesome.fa_plus
                        }
                        visible: !indicator.running
                    }

                    Indicator {
                        id: indicator
                        anchors.centerIn: parent
                        width: 18*Devices.density
                        height: width
                        light: false
                        modern: true
                        running: model.installing || model.downloadingState || model.downloadedStatus || model.removingState
                    }
                }
            }

            ProgressBar {
                width: parent.width
                height: 3*Devices.density
                anchors.bottom: parent.bottom
                visible: indicator.running
                percent: 100*model.downloadedBytes/model.fileSize
                transform: Scale { origin.x: width/2; origin.y: height/2; xScale: View.defaultLayout?1:-1}
                color: "#00000000"
            }

            Rectangle {
                width: parent.width
                height: 1*Devices.density
                color: MeikadeGlobals.backgroundColor
                anchors.bottom: parent.bottom
            }

            ItemDelegate {
                id: marea
                anchors.fill: parent
                onClicked: {
                    if(model.installed) {
                        if(!indicator.running) {
                            removePopup.poetName = model.poetName
                            removePopup.updateCallback = model.updateAvailable? function(){ model.downloadingState = true } : null
                            removePopup.deleteCallback = function(){ model.removingState = true }
                            removePopup.open()
                        }

                        return
                    }

                    model.downloadingState = true
                    AsemanServices.meikade.pushAction( ("Poet Download: %1").arg(model.poetId), null )
                }
            }
        }
    }

    ScrollBar {
        scrollArea: listv; height: listv.height; anchors.right: listv.right;
        anchors.top: listv.top; color: "#111111"
        LayoutMirroring.enabled: View.layoutDirection == Qt.RightToLeft
    }
}
