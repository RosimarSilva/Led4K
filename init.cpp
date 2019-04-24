#include "init.h"

Init::Init(QObject *parent) :
    QObject(parent)
{
    tempo = new QTimer();
    connect(tempo,SIGNAL(timeout()),this,SLOT(inicializa()));
    tempo->start(1000);

   qDebug() << Q_FUNC_INFO;
}
//destrutor da classe
Init::~Init()
{
    delete tempo;
    qDebug() << Q_FUNC_INFO;
}
//rotina que enviará para o qml emitir comandos de inicialização para os módulos do equipamento
void Init::inicializa()
{
    continit ++;
    if(continit >= 11)  tempo->stop(); // termina a inicialização do equipamento
    emit init();
}
