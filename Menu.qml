import QtQuick 2.0

Item {
    property  int versaoSoftawre: 110419
     property  int seriales: 0
    Image {
        id: image
        x: 35
        y: 20
        source: "Telas/Menu.bmp"
        fillMode: Image.PreserveAspectFit

        Connections{  //enquanto não há white balance feito fica piscando
                target: senha_
            onChangedSerial:{
                       seriales = senha_.serial;
             }
        }

        Text {
             x:522
              y: 388
             width: parent.width/2
            height: 25
            horizontalAlignment:  Text.AlignVCenter
           font.pointSize: 15
           color: "white"
           text: +versaoSoftawre
       }

        Text {
            x: 392
            y: 388
             width: parent.width/2
              height: 25
            horizontalAlignment:  Text.AlignVCenter
            font.pointSize: 15
            color: "white"
            text: +seriales;
        }

        Timer{//após escolher o user espera enviar o comando para ikegami e se atualiza
            id:back
            interval: 5000
            repeat: false
            running: false
            onTriggered: {
                root.state = "Principal"
            }
        }
        Connections{  //começa a contar um tempo para voltar a tela principal caso não haja tecla pressionada
                target: serial
            onTela4:{
                      back.start();
             }
        }

        Image {
            id: configuration
            x: 412
            y: 198
            source: "figurasMenu/configuration.png"
            fillMode: Image.PreserveAspectFit
            MouseArea{
                anchors.fill: parent
                onPressed: {parent.scale  = 0.95;}
                onReleased: {
                    parent.scale = 1.0;
                    root.state = "Senha"
                     senha_.setConfig(true);//envia para  c++ que se a senha for digitada correta vao para a tela de configuração
                     back.stop();
                }
            }
        }

        Image {
            id: serialNumber
            x: 412
            y: 89
            source: "figurasMenu/serialNumber.png"
            fillMode: Image.PreserveAspectFit
            MouseArea{
                anchors.fill: parent
                onPressed: {parent.scale  = 0.95;}
                onReleased: {
                    parent.scale = 1.0;
                    root.state = "Senha"
                    senha_.setConfig(false);//envia para  c++ que se a senha for digitada correta vao para a tela de inserção de némro de série
                    back.stop();
                }
            }
        }

        Image {
            id: calendario
            x: 121
            y: 89
            source: "figurasMenu/configuracao.png"
            fillMode: Image.PreserveAspectFit
            MouseArea{
                anchors.fill: parent
                onPressed: {parent.scale  = 0.95;}
                onReleased: {
                    parent.scale = 1.0;
                    root.state = "Calendario"
                    serial.changeTela(5);
                    back.stop();
                }
            }
        }

        Image {
            id: history
            x: 121
            y: 198
            source: "figurasMenu/historico.png"
            fillMode: Image.PreserveAspectFit
            MouseArea{
                anchors.fill: parent
                onPressed: {parent.scale  = 0.95;}
                onReleased: {
                    parent.scale = 1.0;
                    back.stop();
                }
            }
        }


    }

    Image {
        id: back_
        x: 35
        y: 20
        source: "Icones/Back.png"
        fillMode: Image.PreserveAspectFit
        MouseArea{
            anchors.fill: parent
            onPressed: {parent.scale  = 0.95;}
            onReleased: {
                parent.scale = 1.0;
                back.stop();
                 root.state = "Principal"
            }
        }
    }

}
