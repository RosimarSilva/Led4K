import QtQuick 2.9
import QtQuick.Window 2.2
import Astus4K 1.0

Window {
    visible: true
    width: 800
    height: 480
    color: "black"

    Rectangle{
        id:root

        Fonte4K{id:initial}
        Controle{id:serial}
        Calendario{id:calendario_}
        Password{id:senha_}

        Init{}
       // TelaCamera{}

        states: [
            State {
                name: "Inicializa"
             },
            State {
                name: "Principal"
             },
            State {
                name: "TelaLed"
             },
            State {
                name: "User"
             },
            State {
                name: "Menu"
             },
            State {
                name: "Calendario"
             },
            State {
                name: "Senha"
             },
            State {
                name: "SerialNumber"
            },
            State {
                name: "Configuração"
            }

        ]

        Init {
            id: init
            anchors.fill: parent
            visible: root.state == "Inicializa"
        }
        TelaCamera{
            id: pricipal
            anchors.fill: parent
            visible: root.state == "Principal"
        }

        TelaLed{
            id: pricipalLed
            anchors.fill: parent
            visible: root.state == "TelaLed"
        }

        Users{
            id: user
            anchors.fill: parent
            visible: root.state == "User"
        }
        Menu{
            id: menu
            anchors.fill: parent
            visible: root.state == "Menu"
        }
        Calendar{
            id: calendar
            anchors.fill: parent
            visible: root.state == "Calendario"
        }

        Senha{
            id: senha
            anchors.fill: parent
            visible: root.state == "Senha"
        }

        SerialNumber{
            id: sserialNum
            anchors.fill: parent
            visible: root.state == "SerialNumber"
        }
        Config{
            id: configuration
            anchors.fill: parent
            visible: root.state == "Configuração"
        }
    }
}
