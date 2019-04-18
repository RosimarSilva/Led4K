import QtQuick 2.0

Item {
    Image {
        id: configuration
        x: 35
        y: 20
        fillMode: Image.PreserveAspectFit
        source: "Telas/Config.bmp"

        Image {
            id: setEsc
            x: 331
            y: 198
            fillMode: Image.PreserveAspectFit
            source: "IconesConfig/setaEsc.bmp"
            MouseArea{
                anchors.fill: parent
                onPressed: {parent.scale  = 0.95;}
                onReleased: {
                    parent.scale = 1.0;
                }
            }
        }

        Image {
            id: setUp
            x: 420
            y: 106
            fillMode: Image.PreserveAspectFit
            source: "IconesConfig/SetaUp.bmp"
            MouseArea{
                anchors.fill: parent
                onPressed: {parent.scale  = 0.95;}
                onReleased: {
                    parent.scale = 1.0;
                }
            }
        }

        Image {
            id: setDir
            x: 513
            y: 198
            fillMode: Image.PreserveAspectFit
            source: "IconesConfig/SetaDir.bmp"
            MouseArea{
                anchors.fill: parent
                onPressed: {parent.scale  = 0.95;}
                onReleased: {
                    parent.scale = 1.0;
                }
            }
        }

        Image {
            id: setOk
            x: 423
            y: 198
            fillMode: Image.PreserveAspectFit
            source: "IconesConfig/SetaOk.bmp"
            MouseArea{
                anchors.fill: parent
                onPressed: {parent.scale  = 0.95;}
                onReleased: {
                    parent.scale = 1.0;
                }
            }
        }

        Image {
            id: setDown
            x: 423
            y: 291
            fillMode: Image.PreserveAspectFit
            source: "IconesConfig/SetaDown.bmp"
            MouseArea{
                anchors.rightMargin: 0
                anchors.bottomMargin: 6
                anchors.leftMargin: 0
                anchors.topMargin: -6
                anchors.fill: parent
                onPressed: {parent.scale  = 0.95;}
                onReleased: {
                    parent.scale = 1.0;
                }
            }
        }
    }

    Image {
        id: back
        x: 35
        y: 20
        fillMode: Image.PreserveAspectFit
        source: "IndicadoresCentrais/Back.png"
        MouseArea{
            anchors.fill: parent
            onPressed: {parent.scale  = 0.95;}
            onReleased: {
                parent.scale = 1.0;
                root.state = "Menu"
            }
        }
    }

}

/*##^## Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
 ##^##*/
