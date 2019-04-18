 #include "controle.h"

Controle::Controle(QObject *parent) :
    QObject(parent)
{
     qDebug() << Q_FUNC_INFO;
    piscWhite = new QTimer();
    port = new QSerialPort();
    out_ = new QByteArray();
    timeHoras = new QTimer();
    timerBotao = new QTimer();

    // inicaliza a serial
     serialInit();
   //gera um sinal e o envia para o c++ piscra a figura do white balance
    connect(piscWhite,SIGNAL(timeout()),this,SLOT(whiteBalance()));
    piscWhite->start(800);

    //enquant led estiver ligado a contagem de horas também estará
    connect(timeHoras,SIGNAL(timeout()),this,SLOT(contHoras()));
    timeHoras->start(60000);
}
//destrutor
Controle::~Controle()
{
    delete piscWhite;
    delete port;
    delete out_;
    delete timeHoras;
    delete timerBotao;

    qDebug() << Q_FUNC_INFO;
}
//seta variaveis de inicialização
void Controle::setInit()
{
    init = true;
}
//recebe do Qml o user correspondente e faz a troca do mesmo
void Controle::setUser(int users)
{
    user = users;
    setComandoIke(7); // comando responsável por trocar user da câmera

    if(user == 1)emit user1();
    else if(user == 2)emit user2();
    else if(user == 3)emit user3();
    else emit user4();
    qDebug()<<user;
}
//requisita o sinal de intensidade para o Led
void Controle::luminousLed(char sinal)
{
    switch(sinal)
    {
        case 1:
        {
          intensidade -= 10;
          if(intensidade <= 0) intensidade = 0;
          luminous = intensityLed(intensidade);
          this->setIntensity(luminous);

        }break;

        case 2:
        {
            intensidade += 10;
            if(intensidade >= 100) intensidade = 100;
            luminous = intensityLed(intensidade);
            this->setIntensity(luminous);

        }break;
    }
}
//controla a rotação do ventilador do módulo led
void Controle::setDutyFan(uint16_t duty)
{
    bool read = false;
    bool Led = false;

    crc16_reset();

    ledEnv[0] = crc16_input(0xA5);   ledEnv[1] = crc16_input(0x07); ledEnv[2] = crc16_input(0x09);

    ledEnv[3] = crc16_input(duty);ledEnv[4] = crc16_input(0x00);

     crc.w = crc16_output();

     ledEnv[5] = crc.b[1];   ledEnv[6] = crc.b[0];

     size = 6; read = false; comando = 0;

     this->sendFrame(size,read,Led);//tamanho do frame,escreita e leitura na serial,equipamento que receberá o frame
}
//coloca o led em modo standBy
void Controle::standBy(bool enable)
{
    if(!enable)
    {
        luminous = intensityLed(intensidade);
        this->setIntensity(luminous);
    }else {
        luminous = intensityLed(0);
        this->setIntensity(luminous);
    }
}
//reseta horas da lâmpada
void Controle::resetHorasLamp()
{
    qDebug("resetado");
    horasLamp = 0;
    minutosLamp = 0;
    this->setHorasLamp(horasLamp);
}
//escreve horas de vida útil da lâmpada
void Controle::writeHoras(int number, int tecla)
{
    if(tecla != 99)contHours ++;

    else if(tecla == 99)contHours --;

    if(tecla == 100)contHours = 10;

    switch (contHours)
    {
       case 1:
       {
        horasLamp = number;
        this->setHorasLamp(horasLamp);

       } break;

       case 2:
      {
        horasLamp = horasLamp*10;
        horasLamp += number;
        this->setHorasLamp(horasLamp);


      } break;

       case 3:
     {
         horasLamp = horasLamp*10;
        horasLamp += number;
        this->setHorasLamp(horasLamp);


      } break;

      case 4:
      {
         horasLamp = horasLamp*10;
          horasLamp += number;
        this->setHorasLamp(horasLamp);

      } break;

      case 5:
     {
        horasLamp = horasLamp*10;
         horasLamp += number;
        this->setHorasLamp(horasLamp);

     } break;

     case 6:
     {
        horasLamp = horasLamp*10;
         horasLamp += number;
       this->setHorasLamp(horasLamp);

     } break;
   }


    if(tecla == 100)
    {
       emit backConfig();
        contHours = 0;
    }
    else if(tecla == 99)
    {
       horasLamp = 0;
       minutosLamp = 0;
       contHours = 0;
    }
    qDebug()<<horasLamp;
}
//faz o teste do Led para ver se está funcionando
void Controle::testeLed(const int sinal)
{
    switch(sinal)
    {
        case 1:
        {
             lumin -= 10;
             if(lumin <= 0) lumin = 0;
             luminous = intensityLed(lumin);
             this->setIntensity(luminous);

        }break;

        case 2:
        {
          lumin += 10;
          if(lumin >= 100) lumin = 100;
          luminous = intensityLed(lumin);
          this->setIntensity(luminous);

        }break;
    }
}
// na hora do teste do led este para com o teste
void Controle::stopTest()
{
    lumin = 0;
}
/*esta rotina tem a função de enviar para uma determinada tela
    onde ha pontos de toque na tela, se por ventura essa tela que não seja a tela principal
    dispara um tempo se nesse intervalo de tempo defido não haver toque na tela
    o programa retorna para a tela principal
*/
void Controle::changeTela(int tela)
{
    if(tela == 2)emit tela2();//tela Led
    else if(tela == 3) emit tela3();//tela users
    else if(tela == 4) emit tela4();//tela menu
    else if(tela == 5)emit tela5();//tela calendario
    else if(tela == 6){emit tela6();} //tela serial number
}

