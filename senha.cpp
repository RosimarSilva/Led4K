#include "senha.h"

Senha::Senha(QObject *parent): QObject(parent)
{
    teste = new Controle();
     //connect(this,&senha::setscreenConfig,this,&senha::screenConfig);

    // connect(this,&senha::setscreenMenu,this,&senha::screenMenu);

    qDebug() << Q_FUNC_INFO;
}
//destrutor da classe
Senha::~Senha()
{
    delete teste;
qDebug() << Q_FUNC_INFO;
}
//recebe o número digitado e faz o cálculo da senha
void Senha::setSenha(int number)
{

    switch (number)
    {
       case 1:
       {
            if(contSenha <= 3)
            {
                auxSenha = number;
                senhaDig = senhaDig*10;
                senhaDig = senhaDig += auxSenha;
                contSenha ++;
             }

       } break;

       case 2:
      {
        if(contSenha <= 3)
        {
            auxSenha = number;
            senhaDig = senhaDig*10;
            senhaDig = senhaDig += auxSenha;
             contSenha ++;
        }
      } break;

       case 3:
     {
        if(contSenha <= 3)
        {
            auxSenha = number;
            senhaDig = senhaDig*10;
            senhaDig = senhaDig += auxSenha;
            contSenha ++;
        }
      } break;

      case 4:
      {
        if(contSenha <= 3)
        {
            auxSenha = number;
            senhaDig = senhaDig*10;
            senhaDig = senhaDig += auxSenha;
            contSenha ++;
        }
      } break;

      case 5:
     {
        if(contSenha <= 3)
        {
            auxSenha = number;
            senhaDig = senhaDig*10;
            senhaDig = senhaDig += auxSenha;
            contSenha ++;
          }
     } break;

     case 6:
     {
        if(contSenha <= 3)
        {
            auxSenha = number;
            senhaDig = senhaDig*10;
            senhaDig = senhaDig += auxSenha;
            contSenha ++;
       }
      } break;

      case 7:
      {
        if(contSenha <= 3)
        {
            auxSenha = number;
            senhaDig = senhaDig*10;
            senhaDig = senhaDig += auxSenha;
            contSenha ++;
        }
      } break;

      case 8:
      {
        if(contSenha <= 3)
        {
           auxSenha = number;
           senhaDig = senhaDig*10;
           senhaDig = senhaDig += auxSenha;
           contSenha ++;
        }
      } break;

      case 9:
      {
        if(contSenha <= 3)
        {
            auxSenha = number;
            senhaDig = senhaDig*10;
            senhaDig = senhaDig += auxSenha;
             contSenha ++;
        }
      } break;

      case 0:
      {
        if(contSenha <= 3)
        {
            auxSenha = number;
            senhaDig = senhaDig += auxSenha;
           if(contSenha<=2)  senhaDig = senhaDig*10;
          contSenha ++;
        }
      } break;
      case 100:
      {

        qDebug("mode changed"); qDebug()<<modeConfig;
        if(modeConfig == true)
        {
            if(senhaDig == senhaConfig) // se a senha bate vai para tela de configuração
             {
                this->setscreenConfig();

             }
            else {
              this->setscreenMenu();  //se não volta para atela de menu
            }
        }

        if(modeConfig == false)
        {
            if(senhaDig == senhaNumberSerie)
             {
                 emit screenNumberSerie(); // vai para a tela de digitação de serie do equipamento
             }
            else {
              this->setscreenMenu(); //se não volta para atela de menu
            }
        }
        contSenha = 0;
        senhaDig = 0;


      } break;

      case 99:
      {
         if(contSenha == 4) {senhaDig = senhaDig - auxSenha; senhaDig = senhaDig/10;}

         else if(contSenha == 3)senhaDig = senhaDig/10;

           else if(contSenha == 2) senhaDig = senhaDig/10;

         else if(contSenha == 1)senhaDig = senhaDig/10;

         else if(contSenha == 0) senhaDig = 0;


          if(senhaDig <= 0)senhaDig = 0;
           contSenha --;
          if(contSenha < 0) contSenha = 0;
      } break;
    }

    qDebug()<<senhaDig;

}
//recebe os números digitados para definir o número de série
void Senha::setserialNumber(int number,int tecla)
{
    int aux = 0,aux_aux = 0;
    if(tecla != 99)contSerial ++;

    else if(tecla == 99)contSerial --;

    switch (contSerial)
    {
       case 1:
       {
        serialNumber = number;
        setserial(serialNumber);
        serialNumber = serialNumber*10;

       } break;

       case 2:
      {
        serialNumber += number;
        setserial(serialNumber);
        serialNumber = serialNumber*10;

      } break;

       case 3:
     {
        serialNumber += number;
        setserial(serialNumber);
        serialNumber = serialNumber*10;

      } break;

      case 4:
      {
        serialNumber += number;
        setserial(serialNumber);
        serialNumber = serialNumber*10;
      } break;

      case 5:
     {
        serialNumber += number;
        setserial(serialNumber);
        serialNumber = serialNumber*10;
     } break;

     case 6:
     {
        serialNumber += number;
        setserial(serialNumber);

     } break;
   }


    if(tecla == 100)
    {
        auxSenha_ = serialNumber;

        auxEsq = auxSenha_/1000;
        auxDir = auxSenha_%1000;

        emit screenMenu();
    }
    else if(tecla == 99)
    {
       serialNumber = 0;
       contSerial = 0;
       setserial(serialNumber);
    }

}
/*como para digitar senha de configuração e senha para alterar o número de série
 * usa-se a mesma rotina no software, esta rotina define se o usuário quer entrar
 * na configuração ou digitar o número de série*/
void Senha::setConfig(bool confs)
{
   if(confs) modeConfig = true;

   else modeConfig = false;

    qDebug("mode changed"); qDebug()<<modeConfig;

}
//escreve horas da lâmpada
void Senha::writeHoras(int number, int tecla)
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
//manda trocar para a tela de configuração
void Senha::setscreenConfig()
{
    emit screenConfig();
}
//manda voltar para tela de menu
void Senha::setscreenMenu()
{
    emit screenMenu();
}
//envia para o qml o numero digitado
void Senha::setserial(const int value)
{
    if(m_serial!= value)
    {
        m_serial = value;
        emit changedSerial();
    }
}
//retorna o ultimo número digitado quando solicitado
unsigned int Senha::serial() const
{
    return m_serial;
}

void Senha::setHorasLamp(const int value)
{
    horasLamp = value;
    emit horasLampChanged();
}

int Senha::horas() const
{
     return horasLamp;
}
