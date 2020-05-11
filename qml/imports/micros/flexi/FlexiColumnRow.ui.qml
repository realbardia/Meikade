import QtQuick 2.12
import QtQuick.Controls 2.0
import AsemanQml.Base 2.0
import AsemanQml.Models 2.0
import globals 1.0
import "delegates"

FlexiAbstractRow {
    id: hflexible
    width: Constants.width
    height: row.height

    property alias model: model

    PointMapListener {
        id: mapListener
        source: row
        dest: listView
    }

    Column {
        id: row
        anchors.left: parent.left
        anchors.right: parent.right
        spacing: 10 * Devices.density

        Repeater {
            id: rptr
            model: AsemanListModel {
                id: model
            }
            delegate: Loader {
                width: row.width
                height: 100 * Devices.density * model.heightRatio
                active: 0 < globalY + height && globalY < listView.height

                property real globalY: mapListener.result.y + y

                sourceComponent: Delegate {
                    id: itemDel
                    anchors.fill: parent
                    title: model.title
                    subtitle: model.subtitle
                    color: model.color.length? model.color : Colors.lightBackground
                    image: model.image
                    type: model.type
                    link: model.link

                    Connections {
                        target: itemDel
                        onClicked: hflexible.clicked(itemDel.link, rptr.model.get(index))
                    }
                }
            }
        }
    }
}
