import QtQuick 2.0

Item {
    id:mens
    property bool zoom00: true
     property bool zoom15: true
     property bool zoom20: true
     property bool zoom25: true
    Rectangle{
        id:message
        Connections{
                target: serial
           onMensZoom00:{
              mesZoo0.start();
            }
        }

        Connections{
                target: serial
           onMensZoom15:{
               mesZoo15.start();
            }
        }

        Connections{
                target: serial
           onMensZoom20:{
               mesZoo20.start();
            }
        }

        Connections{
                target: serial
           onMensZoom25:{
              mesZoo25.start();
            }
        }
//aguarda um tempo para escrever no monitor mensagens de zoom
        Timer{
            id:mesZoo0
            interval: 250
            repeat: false
            running: false
            onTriggered: {serial.mensagens(4,1); }
        }

        Timer{
            id:mesZoo15
            interval: 250
            repeat: false
            running: false
            onTriggered: { serial.mensagens(4,1);}
        }

        Timer{
            id:mesZoo20
            interval: 250
            repeat: false
            running: false
            onTriggered: {serial.mensagens(4,1);}
        }

        Timer{
            id:mesZoo25
            interval: 250
            repeat: false
            running: false
            onTriggered: {serial.mensagens(4,1);}
        }

   //exibira mensagens de ganho no monitor

        Connections{
                target: serial
           onGanhoHigh:{
               ganhoHigh.start();
           }
        }
        Connections{
                target: serial
           onGanhoUltraHigh:{
               ganhoUltraHigh.start();
            }
        }
        Connections{
                target: serial
           onGanhoLow:{
               ganhoLow.start();
            }
        }

        Timer{
            id:ganhoHigh
            interval: 350
            repeat: false
            running: false
            onTriggered: {serial.mensagens(12,1);}//escreve no display G
        }
        Timer{
            id:ganhoUltraHigh
            interval: 350
            repeat: false
            running: false
            onTriggered: {serial.mensagens(12,1);}//escreve no display GG
        }
        Timer{
            id:ganhoLow
            interval: 350
            repeat: false
            running: false
            onTriggered: {serial.mensagens(12,1);}//apaga os GGs
        }

        // exibe mensagens de enhancement no monitor

        Connections{
                target: serial
           onEnhancementLLow:{
               enhancementLow.start();
            }
        }
        Connections{
                target: serial
           onEnhancementMMed:{
               enhancementMed.start();
            }
        }
        Connections{
                target: serial
           onEnhancementHHigh:{
               enhancementHigh.start();
            }
        }
        Connections{
                target: serial
           onEnhancementOOff:{
               enhancementOff.start();
           }
        }

        Timer{
            id:enhancementLow
            interval: 350
            repeat: false
            running: false
            onTriggered: { serial.mensagens(5,1);clearEnhancement.start();} //escreve no monitor enhancement LOW
            }

        Timer{
            id:enhancementMed
            interval: 350
            repeat: false
            running: false
            onTriggered: {serial.mensagens(5,1);clearEnhancement.start();}//escreve no monitor enhancement MED
        }

        Timer{
            id:enhancementHigh
            interval: 350
            repeat: false
            running: false
            onTriggered: {serial.mensagens(5,1);clearEnhancement.start();}//escreve no monitor enhancement HIGH
        }

        Timer{
            id:enhancementOff
            interval: 350
            repeat: false
            running: false
            onTriggered: {serial.mensagens(5,1);clearEnhancement.start();}//escreve no monitor enhancement OFF
        }

        Timer{
            id:clearEnhancement
            interval: 3000
            repeat: false
            running: false
            onTriggered: {serial.mensagens(1005,1);}//apaga o que estiver escrito de enhancement no monitor
        }

//escreve no monitor a porcenntagem do led monitor
        Connections{
                target: serial
           onPorcentagemLed:{
               pecentLed.start();
           }
        }

        Timer{
            id:pecentLed
            interval: 250
            repeat: false
            running: false
            onTriggered: { serial.mensagens(90,1);} //escreve no monitor enhancement LOW
            }

   // escreve no monitor em qual user estamos
        Connections{
                target: serial
           onLaparo:{
              serial.mensagens(1,1);
               timerLaparo.start();
            }
        }
        Connections{
                target: serial
           onChangedEnhancementOff:{
              serial.mensagens(1,1);
                timerLaparo.start();
            }
        }

        Timer{
            id:timerLaparo
            interval: 2500
            repeat: false
            running: false
            onTriggered: { serial.mensagens(1001,1);} //apaga o que estiver de escrito de laparo no monitor
            }
    }
}
