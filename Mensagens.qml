import QtQuick 2.0

Item {
    Image {//botao de voltar a tela principal da câmera
        id: menu
        x: 651
        y: 8
        fillMode: Image.PreserveAspectFit
        source: "IndicadoresCentrais/BotaoMenu.png"
        MouseArea{
            anchors.fill: parent
            onPressed: {parent.scale  = 0.95;}
            onReleased: {
                parent.scale = 1.0;

            }
        }
    }
}
