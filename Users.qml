import QtQuick 2.0

Item {
    id:user
    Image {
        id: users
        x: 35
        y: 20
        source: "Telas/users.bmp"
        fillMode: Image.PreserveAspectFit
        Timer{//após escolher o user espera enviar o comando para ikegami e se atualiza
            id:back
            interval: 1500
            repeat: false
            running: false
            onTriggered: {
                root.state = "Principal"
            }
        }
        Timer{//após escolher o user espera enviar o comando para ikegami e se atualiza
            id:timeBack
            interval: 5000
            repeat: false
            running: false
            onTriggered: {
                root.state = "Principal"
            }
        }
        Connections{  //começa a contar um tempo para voltar a tela principal caso não haja tecla pressionada
                target: serial
            onTela3:{
                      timeBack.start();
             }
        }

        Image {
            id: laparo001
            x: 206
            y: 88
            source: "IconesCalUsers/Laparo01.bmp"
            fillMode: Image.PreserveAspectFit
            MouseArea{
                anchors.rightMargin: 0
                anchors.bottomMargin: -2
                anchors.leftMargin: 0
                anchors.topMargin: 2
                anchors.fill: parent
                onPressed: {parent.scale  = 0.95;}
                onReleased: {
                          parent.scale = 1.0;
                    serial.setUser(1);
                    escLaparo01.state = "Laparo01"
                    back.start();
                    timeBack.stop();
                }
            }
        }

        Image {
            id: laparo002
            x: 206
            y: 163
            source: "IconesCalUsers/Laparo02.bmp"
            fillMode: Image.PreserveAspectFit
            MouseArea{
                anchors.fill: parent
                onPressed: {parent.scale  = 0.95;}
                onReleased: {
                    parent.scale = 1.0;
                    serial.setUser(2);
                    escLaparo01.state = "Laparo02"
                     back.start();
                    timeBack.stop();
                }
            }
        }

        Image {
            id: user003
            x: 206
            y: 237
            source: "IconesCalUsers/Endoflexible.bmp"
            fillMode: Image.PreserveAspectFit
            MouseArea{
                anchors.fill: parent
                onPressed: {parent.scale  = 0.95;}
                onReleased: {
                    parent.scale = 1.0;
                    serial.setUser(3);
                    escLaparo01.state = "Laparo03"
                     back.start();
                    timeBack.stop();
                }
            }
        }

        Image {
            id: user004
            x: 206
            y: 315
            source: "IconesCalUsers/HysteroUro.bmp"
            fillMode: Image.PreserveAspectFit
            MouseArea{
                anchors.fill: parent
                onPressed: {parent.scale  = 0.95;}
                onReleased: {
                    parent.scale = 1.0;
                    serial.setUser(4);
                    escLaparo01.state = "Laparo04"
                     back.start();
                    timeBack.stop();
                }
            }
        }

        Image {
            id: escLaparo01
            x: 0
            y: 0
            source: "Icones/Userlaparo1.png"
            fillMode: Image.PreserveAspectFit
            MouseArea{
                anchors.fill: parent
               onClicked: {
                     root.state  =  "Principal"
                   timeBack.stop();
                }
            }

            states: [
                State {
                    name: "Laparo01"
               },
                State {
                    name: "Laparo02"
               },
                State {
                    name: "Laparo03"
               },
                State {
                    name: "Laparo04"
               }
            ]

            Image {
                id: lap001
                source: "Icones/Userlaparo1.png"
                visible: escLaparo01.state ==  "Laparo01"
            }
            Image {
                id: lap002
                source: "Icones/Userlaparo2.png"
                visible: escLaparo01.state ==  "Laparo02"
            }
            Image {
                id: lap003
                source: "Icones/UserEndiflexivel.png"
                visible: escLaparo01.state ==  "Laparo03"
            }
            Image {
                id: lap004
                source: "Icones/UserHisteroUro.png"
                visible: escLaparo01.state ==  "Laparo04"
            }
        }

    }

}

/*##^## Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
 ##^##*/
