import QtQuick 2.0

Item {
     id:serie
    property int serialnumber: 0
     property color colorText: "white"

    Image {
        id: serialNumber

        x: 35
        y: 20
        source: "Telas/SerialNumber.bmp"
        fillMode: Image.PreserveAspectFit
        Connections{  //começa a contar um tempo para voltar a tela principal caso não haja tecla pressionada
                target: serial
            onTela6:{
                      //timeBack.start();
                console.log("vai coringao")
             }
        }

        Connections{  //enquanto não há white balance feito fica piscando
                target: senha_
            onChangedSerial:{
                       serialnumber = senha_.serial;

             }
        }

        Text {
            x: 180
            y: 80
            horizontalAlignment:  Text.AlignVCenter
            font.pointSize: 30
            color: serie.colorText
            text:+senha_.serial
        }

        Image {
            id: one
            x: 146
            y: 142
            source: "IconesSenha/1.bmp"
            fillMode: Image.PreserveAspectFit
            MouseArea{
                anchors.fill: parent
                onPressed: { parent.scale = 0.95; }
                onReleased: {
                    parent.scale = 1.0;
                   senha_.setserialNumber(1,0);
               }
            }
        }

        Image {
            id: two
            x: 222
            y: 142
            source: "IconesSenha/2.bmp"
            fillMode: Image.PreserveAspectFit
            MouseArea{
                anchors.fill: parent
                onPressed: { parent.scale = 0.95; }
                onReleased: {
                    parent.scale = 1.0;

                  senha_.setserialNumber(2,0);
                }
            }
        }

        Image {
            id: tree
            x: 295
            y: 142
            source: "IconesSenha/3.bmp"
            fillMode: Image.PreserveAspectFit
            MouseArea{
                anchors.fill: parent
                onPressed: { parent.scale = 0.95; }
                onReleased: {
                    parent.scale = 1.0;
                   senha_.setserialNumber(3,0);

                }
            }
        }

        Image {
            id: four
            x: 146
            y: 208
            source: "IconesSenha/4.bmp"
            fillMode: Image.PreserveAspectFit
            MouseArea{
                anchors.fill: parent
                onPressed: { parent.scale = 0.95; }
                onReleased: {
                    parent.scale = 1.0;
                   senha_.setserialNumber(4,0);

                 }
            }
        }

        Image {
            id: five
            x: 222
            y: 208
            source: "IconesSenha/5.bmp"
            fillMode: Image.PreserveAspectFit
            MouseArea{
                anchors.fill: parent
                onPressed: { parent.scale = 0.95; }
                onReleased: {
                    parent.scale = 1.0;

                   senha_.setserialNumber(5,0);
                }
            }
        }

        Image {
            id: six
            x: 295
            y: 208
            source: "IconesSenha/6.bmp"
            fillMode: Image.PreserveAspectFit
            MouseArea{
                anchors.fill: parent
                onPressed: { parent.scale = 0.95; }
                onReleased: {
                    parent.scale = 1.0;
                   senha_.setserialNumber(6,0);
                }
            }
        }

        Image {
            id: seven
            x: 146
            y: 274
            source: "IconesSenha/7.bmp"
            fillMode: Image.PreserveAspectFit
            MouseArea{
                anchors.fill: parent
                onPressed: { parent.scale = 0.95; }
                onReleased: {
                    parent.scale = 1.0;

                   senha_.setserialNumber(7,0);
                }
            }
        }

        Image {
            id: eight
            x: 222
            y: 274
            source: "IconesSenha/8.bmp"
            fillMode: Image.PreserveAspectFit
            MouseArea{
                anchors.fill: parent
                onPressed: { parent.scale = 0.95; }
                onReleased: {
                    parent.scale = 1.0;
                   senha_.setserialNumber(8,0);
                }
            }
        }

        Image {
            id: nine
            x: 295
            y: 274
            source: "IconesSenha/9.bmp"
            fillMode: Image.PreserveAspectFit
            MouseArea{
                anchors.fill: parent
                onPressed: { parent.scale = 0.95; }
                onReleased: {
                    parent.scale = 1.0;
                   senha_.setserialNumber(9,0);
                 }
            }
        }

        Image {
            id: zero
            x: 222
            y: 340
            source: "IconesSenha/0.bmp"
            fillMode: Image.PreserveAspectFit
            MouseArea{
                anchors.fill: parent
                onPressed: { parent.scale = 0.95; }
                onReleased: {
                    parent.scale = 1.0;
                   senha_.setserialNumber(0,0);

                 }
            }
        }

        Image {
            id: enter
            x: 295
            y: 340
            source: "IconesSenha/enter.bmp"
            fillMode: Image.PreserveAspectFit
            MouseArea{
                anchors.fill: parent
                onPressed: { parent.scale = 0.95; }
                onReleased: {
                    parent.scale = 1.0;
                     senha_.setserialNumber(1,100);
                 }
            }
        }

        Image {
            id: del
            x: 146
            y: 340
            source: "IconesSenha/del.bmp"
            fillMode: Image.PreserveAspectFit
            MouseArea{
                anchors.fill: parent
                onPressed: { parent.scale = 0.95; }
                onReleased: {
                    parent.scale = 1.0;
                     senha_.setserialNumber(1,99);
                }
            }
        }

        Image {
            id: back
            x: -1
            y: 0
            fillMode: Image.PreserveAspectFit
            source: "IndicadoresCentrais/Back.png"
            MouseArea{
                anchors.fill: parent
                onPressed: { parent.scale = 0.95; }
                onReleased: {
                    parent.scale = 1.0;
                    root.state = "Menu"
                }
            }
        }
    }

}