//envia um sinal para o QML piscar a figura do WhiteBalance
void Controle::whiteBalance()
{
    emit whitePisc();
}
//faz a contagem de horas e quando a hora muda envia para o QML e atualizar
void Controle::contHoras()
{
    if(luminous)
    {
        minutosLamp ++;
        if(minutosLamp >= 60)
        {
            horasLamp ++;
            minutosLamp = 0;
            this->setHorasLamp(horasLamp);
        }
    }
}
//configura a serial a ser usada
bool Controle::openSerial(const QString &name, bool readWrite)
{
    open = 0;
    if(readWrite == true)
     {
          port->close();
          port->setPortName(name);
          open = port->open(QIODevice::ReadWrite);
          if(open)qDebug("abriu");
          else qDebug("nao abriu");
     }
     else {
         port->close();
         port->setPortName(name);
         open = port->open(QIODevice::WriteOnly);
     }

    return open;
}
//inicializa a serial
bool Controle::serialInit()
{
    if(openSerial("ttymxc0",true))
    {
         port->setBaudRate(QSerialPort::Baud19200);
         port->setDataBits(QSerialPort::Data8);
         port->setParity(QSerialPort::NoParity);
         port->setStopBits(QSerialPort::OneStop);
         port->setFlowControl(QSerialPort::NoFlowControl);
    }
    else qDebug("nao configurado");
    return 0;
}
//faz calculo do bcc do frame a ser enviado para a ikegami
int Controle::bcc(uint8_t size)
{
    int i,aux;
    i = 1;
    aux = ikeenv[i];
   // size = 6;
    for(i = 2; i< size;i++)  // faz o cálculo do bcc
    {
        aux = aux ^ ikeenv[i];
    }
    return aux;
}
//calcula o tamanho do frame e o envia
void Controle::sendFrame(int size,bool port, bool equipment)
{
    if(openSerial("ttymxc0",port))
    {
        if(equipment)//se for ikegami
        {
             for(int i = 0;i<=size;i++)
             {
                  this->writeBytes({ikeenv[i]},comando);
             }
        }
        else {//se for para o modo do led
             for(int i = 0;i<=size;i++)
             {
                  this->writeBytes({ledEnv[i]},comando);
             }
        }
    }
}
//verifica o comando requisitado pelo software
void Controle::setComandoLed(const int cmd)
{
    bool read = false;
    bool Led = false;

     crc16_reset();
     switch (cmd)
     {
         case ENABLE_LED://HABILTA O MÓDULO DE LED
         {
             ledEnv[0] = crc16_input(0xA5);   ledEnv[1] = crc16_input(0x06); ledEnv[2] = crc16_input(0x0A); ledEnv[3] = crc16_input(0x00);

              crc.w = crc16_output();

              ledEnv[4] = crc.b[1];   ledEnv[5] = crc.b[0];

              size = 5; read = false; comando = 0;
         }break;

         case DISABLE_LED://DISABILITA O MÓDULO DE LED
         {
            ledEnv[0] = crc16_input(0xA5);   ledEnv[1] = crc16_input(0x05); ledEnv[2] = crc16_input(0x01); ledEnv[3] = crc16_input(0x01);

            crc.w = crc16_output();

            ledEnv[4] = crc.b[1];   ledEnv[5] = crc.b[0];

            size = 5; read = false; comando = 0;
         }break;

         case READ_TEMPERATURE://FAZ A LEITURA DA TEMPERATUA
         {
            ledEnv[0] = crc16_input(0xA5);   ledEnv[1] = crc16_input(0x05); ledEnv[2] = crc16_input(0x03);

             crc.w = crc16_output();

             ledEnv[3] = crc.b[1];   ledEnv[4] = crc.b[0];

             size = 4; read = false; comando = 0; //precisa definir qual o número do comando a receber
          }break;

         case READ_PARAMETERS: //LÊ PARÂMETROS SOBRE O MÓDULO
         {
            ledEnv[0] = crc16_input(0xA5);   ledEnv[1] = crc16_input(0x05); ledEnv[2] = crc16_input(0x01);

            crc.w = crc16_output();

            ledEnv[3] = crc.b[1];   ledEnv[4] = crc.b[0];

            size = 4; read = false;  comando = 0;
         }break;

         case ENABLE_FIBER_SENSE://HABILITA O SENSOR DE CABO DE FIBRA
         {
            ledEnv[0] = crc16_input(0xA5);   ledEnv[1] = crc16_input(0x06); ledEnv[2] = crc16_input(0x0C); ledEnv[3] = crc16_input(0x01);

            crc.w = crc16_output();

            ledEnv[4] = crc.b[1];   ledEnv[5] = crc.b[0];

            size = 5; read = false;  comando = 0;
         }break;

          case DISABLE_FIBER_SENSE://DESABILITA O SENSOR DE CABO DE FIBRA
          {
             ledEnv[0] = crc16_input(0xA5);   ledEnv[1] = crc16_input(0x06); ledEnv[2] = crc16_input(0x0C); ledEnv[3] = crc16_input(0x00);

             crc.w = crc16_output();

             ledEnv[4] = crc.b[1];   ledEnv[5] = crc.b[0];

             size = 5; read = false; comando = 0;
          }break;

     }

      this->sendFrame(size,read,Led);//tamanho do frame,escreita e leitura na serial,equipamento que receberá o frame

}
//Rotina que retorna o crc16
uint16_t Controle::crc16_output()
{
    return (uchCRCHi << 8 | uchCRCLo);
}
//reseta as variáveis para calcular o crc16
void Controle::crc16_reset()
{
    uchCRCHi = 0xFF;
    uchCRCLo = 0xFF;
}
//recebe cada byte do frame para calcular o crc16
uint8_t Controle::crc16_input(uint8_t byte_val)
{
    unsigned uIndex = uchCRCLo ^ byte_val;
    uchCRCLo = uchCRCHi ^ crcHigh[uIndex];
    uchCRCHi = crcLow[uIndex];
    return byte_val;
}
//atualiza horas da lampada se precisar
void Controle::setHorasLamp(const int value)
{
    horasLamp = value;
    emit horasLampChanged();
}
//retorna o número de horas
int Controle::horas() const
{
    return horasLamp;
}
//calcula a porcentagem de luminosidade do Led
char Controle::calculateByte(uint16_t value, char operador)
{
    int numerador,valor;

      numerador = value;

     if(operador == '/')
     {
         valor = (numerador / 256);
     }
     else {
         valor = (numerador % 256);
     }

     return ((char)valor);
}
//envia intensidade para o led
void Controle::setIntensity(const int intensity)
{
    bool read = false;
    bool Led = false;

   crc16_reset();

   ledEnv[0] = crc16_input(0xA5);   ledEnv[1] = crc16_input(0x07); ledEnv[2] = crc16_input(0x06);

   ledEnv[3] = crc16_input((uint8_t)calculateByte(intensity,'%'));ledEnv[4] = crc16_input((uint8_t)calculateByte(intensity,'/'));

    crc.w = crc16_output();

    ledEnv[5] = crc.b[1];   ledEnv[6] = crc.b[0];

    size = 6; read = false; comando = 0;

    this->sendFrame(size,read,Led);//tamanho do frame,escreita e leitura na serial,equipamento que receberá o frame
}
//verifica a porcentagem e converte em nùmero decimal de
// o a 1023 para enviar certo para o led
uint16_t Controle::intensityLed(int luz)
{
    if(luz >= 100) luz = 100;
    else if(luz <= 0) luz = 0;

    switch(luz)
    {
         case 0: luz = 0; break;
         case 10: luz = 100; break;
         case 20: luz = 200; break;
         case 30: luz = 300; break;
         case 40: luz = 400; break;
         case 50: luz = 500; break;
         case 60: luz = 600; break;
         case 70: luz = 700; break;
         case 80: luz = 800; break;
         case 90: luz = 900; break;
         case 100: luz = 1023; break;
    }

    return ((uint16_t) luz);
}
//envia o frame para a ikegami byte a byte
void Controle::writeBytes(const QList<int> &l, const uint8_t resp)
{
    if (open){
       if (!l.size()) return;

       out_->resize(l.size());
       for (int i=0; i<l.size(); i++) out_->data()[i] = l[i];
   }

   port->write(*out_) > 0;

   resposta = resp;
   port->clearError();
}
//envia o comando requisitado para a ikegami
void Controle::setComandoIke(int comando)
{
    int tamanho,aux_enh,auxVideo;
    bool ikegami = true;
    bool readWrite = false;

     ikeenv[0] = 0x7A;ikeenv[1] = 0x13;ikeenv[2] = 0x00;
    switch(comando)
    {
         case 1://white balance
         {
              ikeenv[3] = 0x04; ikeenv[4] = 0x19; ikeenv[5] = 0x09; ikeenv[6] = 0x00;// comando[7] = 0x07;

              ikeenv[7] = bcc(6);

              tamanho = 7; comando = 1;

              readWrite = true;//se for FALSE significa que não necessita da resposta, caso contrario se for TRUE precisa da resposta
         }break;

         case 2:  // chama o user Menu
         {
             ikeenv[3] = 0x07;ikeenv[4] = 0x14;

             ikeenv[5] = 0x81;ikeenv[6] = 0x67; ikeenv[7] = 0x10;ikeenv[8] = 0x80;ikeenv[9] = 0x00;

             ikeenv[10] = bcc(9);

             comando = 1; tamanho = 10; // tamanho do frame

             readWrite = false;//se for FALSE significa que não necessita da resposta, caso contrario se for TRUE precisa da resposta
         }break;

         case 3:  // sai fora do user Menu
         {
             ikeenv[3] = 0x07;ikeenv[4] = 0x14;

             ikeenv[5] = 0x81;ikeenv[6] = 0x67; ikeenv[7] = 0x90;ikeenv[8] = 0x80;ikeenv[9] = 0x00;

             ikeenv[10] = bcc(9);

             tamanho = 10; comando = 0;

             readWrite = false;//se for FALSE significa que não necessita da resposta, caso contrario se for TRUE precisa da resposta

         }break;

         case 4:  // CHAMA O ZOOM
         {
           if(init )
           {
                switch(zoom)
                {
                    case 16 : zoom = 21;break;
                    case 21: zoom = 26;  break;
                    case 26: zoom = 31; break;
                    case 31: zoom = 16; break;
                }

                  emit changeZoomImage();//emite um sinal para mudar a figura do zoom lá no QML
           }
           else {
               zoom = 16;
           }

            ikeenv[3] = 0x07;ikeenv[4] = 0x14;

            ikeenv[5] = 0x8F;ikeenv[6] = 0x6F; ikeenv[7] = zoom;ikeenv[8] = 0x80;ikeenv[9] = 0x00;

            ikeenv[10] = bcc(9);

            tamanho = 10;  comando = 0;

            readWrite = false;//se for FALSE significa que não necessita da resposta, caso contrario se for TRUE precisa da resposta

           }break;

        case 5:  // manda o enhancement para a ikegami
        {
            //if(habilitEnhGain == true){
        if(init)
        {
            if(user != 3)
            {
                emit changeEnhancementImage();

                if(enhancement == enhancementHigh)
                {
                    enhancement = enhancementMed;
                     // qDebug() << enhancement;
                }

                else if(enhancement == enhancementLow) {
                    enhancement = enhancementHigh;
                         // qDebug() << enhancement;
                 }

               else if(enhancement == enhancementMed)
               {
                     enhancement = enhancementLow;
                     // qDebug() << enhancement;
                }
            }
               else {
                 enhancement = 0;
                 emit changedEnhancementOff();
             }
      }
             ikeenv[3] = 0x06;ikeenv[4] = 0x1D;ikeenv[5] = 0x7D;

             ikeenv[8] = 0x00;

             aux_enh = enhancement*16; //multiplica por 16 para mandar para a ikegami

             if(aux_enh < 0) aux_enh = 0xFFFF + aux_enh +1; // calcula o complemento de 1

             ikeenv[6] = aux_enh/256 ;ikeenv[7] = aux_enh%256;

             ikeenv[9] = bcc(8);

             tamanho = 9;  comando = 0;

             readWrite = false;//se for FALSE significa que não necessita da resposta, caso contrario se for TRUE precisa da resposta

         }break;

    case 6:// manda o ganho para a ikegami
    {
       // if(habilitEnhGain == true){
        if(init == true)
        {
             if(videoLevel == videoLevelLow)
             {
                  videoLevel = videoLevelHigh;
             }

             else if(videoLevel == videoLevelHigh)
             {
                  videoLevel = videoLevelHigh2;
             }

             else if(videoLevel == videoLevelHigh2)
             {
                  videoLevel = videoLevelLow;
             }
              emit changeGainImage(); // atualiza a figura no display
          }

            ikeenv[3] = 0x0C;ikeenv[4] = 0x1D;ikeenv[5] = 0x8F;ikeenv[6] = 0x8F; ikeenv[7] = 0x8F;

            ikeenv[8] = 0x11; ikeenv[11] = 0x80;ikeenv[12] = 0x80; ikeenv[13] = 0x8F;ikeenv[14] = 0x00;

            auxVideo = videoLevel*32; //multiplica por 32 para mandar para a ikegami

            if(auxVideo < 0) auxVideo = 0xFFFF + auxVideo + 1; // calcula o complemento de 1

            ikeenv[9] = auxVideo/256;     ikeenv[10] = auxVideo%256;

            ikeenv[15] = bcc(14);

            tamanho = 15; comando = 0;

            readWrite = false;//se for FALSE significa que não necessita da resposta, caso contrario se for TRUE precisa da resposta
        }break;

        case 157://troca de user
        {
            ikeenv[3] = 0x05;ikeenv[4] = 0x16;ikeenv[5] = 0x11;

            ikeenv[6] = user + 0x10; ikeenv[7] = 0x00;

            ikeenv[8] = bcc(7);

            tamanho = 8; comando = 0;

            readWrite = false;//se for FALSE significa que não necessita da resposta, caso contrario se for TRUE precisa da resposta
        }break;


    }

    this->sendFrame(tamanho,readWrite,ikegami);//tamanho do frame,escreita e leitura na serial,equipamento que receberá o frame

}
//aqui está as mensagens que serão exibidas no monitor
void Controle::mensagens(int message, int cor)
{
    int tamanho,aux_enh,auxVideo;
    bool readWrite = false;
    bool ikegami = true;

   if(cor == 0) ikeenv[9] = 0x27;
   else if(cor == 1) ikeenv[9] = 0x23;
   else if(cor == 2)ikeenv[9] = 0x22;

   ikeenv[0] = 0x7A;ikeenv[1] = 0x13;ikeenv[2] = 0x00; ikeenv[4] = 0x30;ikeenv[5] = 0x10;ikeenv[8] = 0x11;
   switch(message)
   {
       case 1: // escreve quais users estão na tela
       {

           if((user == 1)||(user == 5)){
                ikeenv[6] = 0x20 + 27; ikeenv[7] = 0x20 + 29;

                 ikeenv[3] = 12+8;

                ikeenv[10] = 'L';ikeenv[11] = 'A';ikeenv[12] = 'P';ikeenv[13] ='A'; ikeenv[14] = 'R';ikeenv[15] ='O';ikeenv[16] = ' ';

                ikeenv[17] = '0';ikeenv[18] = '1';ikeenv[19] = ' ';ikeenv[20] = ' '; ikeenv[21] = ' '; ikeenv[22] = 0x00;ikeenv[23] = bcc(22);

                tamanho = 23; comando = 0;

                readWrite = true;//se for FALSE significa que não necessita da resposta, caso contrario se for TRUE precisa da resposta


           }
          else if((user == 2)||(user == 6)){
                ikeenv[6] = 0x20 + 27; ikeenv[7] = 0x20 + 29;

                 ikeenv[3] = 12+8;

                ikeenv[10] = 'L';ikeenv[11] = 'A';ikeenv[12] = 'P';ikeenv[13] ='A'; ikeenv[14] = 'R';ikeenv[15] ='O';ikeenv[16] = ' ';

                ikeenv[17] = '0';ikeenv[18] = '2'; ikeenv[19] = ' ';ikeenv[20] = ' '; ikeenv[21] = ' '; ikeenv[22] = 0x00;ikeenv[23] = bcc(22);

                tamanho = 23; comando = 0;

           }

         else  if((user == 3)||(user == 7)){
                ikeenv[6] = 0x20 + 27; ikeenv[7] = 0x20 + 29;

                 ikeenv[3] = 12+8;

                ikeenv[10] = 'E';ikeenv[11] = 'N';ikeenv[12] = 'D';ikeenv[13] ='O'; ikeenv[14] = 'F';ikeenv[15] ='L';ikeenv[16] = 'E';

                ikeenv[17] = 'X';ikeenv[18] = 'I';  ikeenv[19] = 'B';ikeenv[20] = 'L'; ikeenv[21] = 'E'; ikeenv[22] = 0x00;ikeenv[23] = bcc(22);

                  tamanho = 23; comando = 0;
           }

         else  if((user == 4)||(user == 8)){
                ikeenv[6] = 0x20 + 27; ikeenv[7] = 0x20 + 29;

                 ikeenv[3] = 12+8;

                ikeenv[10] = 'H';ikeenv[11] = 'Y';ikeenv[12] = 'S';ikeenv[13] ='T'; ikeenv[14] = 'E';ikeenv[15] ='R';ikeenv[16] = 'O';

                ikeenv[17] = '/';ikeenv[18] = 'U';  ikeenv[19] = 'R';ikeenv[20] = 'O'; ikeenv[21] = ' ';ikeenv[22] = 0x00;ikeenv[23] = bcc(22);

                tamanho = 23; comando = 0;

           }

       }break;

        case 101: // apaga a escrita do láparo
        {
           ikeenv[6] = 0x20 + 26; ikeenv[7] = 0x20 + 29;

            ikeenv[3] = 13+8;

            ikeenv[10] = ' ';ikeenv[11] = ' ';ikeenv[12] = ' ';ikeenv[13] =' '; ikeenv[14] = ' ';ikeenv[15] =' ';ikeenv[16] = ' ';

            ikeenv[17] = ' ';ikeenv[18] = ' ';  ikeenv[19] = ' ';ikeenv[20] = ' '; ikeenv[21] = ' ';ikeenv[22] = ' ';ikeenv[23] = 0x00;ikeenv[24] = bcc(23);

           tamanho = 24; comando = 0;


        }break;

       case 5:// escreve enhancemente na tela
       {
           ikeenv[10] = 'E';ikeenv[11] = 'N';ikeenv[12] = 'H';ikeenv[13] ='A'; ikeenv[14] = 'N';ikeenv[15] ='C';ikeenv[16] = 'E';

            ikeenv[17] = 'M';ikeenv[18] = 'E'; ikeenv[19] = 'N';ikeenv[20] = 'T';ikeenv[21] = ' ';
           if(enhancement == enhancementLow)
            {
                   ikeenv[6] = 0x20 + 10; ikeenv[7] = 0x20 + 29;

                   ikeenv[3] = 16+8;

                    ikeenv[22] = 'L';ikeenv[23] = 'O';ikeenv[24] = 'W';ikeenv[25] = ' ';

                    ikeenv[26] = 0x00;ikeenv[27] = bcc(26);

                    tamanho = 27; comando = 0;

            }

            else if(enhancement == enhancementMed)
            {
                   ikeenv[6] = 0x20 + 10; ikeenv[7] = 0x20 + 29;

                   ikeenv[3] = 16+8;

                    ikeenv[22] = 'M';ikeenv[23] = 'E';ikeenv[24] = 'D';ikeenv[25] = ' ';

                    ikeenv[26] = 0x00;ikeenv[27] = bcc(26);

                    tamanho = 27; comando = 0;

            }

             else if(enhancement == enhancementHigh)
            {
                   ikeenv[6] = 0x20 + 10; ikeenv[7] = 0x20 + 29;

                   ikeenv[3] = 16+8;

                    ikeenv[22] = 'H';ikeenv[23] = 'I';ikeenv[24] = 'G';ikeenv[25] = 'H';

                    ikeenv[26] = 0x00;ikeenv[27] = bcc(26);

                     tamanho = 27; comando = 0;
            }

             else if(enhancement == 0)
            {
                   ikeenv[6] = 0x20 + 10; ikeenv[7] = 0x20 + 29;

                   ikeenv[3] = 16+8;

                    ikeenv[22] = 'O';ikeenv[23] = 'F';ikeenv[24] = 'F';ikeenv[25] = ' ';

                    ikeenv[26] = 0x00;ikeenv[27] = bcc(26);

                    tamanho = 27; comando = 0;
            }

       }break;

       case 1000:
       {
            ikeenv[10] = ' ';ikeenv[11] = ' ';ikeenv[12] = ' ';ikeenv[13] =' '; ikeenv[14] = ' ';ikeenv[15] =' ';ikeenv[16] = ' ';

            ikeenv[17] = ' ';ikeenv[18] = ' '; ikeenv[19] = ' ';ikeenv[20] = ' ';ikeenv[21] = ' ';

            ikeenv[6] = 0x20 + 10; ikeenv[7] = 0x20 + 29;

            ikeenv[3] = 16+8;

             ikeenv[22] = ' ';ikeenv[23] = ' ';ikeenv[24] = ' ';ikeenv[25] = ' ';

             ikeenv[26] = 0x00;ikeenv[27] = bcc(26);

              tamanho = 27; comando = 0;

       }break;
       case 12:
        {
           if(videoLevel == videoLevelLow)
           {
                ikeenv[6] = 0x20 + 6; ikeenv[7] = 0x20 + 30;

               ikeenv[3] = 2+8;

               ikeenv[10] = ' ';ikeenv[11] = ' '; ikeenv[12] = 0x00;  ikeenv[13] = bcc(12);

                tamanho = 13;comando = 0;
           }

           if(videoLevel == videoLevelHigh2)
           {
                ikeenv[6] = 0x20 + 6; ikeenv[7] = 0x20 + 30;

               ikeenv[3] = 2+8;

               ikeenv[10] = 'G';ikeenv[11] = 'G'; ikeenv[12] = 0x00;  ikeenv[13] = bcc(12);

               tamanho = 13; comando = 0;
             }

           if(videoLevel == videoLevelHigh)
           {
                ikeenv[6] = 0x20 + 6; ikeenv[7] = 0x20 + 30;

               ikeenv[3] = 2+8;

               ikeenv[10] = 'G';ikeenv[11] = ' '; ikeenv[12] = 0x00;  ikeenv[13] = bcc(12);

               tamanho = 13; comando = 0;
           }
        }break;

         case 80:
         {
            ikeenv[6] = 0x20 + 4; ikeenv[7] = 0x20 + 1;

            ikeenv[3] = 27+8;

            ikeenv[10] = 'V';ikeenv[11] = 'I';ikeenv[12] = 'V';ikeenv[13] ='I'; ikeenv[14] = 'D';ikeenv[15] =' ';ikeenv[16] = 'N';

            ikeenv[17] = 'U';ikeenv[18] = 'V';  ikeenv[19] = 'O';ikeenv[20] = 'T'; ikeenv[21] = 'E'; ikeenv[22] = 'C';

            ikeenv[23] = 'H';ikeenv[24] = ' ';ikeenv[25] = 'E';ikeenv[26] = 'D';ikeenv[27] ='G'; ikeenv[28] = 'E';ikeenv[29] =' ';ikeenv[30] = 'L';

            ikeenv[31] = 'C';ikeenv[32] = ' ';  ikeenv[33] = 'P';ikeenv[34] = 'L'; ikeenv[35] = 'U'; ikeenv[36] = 'S';ikeenv[37] = 0x00;ikeenv[38] = bcc(37);

            tamanho = 38; comando = 0;

          }break;

          case 800:
         {
           ikeenv[6] = 0x20 + 4; ikeenv[7] = 0x20 + 1;

           ikeenv[3] = 27+8;

           ikeenv[10] = ' ';ikeenv[11] = ' ';ikeenv[12] = ' ';ikeenv[13] =' '; ikeenv[14] = ' ';ikeenv[15] =' ';ikeenv[16] = ' ';

           ikeenv[17] = ' ';ikeenv[18] = ' ';  ikeenv[19] = ' ';ikeenv[20] = ' '; ikeenv[21] = ' '; ikeenv[22] = ' ';

           ikeenv[23] = ' ';ikeenv[24] = ' ';ikeenv[25] = ' ';ikeenv[26] = ' ';ikeenv[27] =' '; ikeenv[28] = ' ';ikeenv[29] =' ';ikeenv[30] = ' ';

           ikeenv[31] = ' ';ikeenv[32] = ' ';  ikeenv[33] = ' ';ikeenv[34] = ' '; ikeenv[35] = ' '; ikeenv[36] = ' ';ikeenv[37] = 0x00;ikeenv[38] = bcc(37);

           tamanho = 38;comando = 0;

      }break;

   //envia os dados para a serial
     this->sendFrame(tamanho,readWrite,ikegami);//tamanho do frame,escreita e leitura na serial,equipamento que receberá o frame

}


}




