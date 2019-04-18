import QtQuick 2.0


Item {
    id:password
    property int  asteriscoo: 0

    Image {
        id: senhaconf
        x: 35
        y: 20
        source: "Telas/senha.bmp"
        fillMode: Image.PreserveAspectFit

        Connections{  //enquanto não há white balance feito fica piscando
                target: senha_
            onScreenConfig:{
                asterisco.state = "Asterisco0";
                root.state =  "Configuração"

             }
        }

        Connections{  //enquanto não há white balance feito fica piscando
            target: senha_
            onScreenMenu:{
                asterisco.state = "Asterisco0";

                root.state =  "Menu"

            }
        }

        Connections{  //enquanto não há white balance feito fica piscando
            target: senha_
            onScreenNumberSerie:{
                  asterisco.state = "Zero"

               root.state =  "SerialNumber"

            }
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
                    contAsterisco();
                    senha_.setSenha(1);


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
                     contAsterisco();
                   senha_.setSenha(2);


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
                     contAsterisco();
                      senha_.setSenha(3);

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
                     contAsterisco();
                     senha_.setSenha(4);
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
                    contAsterisco();
                     senha_.setSenha(5);
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
                     contAsterisco();
                       senha_.setSenha(6);
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
                    contAsterisco();
                    senha_.setSenha(7);
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
                    contAsterisco();
                    senha_.setSenha(8);
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
                     contAsterisco();
                      senha_.setSenha(9);
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
                     contAsterisco();
                     senha_.setSenha(0);
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
                   asterisco.state = "Asterisco0"
                    // if(asteriscoo >= 4)  root.state = "Configuration"
                   //  else  root.state = "Menu"
                     asteriscoo = 0;
                      senha_.setSenha(100);

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
                    asteriscoo -= 1;
                    if(asteriscoo <= 0)asteriscoo = 0;

                    showAsterisco();
                     senha_.setSenha(99);
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
                    root.state = "Menu"
                }
            }
        }

        Image {
            id: asterisco
            x: 165
            y: 83
            source: "IconesSenha/asterisco0.bmp"
            fillMode: Image.PreserveAspectFit

            states: [
                State {
                    name: "Asterisco0"
                },
                State {
                    name: "Asterisco1"
                },
                State {
                    name: "Asterisco2"
                },
                State {
                    name: "Asterisco3"
                },
                State {
                    name: "Asterisco4"
                }
            ]

            Image {
                id: ast0
                source: "IconesSenha/asterisco0.bmp"
                visible: asterisco.state == "Asterisco0"
            }

            Image {
                id: ast1
                source: "IconesSenha/asterisco1.bmp"
                visible: asterisco.state == "Asterisco1"
            }

            Image {
                id: ast2
                source: "IconesSenha/asterisco2.bmp"
                visible: asterisco.state == "Asterisco2"
            }

            Image {
                id: ast3
                source: "IconesSenha/asterisco3.bmp"
                visible: asterisco.state == "Asterisco3"
            }

            Image {
                id: ast4
                source: "IconesSenha/asterisco4.bmp"
                visible: asterisco.state == "Asterisco4"
            }
        }

    }
    function showAsterisco()
    {
        switch(asteriscoo)
        {
             case 0:asterisco.state =  "Asterisco0";break

             case 1:asterisco.state =  "Asterisco1";break

             case 2:asterisco.state =  "Asterisco2";break

             case 3:asterisco.state =  "Asterisco3";break

             case 4:asterisco.state =  "Asterisco4";break
        }
    }

    function contAsterisco()
    {
        asteriscoo += 1;
        if(asteriscoo > 4)asteriscoo = 4;

        showAsterisco();
    }

}
