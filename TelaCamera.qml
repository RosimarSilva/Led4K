import QtQuick 2.0

Item {
    id: pricipal

    property int figura: 0
    property int  zooom: 0
    property int  enhancementy: 1
    property int ganho: 0
    property bool white: true
    Image {
        id: camera
        x: 35
        y: 20
        source: "Telas/TelaCamera.bmp"
        fillMode: Image.PreserveAspectFit

        Connections{  //enquanto não há white balance feito fica piscando
                target: serial
            onWhitePisc:{
                      whitePisc();
             }
        }

        Connections{//troca a imagem do zoom do display
                target: serial
            onChangeZoomImage:{
                     imageZoom();
             }
        }

        Connections{//troca a imagem do enhancement do display
                target: serial
            onChangeEnhancementImage:{
                     imageEnhancement();
            }
        }

        Connections{//coloca a imagem enhancemnet off no display
                target: serial
            onChangedEnhancementOff:{
                    enhancement.state = "EnhanceOff"
                    enhancementy = 0;
             }
        }


        Connections{//troca a imagem do ganho do display
                target: serial
            onChangeGainImage:{
                   imageGain();
             }
        }

        Connections{
                target: serial
            onUser1:{ laparo.state = "User1"}
        }

        Connections{
                target: serial
            onUser2:{ laparo.state = "User2"}
        }

        Connections{
                target: serial
            onUser3:{ laparo.state = "User3"}
        }

        Connections{
                target: serial
            onUser4:{ laparo.state = "User4"}
        }

        // escreve no monitor em qual user estamos
        Connections{
                target: serial
             onLaparo:{ enhancementy = 0;
                setEnhancement.start();
             }
         }
       //recebeu comando da cabeça para mudar de tela
        Connections{
            target: gpio
            onChangeTelaLed:{
                root.state = "TelaLed"
                gpio.setTela(2);
               serial.mensagens(90,1);//escreve a porcentagem do led do monitor
            }
        }
        //esses timers funcionam apenas quando há troca de user
        Timer
        {
            id:setEnhancement
            interval: 500
            running: false
            repeat: false
            onTriggered:{ serial.setComandoIke(5);
                setGain.start();
            }
        }

        Timer
        {
            id:setGain
            interval: 500
            running: false
            repeat: false
            onTriggered:{ serial.setComandoIke(6);
                ganho = 100;
                imageGain()
            }
        }


        Image {
            id: enhancement
            x: 45
            y: 92
            source: "Icones/Enhancehigh.png"
            fillMode: Image.PreserveAspectFit
            MouseArea{
                anchors.rightMargin: 0
                anchors.bottomMargin: 4
                anchors.leftMargin: 0
                anchors.topMargin: -4
                anchors.fill: parent
                onPressed: {parent.scale  = 0.95;}
                onReleased: {
                    parent.scale = 1.0;
                    serial.setComandoIke(5);
                }
             }

            states: [
                State {
                    name: "EnhanceOff"
                 },
                State {
                    name: "EnhanceHigh"
                 },
                State {
                    name: "EnhanceMed"
                 },
                State {
                    name: "EnhanceMin"
                 }
              ]

            Image {
                id: enhance00
                source: "Icones/EnhanceOff.png"
                visible: enhancement.state == "EnhanceOff"
            }

            Image {
                id: enhance03
                source: "Icones/Enhancehigh.png"
               visible: enhancement.state == "EnhanceHigh"
            }

            Image {
                id: enhance02
                source: "Icones/Enhancemed.png"
               visible: enhancement.state == "EnhanceMed"
            }

            Image {
                id: enhance01
                source: "Icones/EnhanceLow.png"
              visible: enhancement.state == "EnhanceMin"
            }
        }

        Image {
            id: laparo
            x: 673
            y: 105
            source: "Icones/Laparo01.png"
            fillMode: Image.PreserveAspectFit
            MouseArea{
                anchors.fill: parent
                onPressed: {parent.scale  = 0.95;}
                onReleased: {
                    parent.scale = 1.0;
                    root.state = "User"
                    serial.changeTela(3);//envia para o c++ começar a contar um tempo
                }
             }

            states: [
                State {
                    name: "User1"
                 },
                State {
                    name: "User2"
                 },
                State {
                    name: "User3"
                 },
                State {
                    name: "User4"
                 }
              ]

            Image {
                id: user01
                source:  "Icones/Laparo01.png"
                visible: laparo.state == "User1"
            }

            Image {
                id: user02
                source: "Icones/Laparo02.png"
               visible: laparo.state == "User2"
            }

            Image {
                id: user03
                source: "Icones/Endoflexivel.png"
               visible: laparo.state == "User3"
            }

            Image {
                id: user04
                source: "Icones/Histero.png"
              visible: laparo.state == "User4"
            }
        }

        Image {
            id: menu
            x: 649
            y: 8
            source: "Icones/BotaoMenu.png"
            fillMode: Image.PreserveAspectFit
            MouseArea{
                anchors.fill: parent
                onPressed: {parent.scale  = 0.95;}
                onReleased: {
                    parent.scale = 1.0;
                    serial.changeTela(4);
                    root.state = "Menu"
                }
             }
        }

        Image {
            id: led
            x: 493
            y: 6
            source: "Icones/Lamp.png"
            fillMode: Image.PreserveAspectFit
            MouseArea{
                anchors.rightMargin: 0
                anchors.bottomMargin: 3
                anchors.leftMargin: 0
                anchors.topMargin: -3
                anchors.fill: parent
                onPressed: {parent.scale  = 0.98;}
                onReleased: {
                    parent.scale = 1.0;
                    root.state = "TelaLed"
                    serial.changeTela(2);
                    gpio.setTela(2);
                    serial.mensagens(90,1);//escreve a porcentagem do led do monitor
                }
             }
        }

        Image {
            id: zoom
            x: 461
            y: 222
            source: "Icones/Zoom0.png"
            fillMode: Image.PreserveAspectFit
            MouseArea{
                anchors.rightMargin: 0
                anchors.bottomMargin: 9
                anchors.leftMargin: 0
                anchors.topMargin: -9
                anchors.fill: parent
                onPressed: {parent.scale  = 0.95;}
                onReleased: {
                    parent.scale = 1.0;
                    serial.setComandoIke(4);
                   // Qt.openUrlExternally("http://www.youtube.com/")
                }
             }

            states: [
                State {
                    name: "Zoom0"
                 },
                State {
                    name: "Zoom1"
                 },
                State {
                    name: "Zoom2"
                 },
                State {
                    name: "Zoom3"
                 }
              ]

            Image {
                id: zoom00
                source: "Icones/Zoom0.png"
                visible: zoom.state == "Zoom0"
            }

            Image {
                id: zoom01
                source: "Icones/Zoom1.png"
                visible: zoom.state == "Zoom1"
            }

            Image {
                id: zoom02
                source: "Icones/Zoom2.png"
                visible: zoom.state == "Zoom2"
            }

            Image {
                id: zoom03
                source: "Icones/Zoom3.png"
                visible: zoom.state == "Zoom3"
            }
        }

        Image {
            id: gain
            x: 461
            y: 92
            source: "Icones/Ganho0.png"
            fillMode: Image.PreserveAspectFit
            MouseArea{
                anchors.rightMargin: 0
                anchors.bottomMargin: -9
                anchors.leftMargin: 0
                anchors.topMargin: 9
                anchors.fill: parent
                onPressed: {parent.scale  = 0.95;}
                onReleased: {
                    parent.scale = 1.0;
                    serial.setComandoIke(6);
                   //  Qt.openUrlExternally("http://www.nxp.com/")
                }
             }

            states: [
                State {
                    name: "Gain0"
                 },
                State {
                    name: "Gain1"
                 },
                State {
                    name: "Gain2"
                 }
              ]

            Image {
                id: gain00
                source: "Icones/Ganho0.png"
                visible: gain.state == "Gain0"
            }

            Image {
                id: gain01
                source: "Icones/Ganho1.png"
                visible: gain.state == "Gain1"
            }

            Image {
                id: gain02
                source: "Icones/Ganho2.png"
                visible: gain.state == "Gain2"
            }
        }

        Image {
            id: whitebalance
            x: 209
            y: 84
            source: "Icones/white1.png"
            fillMode: Image.PreserveAspectFit
            MouseArea{
                anchors.fill: parent
                onPressed: {parent.scale  = 0.95;}
                onReleased: {
                    parent.scale = 1.0;
                }
             }

            states: [
                State {
                    name: "White0"
                 },
                State {
                    name: "White1"
                 },
                State {
                    name: "White2"
                 }
              ]
            Image {
                id: white00
                source: "Icones/white0.png"
                visible: whitebalance.state == "White0"
            }
            Image {
                id: white01
                source: "Icones/white1.png"
                visible: whitebalance.state == "White1"
            }
            Image {
                id: white02

                source: "Icones/white2.png"
                visible: whitebalance.state =="White2"
            }
        }

        Image {
            id: connect
            x: 15
            y: 360
            source: "Icones/conectOff.png"
            fillMode: Image.PreserveAspectFit
        }
    }

    function whitePisc(){
        figura ++;
        if(figura > 1)figura = 0;
        switch(figura)
        {
             case 0:
                 whitebalance.state = "White0"
                 break
             case 1:
                 whitebalance.state = "White1"
                 break
             case 2:
                 whitebalance.state = "White2"
                 break
        }
    }
    function imageZoom(){
        zooom ++;
        if(zooom > 3)zooom = 0;
        switch(zooom)
        {
        case 0:
            zoom.state =  zoom.state = "Zoom0"
            break

        case 1:
            zoom.state =  zoom.state = "Zoom1"
            break

        case 2:
            zoom.state =  zoom.state = "Zoom2"
            break

        case 3:
            zoom.state =  zoom.state = "Zoom3"
            break
        }
    }

    function imageEnhancement(){
          enhancementy ++;
        if(enhancementy > 3) enhancementy = 1;
       switch(enhancementy)
       {
        case 1:
         enhancement.state = "EnhanceHigh"
            break

        case 2:
         enhancement.state = "EnhanceMed"
            break

        case 3:
         enhancement.state = "EnhanceMin"
            break

       }
    }

    function imageGain()
    {
        ganho ++;
        if(ganho > 2)ganho = 0;
        switch(ganho)
        {
        case 0:
             gain.state = "Gain0"
            break

        case 1:
             gain.state = "Gain1"
            break

        case 2:
             gain.state = "Gain2"
        break

        }
    }

}



/*##^## Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
 ##^##*/
