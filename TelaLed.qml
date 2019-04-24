import QtQuick 2.0

Item {
     id: pricipalLed
    property int  pont: 0
    property int luminous: 0
    property bool standBai: false
    property int horaslamp: 0
    property color colorText: "white"

    Image {
        id: telaLed

        x: 35
        y: 20
        fillMode: Image.PreserveAspectFit
        source: "Telas/PrincipalFonte.bmp"
//se não haver tecla pressionada durante algum tempo volta para a tela de controle da câmera
        Timer{
            id:back
            repeat: false
            running: false
            interval: 5000
            onTriggered: {
                root.state = "Principal"
                serial.mensagens(1090,1);//apaga a porcentagem do led do monitor
            }
        }

        Connections{  //começa a contar um tempo para voltar a tela principal caso não haja tecla pressionada
                target: serial
            onTela2:{
                      back.start();
             }
        }

        Connections{  //recebe o número de horas da lâmpada do lado c++
                target: serial
            onHorasLampChanged:{
                       horaslamp = serial.horas;
             }
        }
        //recebe um comando da cabeça para mudar para a tela principal
        Connections{
           target: gpio
           onChangeTelaPrincipal:{
                root.state  = "Principal"
               gpio.setTela(1);
               serial.serial.mensagens(1090,1);//apaga a porcentagem do led do monitor
            }
        }

        //recebe um comando da cabeça para aumentar a intensidade do led
        Connections{
           target: gpio
           onChangeLuminousMais:{
               luminous +=1;
               if(luminous>=10)luminous = 10;
               setLuminous();
               serial.luminousLed(2);
                back.restart();
            }
        }
       //recebe um comando da cabeça para diminuir a intensidade do led
        Connections{
           target: gpio
           onChangeLuminousMenos:{
               luminous -=1;
               if(luminous<=0)luminous = 0;
               setLuminous();
               serial.luminousLed(1);
               back.restart();
            }
        }
        Text {
            x: 535
            y: 14
            horizontalAlignment:  Text.AlignVCenter
            font.pointSize: 22
            color: pricipalLed.colorText
            text:+pricipalLed.horaslamp
        }
        Image {//Ícone da lâmpada
            id: lamp
            x: 495
            y: 16
            fillMode: Image.PreserveAspectFit
            source: "IndicadoresCentrais/LAMP.bmp"
        }

        Image {//imagens central da tela
            id: central
            x: 197
            y: 70
            fillMode: Image.PreserveAspectFit
            source: "IndicadoresCentrais/indi00.png"
            states: [
                State {
                    name: "Indi00"
                },
                State {
                    name: "Indi10"
                },
                State {
                    name: "Indi20"
                },
                State {
                    name: "Indi30"
                },
                State {
                    name: "Indi40"
                },
                State {
                    name: "Indi50"
                },
                State {
                    name: "Indi60"
                },
                State {
                    name: "Indi70"
                },
                State {
                    name: "Indi80"
                },
                State {
                    name: "Indi90"
                },
                State {
                    name: "Indi100"
                }
            ]

            Image {
                id: indi0
                source: "IndicadoresCentrais/indi00.png"
                visible: central.state == "Indi00"
            }
            Image {
                id: indi10
                source: "IndicadoresCentrais/indi10.png"
                visible: central.state == "Indi10"
            }
            Image {
                id: indi20
                source: "IndicadoresCentrais/indi20.png"
                visible: central.state == "Indi20"
            }
            Image {
                id: indi30
                source: "IndicadoresCentrais/indi30.png"
                visible: central.state == "Indi30"
            }
            Image {
                id: indi40
                source: "IndicadoresCentrais/indi40.png"
                visible: central.state == "Indi40"
            }
            Image {
                id: indi50
                source: "IndicadoresCentrais/indi50.png"
                visible: central.state == "Indi50"
            }
            Image {
                id: indi60
                source: "IndicadoresCentrais/indi60.png"
                visible: central.state == "Indi60"
            }
            Image {
                id: indi70
                source: "IndicadoresCentrais/indi70.png"
                visible: central.state == "Indi70"
            }
            Image {
                id: indi80
                source: "IndicadoresCentrais/indi80.png"
                visible: central.state == "Indi80"
            }
            Image {
                id: indi90
                source: "IndicadoresCentrais/indi90.png"
                visible: central.state == "Indi90"
            }
            Image {
                id: indi100
                source: "IndicadoresCentrais/indi100.png"
                visible: central.state == "Indi100"
            }
        }

        Image {//tecla menos (-) da tela principal
            id: minus
            x: 39
            y: 120
            fillMode: Image.PreserveAspectFit
            source: "IndicadoresCentrais/Minus.bmp"
            MouseArea{
                anchors.fill: parent
                onPressed: {parent.scale  = 0.95;}
                onReleased: {
                    parent.scale = 1.0;
                    luminous -=1;
                    if(luminous<=0)luminous = 0;
                    setLuminous();
                    serial.luminousLed(1);
                    back.restart();
                }
            }
        }

        Image {//tecla menos (+) da tela principal
            id: plus
            x: 468
            y: 120
            fillMode: Image.PreserveAspectFit
            source: "IndicadoresCentrais/Plus.bmp"
            MouseArea{
                anchors.fill: parent
                onPressed: {parent.scale  = 0.95;}
                onReleased: {
                    parent.scale = 1.0;
                    luminous +=1;
                    if(luminous>=10)luminous = 10;
                    setLuminous();
                    serial.luminousLed(2);
                     back.restart();
                }
            }
        }

        Image {//botao de voltar a tela principal da câmera
            id: menu
            x: 651
            y: 8
            fillMode: Image.PreserveAspectFit
            source: "Icones/HomeBack.png"
            MouseArea{
                anchors.rightMargin: 0
                anchors.bottomMargin: 0
                anchors.leftMargin: 0
                anchors.topMargin: 0
                anchors.fill: parent
                onPressed: {parent.scale  = 0.95;}
                onReleased: {
                    parent.scale = 1.0;
                    root.state = "Principal"
                    serial.mensagens(1090,1);//apaga a porcentagem do led do monitor
                }
            }
        }

        Image {
            id: connect
            x: 8
            y: 365
            fillMode: Image.PreserveAspectFit
            source: "Icones/conectOff.png"
        }

        Image {//botao standby da câmera
            id: standBy
            x: 653
            y: 134
            fillMode: Image.PreserveAspectFit
            source: "IndicadoresCentrais/StandByBranco.png"
            MouseArea{
                anchors.fill: parent
                onPressed: {parent.scale  = 0.95;}
                onReleased: {
                    parent.scale = 1.0;
                    enDisableStandyby();
                     back.restart();
                 }

                states: [
                    State {
                        name: "StandByOn"
                    },

                    State {
                        name: "StandByOff"
                    }
                ]
                Image {
                    id: standbyon
                    source: "IndicadoresCentrais/StandByVerde.png"
                    visible: standBy.state == "StandByOn"
                }
                Image {
                    id: standbyoff
                    source: "IndicadoresCentrais/StandByBranco.png"
                    visible: standBy.state ==  "StandByOff"
                }
            }
        }
     }

    function setLuminous()
    {
        if(standBai == true){ standBai = false;  standBy.state = "StandByOff"}
        switch(luminous)
        {
        case 0:
            central.state = "Indi00"

        break

        case 1:
            central.state = "Indi10"
        break

        case 2:
            central.state = "Indi20"
        break

        case 3:
            central.state = "Indi30"
        break

        case 4:
            central.state = "Indi40"
        break

        case 5:
            central.state = "Indi50"
        break

        case 6:
            central.state = "Indi60"
        break

        case 7:
            central.state = "Indi70"
        break

        case 8:
            central.state = "Indi80"
        break

        case 9:
            central.state = "Indi90"
        break

        case 10:
            central.state = "Indi100"
        break
        }
    }

    function enDisableStandyby()
    {
        if(standBai == false) standBai = true;
        else standBai = false;

         if(standBai) {
             standBy.state = "StandByOn"

             central.state = "Indi00"

             serial.standBy(true);
         }
         else {
             standBy.state = "StandByOff"
             setLuminous();
             serial.standBy(false);
         }
    }
}
