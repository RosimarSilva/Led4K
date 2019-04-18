import QtQuick 2.0

Item {
    id:calendaro

    property int calendarioDia: 0
    property int calendarioMes: 0
    property int calendarioAno: 0
    property int calendarioHora: 0
    property int calendariominuto: 0

     property color colorText: "white"

    property int  qMinuto: 0
    property int  rMinuto: 0
    Image {
        id: calendario
        x: 35
        y: 20
        fillMode: Image.PreserveAspectFit
        source:"Telas/calendario.bmp"

        //data recebida pela digitação do display

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
            onTela5:{
                      timeBack.start();
             }
        }

        Connections{
                target: calendario_
               onChangedHora:{calendarioDia = calendario_.dia;

             }
        }

        Connections{
                target: calendario_
             onChangedHora:{calendarioDia = calendario_.mes;

             }
        }
        Connections{
                target: calendario_
             onChangedHora:{calendarioDia = calendario_.ano;

             }
        }

        Connections{
                target: calendario_
            onChangedDia:{calendariominuto = calendario_.minuto;
                qMinuto = calendariominuto/10;
                 rMinuto = calendariominuto%10;

             }
        }

        Connections{
                target: calendario_
             onChangedHora:{calendarioHora = calendario_.hora;

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
                     timeBack.stop();
                }
            }
        }

        Image {
            id: minusDay
            x: 143
            y: 159
            fillMode: Image.PreserveAspectFit
            source: "figurasMenu/BotaoMinus.png"
            MouseArea{
                anchors.fill: parent
                onPressed: { parent.scale = 0.95; }
                onReleased: {
                    parent.scale = 1.0;
                    timeBack.start();
                 }
            }
        }

        Image {
            id: plusDay
            x: 236
            y: 158
            fillMode: Image.PreserveAspectFit
            source: "figurasMenu/BotaoPlus.png"
            MouseArea{
                anchors.fill: parent
                onPressed: { parent.scale = 0.95; }
                onReleased: {
                    parent.scale = 1.0;
                    calendario_.setHoras(0);
                    timeBack.start();
                }
            }
        }

        Image {
            id: plusMonth
            x: 441
            y: 158
            fillMode: Image.PreserveAspectFit
            source: "figurasMenu/BotaoPlus.png"
            MouseArea{
                anchors.fill: parent
                onPressed: { parent.scale = 0.95; }
                onReleased: {
                    parent.scale = 1.0;
                    timeBack.start();
                }
            }
        }

        Image {
            id: minusMonth
            x: 348
            y: 158
            fillMode: Image.PreserveAspectFit
            source: "figurasMenu/BotaoMinus.png"
            MouseArea{
                anchors.fill: parent
                onPressed: { parent.scale = 0.95; }
                onReleased: {
                    parent.scale = 1.0;
                    timeBack.start();
                }
            }
        }

        Image {
            id: minusYear
            x: 544
            y: 159
            fillMode: Image.PreserveAspectFit
            source: "figurasMenu/BotaoMinus.png"
            MouseArea{
                anchors.fill: parent
                onPressed: { parent.scale = 0.95; }
                onReleased: {
                    parent.scale = 1.0;
                    timeBack.start();
                }
            }
        }

        Image {
            id: plusyear
            x: 636
            y: 158
            fillMode: Image.PreserveAspectFit
            source: "figurasMenu/BotaoPlus.png"
            MouseArea{
                anchors.fill: parent
                onPressed: { parent.scale = 0.95; }
                onReleased: {
                    parent.scale = 1.0;
                    timeBack.start();
                }
            }
        }

        Image {
            id: plusHour
            x: 235
            y: 291
            fillMode: Image.PreserveAspectFit
            source: "figurasMenu/BotaoPlus.png"
            MouseArea{
                anchors.fill: parent
                onPressed: { parent.scale = 0.95; }
                onReleased: {
                    parent.scale = 1.0;
                    timeBack.start();
                }
            }
        }

        Image {
            id: minusHour
            x: 143
            y: 291
            fillMode: Image.PreserveAspectFit
            source: "figurasMenu/BotaoMinus.png"
            MouseArea{
                anchors.fill: parent
                onPressed: { parent.scale = 0.95; }
                onReleased: {
                    parent.scale = 1.0;
                    timeBack.start();
                }
            }
        }

        Image {
            id: minusMinute
            x: 348
            y: 291
            fillMode: Image.PreserveAspectFit
            source: "figurasMenu/BotaoMinus.png"
            MouseArea{
                anchors.fill: parent
                onPressed: { parent.scale = 0.95; }
                onReleased: {
                    parent.scale = 1.0;
                    timeBack.start();
                }
            }
        }

        Image {
            id: plusMinute
            x: 441
            y: 291
            fillMode: Image.PreserveAspectFit
            source: "figurasMenu/BotaoPlus.png"
            MouseArea{
                anchors.fill: parent
                onPressed: { parent.scale = 0.95; }
                onReleased: {
                    parent.scale = 1.0;
                    timeBack.start();
                }
            }
        }

        //variaveis do dia
              Text {
                  x: 190
                  y: 158
                  horizontalAlignment:  Text.AlignVCenter
                  font.pointSize: 30
                  color: calendaro.colorText
                  text: +calendario_.dia

              }

              //variaveis do ano
                    Text {
                        x: 390
                        y: 158
                        horizontalAlignment:  Text.AlignVCenter
                        font.pointSize: 30
                        color: calendaro.colorText
                        text: +calendario_.mes
                    }

        //variaveis do ano
              Text {
                  x: 590
                  y: 158
                  horizontalAlignment:  Text.AlignVCenter
                  font.pointSize: 30
                  color: calendaro.colorText
                  text: +calendario_.ano
              }

        //variaveis da hora
        Text {
             x:190
             y: 292
             horizontalAlignment:  Text.AlignVCenter
             font.pointSize: 30
             color: calendaro.colorText
             text:  +calendario_.hora
         }

         //variaveis do minuto

        Text {
            x: 395
            y: 292
            horizontalAlignment:  Text.AlignVCenter
            font.pointSize: 30
            color: calendaro.colorText
            text: +calendario_.minuto
           //text: +calendaro.qMinuto
        }


        Text {
            x: 623
            y: 26
            horizontalAlignment:  Text.AlignVCenter
            font.pointSize: 15
            color: calendaro.colorText
            text:+ calendario_.hora
        }
        Text {
            x: 655
            y: 26
            horizontalAlignment:  Text.AlignVCenter
            font.pointSize: 15
            color: calendaro.colorText
            text:+ calendario_.minuto
        }

        Text {
            x: 410
            y: 26
            horizontalAlignment:  Text.AlignVCenter
            font.pointSize: 15
            color: calendaro.colorText
            text:+calendario_.dia
        }
        Text {
            x: 455
            y: 26
            horizontalAlignment:  Text.AlignVCenter
            font.pointSize: 15
            color: calendaro.colorText
            text:+calendario_.mes
        }
        Text {
            x: 495
            y: 26
            horizontalAlignment:  Text.AlignVCenter
            font.pointSize: 15
            color: calendaro.colorText
            text:+calendario_.ano
        }


    }

}

/*##^## Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
 ##^##*/
