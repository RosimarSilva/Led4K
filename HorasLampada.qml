import QtQuick 2.0


Item {
    property int  horaslamp: 0
    id:lamp
    Image {
        id: horasLamp
        x: 35
        y: 20
        source: "Telas/horasLampada.jpg"
        fillMode: Image.PreserveAspectFit


        Connections{  //enquanto não há white balance feito fica piscando
                target: serial
            onBackConfig:{
                      root.state = "Configuração"
             }
        }

        Connections{  //enquanto não há white balance feito fica piscando
                target: serial
            onHorasLampChanged:{
                       horaslamp = serial.horas;
             }
        }
        Text {
            x: 180
            y: 80
            horizontalAlignment:  Text.AlignVCenter
            font.pointSize: 22
            color: "yellow"
            text:+lamp.horaslamp
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
                    serial.writeHoras(1,0);
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

                    serial.writeHoras(2,0);
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

                    serial.writeHoras(3,0);
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
                    serial.writeHoras(4,0);

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

                    serial.writeHoras(5,0);
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
                    serial.writeHoras(6,0);
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
                    serial.writeHoras(7,0);

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
                    serial.writeHoras(8,0);
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
                    serial.writeHoras(9,0);
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
                    serial.writeHoras(0,0);
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
                      root.state = "Configuration"
                      serial.writeHoras(0,100);
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
                    serial.writeHoras(0,99);
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
                    root.state = "Configuração"
                }
            }
        }
    }

}
