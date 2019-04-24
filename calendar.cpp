#include "calendar.h"

Calendar::Calendar(QObject *parent): QObject(parent)
{
   timer = new QTimer(this);
   t = new QTimer(this);

   setHoras(0);

   showTime();

   connect(timer,SIGNAL(timeout()),this, SLOT(showTime()));
  // connect(t,SIGNAL(timeout()),this, SLOT(showData()));

   timer->start(60000);
 // t->start(1000);

   qDebug() << Q_FUNC_INFO;
}
//destrutor da classe
Calendar::~Calendar()
{
    delete timer;
    delete t;

    qDebug() << Q_FUNC_INFO;
}
//seta horas do sistema
void Calendar::setHoras(const int value)
{
    bool ok = false;
    bool data = false;

    QTime setTime;
    QDate setDate;

     ok = setTime.setHMS(13,12,0);
     data = setDate.setDate(2019,5,25);
      qDebug()<<ok;
        qDebug()<<data;

}
//muda set da hora
void Calendar::setDia(const int value)
{
   if(m_dia != value)
   {
       m_dia = value;
       emit changedDia();
   }
}
//Muda set do dia
int Calendar::dia() const
{
    return m_dia;
}
//Muda set do mes
void Calendar::setMes(const int value)
{
    if(m_mes != value)
    {
        m_mes = value;
        emit changedMes();
    }
}
//Muda o set do mês
int Calendar::mes() const
{
    return m_mes;
}
//Muda o set do ano
void Calendar::setAno(const int value)
{
    if(m_ano != value)
    {
        m_ano = value;
        emit changedAno();
    }
}
//Retorna o ano variável
int Calendar::ano() const
{
    return m_ano;
}
//seta o set do minuto
void Calendar::setMinuto(const int value)
{
    if(m_minuto != value)
    {
        m_minuto = value;
        emit changeMinuto();
    }
}
//retorna o miniuto
int Calendar::minuto() const
{
   return m_minuto;
}
//seta a hora
void Calendar::setHora(const int value)
{
    if(m_hora != value)
    {
        m_hora = value;
        emit changedHora();
    }
}
//retorna a hora
int Calendar::hora() const
{
   return m_hora;
}
//Atualiza a hora no display a cada minuto
void Calendar::showTime()
{
     int ano;

    QTime time = QTime::currentTime();

    QDate date = QDate::currentDate();

    this->setDia(date.day());
    this->setMes(date.month());

    this->setHora(time.hour());
    this->setMinuto(time.minute());

    ano = date.year()-2000;

    this->setAno(ano);
}
// Atualiza a data no display a cada minuto
void Calendar::showData()
{
    int ano;
      QDate date = QDate::currentDate();

      ano = date.year()-2000;

     this->setDia(date.day());
     this->setMes(date.month());
     this->setAno(ano);

    qDebug()<<date.day()<<date.month()<<date.year();
}

