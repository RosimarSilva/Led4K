import QtQuick 2.0

Item {
    id:init

    property int  telaInit: 0
   //estados entre as tela de Inicializacao
    Image {
        id: inicializa
        x: 35
        y: 20
        source: "TelasInit/Init.bmp"
        fillMode: Image.PreserveAspectFit
      //recebe do c++ a troca de tela
        Connections{
                target: initial
            onInit:{
                telaInit ++;
                if(telaInit > 11) telaInit = 0;
                switch(telaInit)
                {
                case 0: inicializa.state="Init0"
                    break
                case 1: inicializa.state="Init1"
                    break
                case 2: inicializa.state="Init2"
                    break
                case 3: inicializa.state="Init3"
                    break
                case 4: inicializa.state="Init4"
                    break
                case 5: inicializa.state="Init5"
                    break
                case 6: inicializa.state="Init6"
                    break
                case 7: inicializa.state="Init7"
                    break
                case 8: inicializa.state="Init8"
                    break
                case 9: inicializa.state="Init9"
                    break
                case 10: inicializa.state="Init10"
                    break
                case 11: root.state="Principal"
                    serial.setInit();//diz para o qml que ja pode receber os comandos pelo display
                    break
                }
            }
        }

        states: [
            State {
                name: "Init0"
            },
            State {
                name: "Init1"
            },
            State {
                name: "Init2"
            },
            State {
                name: "Init3"
            },
            State {
                name: "Init4"
            },
            State {
                name: "Init5"
            },
            State {
                name: "Init6"
            },
            State {
                name: "Init7"
            },
            State {
                name: "Init8"
            },
            State {
                name: "Init9"
            },
            State {
                name: "Init10"
            }
        ]
        Image {
            id: init0

            source: "TelasInit/Init.bmp"
            visible: inicializa.state == "Init0"
        }
        Image {
            id: init1

            source: "TelasInit/Init1.bmp"
            visible: inicializa.state == "Init1"
        }
        Image {
            id: init2

            source: "TelasInit/Init2.bmp"
            visible: inicializa.state == "Init2"
        }
        Image {
            id: init3

            source: "TelasInit/Init3.bmp"
            visible: inicializa.state == "Init3"
        }
        Image {
            id: init4

            source: "TelasInit/Init4.bmp"
            visible: inicializa.state == "Init4"
        }
        Image {
            id: init5

            source: "TelasInit/Init5.bmp"
            visible: inicializa.state == "Init5"
        }
        Image {
            id: init6

            source: "TelasInit/Init6.bmp"
            visible: inicializa.state == "Init6"
        }
        Image {
            id: init7

            source: "TelasInit/Init7.bmp"
            visible: inicializa.state == "Init7"
        }
        Image {
            id: init8

            source: "TelasInit/Init8.bmp"
            visible: inicializa.state == "Init8"
        }
        Image {
            id: init9

            source: "TelasInit/Init9.bmp"
            visible: inicializa.state == "Init9"
        }
        Image {
            id: init10

            source: "TelasInit/Init10.bmp"
            visible: inicializa.state == "Init10"
        }
    }

}
