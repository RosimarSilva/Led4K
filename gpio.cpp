#include "gpio.h"
#include  <QEvent>

GPIO::GPIO(QObject *parent): QObject(parent),
   m_path_b1("/sys/class/gpio/keypad_pin6/value"),m_path_b2("/sys/class/gpio/keypad_pin8/value"),
   m_path_b3("/sys/class/gpio/keypad_pin7/value"),m_value_b1(0),m_value_b2(0),m_value_b3(0)
{
   // qDebug("construido");

  qDebug() << Q_FUNC_INFO;
  gpioExport();

  setDirectionGpioBotao1();
  setDirectionGpioBotao2();
  setDirectionGpioBotao3();
  setTela(1);//na inicialização do sistema define que os comandos da cabeça se direcionará para controle da câmera

   timerBotao.start(150);
   //Lê os botoẽs da cabeça a cada 250 mlissegundos
  connect(&timerBotao, &QTimer::timeout, [&](){

      QByteArray gpioValue1;
     QFile gpio1(m_path_b1);
     QByteArray gpioValue2;
     QFile gpio2(m_path_b2);
     QByteArray gpioValue3;
     QFile gpio3(m_path_b3);
     int botao1,botao2,botao3;

//No sistema Linux tudo é baseado em arquivo, portanto para ler um estado de um pino deve-se abrir ler e fechar o arquivo e vai corinthians
    if (gpio1.open(QIODevice::ReadOnly)) {         // Abre arquivo
      gpioValue1 = gpio1.readAll();//  // Le o arquivo
       gpio1.close();

       tecla = gpioValue1[0]; // lê se há tecla pressionada
        if(tecla == 49)  // se for 49 não há
       {
         botao1 = 0;

         setLed = false;
        if(tela == 1) // se a tela for (principal)
        {
           if(auxBotao != botao1) // // se o botao antes estava apertado e agora está solto
           {
               if(tela == 1)this->setWiteBalnce();//this->setEnhance(); // muda o enhancement
            }

        }
         auxBotao = botao1;// iguala os botoes

      }else {
          botao1 = 1;
          if((tela == 2)&&(setLed == false))this-> changeLuminousMais();//this-> setLuminousMenos(); // se estiver na tela de ajuste do Led este botao diminui a intensidade do led
          auxBotao = botao1;// iguala botoes
        //  qDebug("clicked");
     }
  }

  if (gpio2.open(QIODevice::ReadOnly)) {         // Abre arquivo
      gpioValue2 = gpio2.readAll();// // Le o arquivo e remove
      gpio2.close();                             // Fecha arquivo

      tecla2 = gpioValue2[0]; // lê se há tecla pressionada

      if(tecla2 == 49)
      {
         botao2 = 0;
          contBotao2 =0;

        // setWhite = false;// não deixar dar white balance ao voltar para atela principal
        //  setLed = false;


         if(tela == 1) changeTelas = true;
         else changeTelas = false;

         if(tela == 1) //se atela for a do ajuste deo led
         {
            if(auxBotao2 != botao2)  // se o botao antes estava apertado e agora está solto
            {
               if((tela == 1) &&(setGain == true)) this->setGanho();// mas agora vai dar é zoom
            }
         }
            setGain = true;// não deixar dar white balance ao voltar para atela principal
          auxBotao2 = botao2;  // iguala os botoes



      }else {
            botao2 = 1;
            cont2 ++;
            contBotao2 ++;
           //  qDebug("clicked");


          if((tela == 2)&&(changeTelas == false))
          {
            if((auxBotao2 == botao2)&&(contBotao2 > 5))//se o botao estiver pressionado por alguns segundos volta a tela principal
            {
                  setGain = false;// não deixar dar white balance ao voltar para atela principal
                 this->setTelaPrincipal();  // volta para a tela principal
                return;
              }
            }

        else if((tela == 1)&&(changeTelas == true))
          {
            if((auxBotao2 == botao2)&&(contBotao2 > 5))//se o botao estiver pressionado por alguns segundos volta a tela principal
            {
                //  setGain = false;// não deixar dar white balance ao voltar para atela principal
                this->setTelaLed(); // vai para a tela de controle de luminosidade
                return;
              }
            }

             auxBotao2 = botao2;
     }
  }
  if (gpio3.open(QIODevice::ReadOnly)) {         // Abre arquivo
      gpioValue3 = gpio3.readAll();// // Le o arquivo
      gpio3.close();                             // Fecha arquivo

      tecla3 = gpioValue3[0]; // lê se há tecla pressionada

      if(tecla3 == 49)
      {
         botao3 = 0;
         cont3 =0;
         contBotao3 =0;

         if(tela == 1) // se a tela for (principal)
         {
            if((auxBotao3 != botao3)&&(setFoto == false)) // // se o botao antes estava apertado e agora está solto
            {
                 if((tela == 1) &&(setGain == true))  this->setEnhance();//this->setGanho(); // se estiver na tela principal o primeiro botão da cabeça tem a função de white balance
             }

         }
        // setGain = true;// não deixar dar white balance ao voltar para atela principal
         setFoto = false;
         auxBotao3 = botao3;  // iguala os botoes
        }else {

         botao3 = 1;
         cont3 ++;
         contBotao3 ++;

         // qDebug("clicked");

          if(tela == 2)this-> setLuminousMenos();//this-> changeLuminousMais();  // aumenta a luminosidade do led

          else if(tela == 1)
          {
            if((contBotao3 >= 3)&&(setFoto == false))
            {
               // emit foto();
                //setFoto = true;
            }
          }
          auxBotao3 = botao3;
      }
  }
  });

}
//destrutor da classe Gpio
GPIO::~GPIO()
{
   timerBotao.stop();
    qDebug() << Q_FUNC_INFO;
}
// libera  todos os pinos de i/o para uso
void GPIO::gpioExport()
{
    QFile gpioExportFile("/sys/class/gpio/export");
    if(!gpioExportFile.open(QIODevice::Append)){}
}
//define este pino como saida no caso sinal do botão
void GPIO::setDirectionGpioLedBotao()
{
    QFile gpiosetDirectionFile("/sys/class/gpio/keypad_pin4/direction");
    if(!gpiosetDirectionFile.open(QIODevice::Append))
    {
      return;
    }
    gpiosetDirectionFile.write("out");
    gpiosetDirectionFile.close();
}
//define este pino como entrada
void GPIO::setDirectionGpioBotao1()
{
    QFile gpiosetDirectionFile("/sys/class/gpio/keypad_pin6/direction");
    if(!gpiosetDirectionFile.open(QIODevice::Append))
    {
        return;
    }
    gpiosetDirectionFile.write("in");
    gpiosetDirectionFile.close();

}
//define este pino como entrada
void GPIO::setDirectionGpioBotao2()
{
    QFile gpiosetDirectionFile("/sys/class/gpio/keypad_pin8/direction");
    if(!gpiosetDirectionFile.open(QIODevice::Append))
    {
      return;
    }
    gpiosetDirectionFile.write("in");
    gpiosetDirectionFile.close();
}
//define este pino como entrada
void GPIO::setDirectionGpioBotao3()
{
    QFile gpiosetDirectionFile("/sys/class/gpio/keypad_pin7/direction");
    if(!gpiosetDirectionFile.open(QIODevice::Append))
    {
      return;
    }
    gpiosetDirectionFile.write("in");
    gpiosetDirectionFile.close();
}
//define a direção do pino que ligará ikegami
void GPIO::setDirectionGpioIke()
{
    QFile gpiosetDirectionFile("/sys/class/gpio/keypad_pin3/direction");
    if(!gpiosetDirectionFile.open(QIODevice::Append))
    {
        return;
    }
    gpiosetDirectionFile.write("out");
    gpiosetDirectionFile.close();
}
// aciona o rele que ligará a ikegami
void GPIO::PutValPin3(int out)
{
    QFile gpioSetValue("/sys/class/gpio/keypad_pin3/value");
    if(!gpioSetValue.open(QIODevice::Append))
    {
        return;
    }
    if(out == 0)gpioSetValue.write("0");
    else gpioSetValue.write("1");
    gpioSetValue.close();
}
// aciona o pino do botão liga desl
void GPIO::PutvalPin4(int out)
{
    QFile gpioSetValue("/sys/class/gpio/keypad_pin4/value");
    if(!gpioSetValue.open(QIODevice::Append))
    {
      return;
    }
    if(out == 0)gpioSetValue.write("0");
    else gpioSetValue.write("1");
    gpioSetValue.close();
}
//notifica o software que mudou de tela somente usado nas telas de controle de led e camera
void GPIO::setTela(int screen)
{
    tela = screen;
}
//notifica o qml para aumentar a luminosidade do led
void GPIO::setLuminousMais()
{
    emit changeLuminousMais();
}
//notifica o qml para dar whiteBalance
void GPIO::setWiteBalnce()
{
    emit changeWhiteBalance();
}
//notifica o qml para dar enhancement
void GPIO::setEnhance()
{
    emit changeEnhance();
}
//notifica o qml para dar ganho
void GPIO::setGanho()
{
    emit changeGanho();
}
//notifica o qml para mudar para a tela de controle de led
void GPIO::setTelaLed()
{
    emit changeTelaLed();
}
//notifica o qml para mudar para a tela de controle da câmera
void GPIO::setTelaPrincipal()
{
    emit changeTelaPrincipal();
}
//notifica o qml para diminuir a luminosidade do led
void GPIO::setLuminousMenos()
{
    emit changeLuminousMenos();
}
