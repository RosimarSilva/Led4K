#ifndef GPIO_H
#define GPIO_H

#include <QObject>
#include <QObject>
#include <QtSerialPort/QSerialPortInfo>
#include <QString>
#include <QSerialPort>
#include <QIODevice>
#include <QTimer>
#include <QFile>
#include <QProcess>
#include <QDebug>
#include <QFileSystemWatcher>
#include <QTextStream>

class GPIO:public  QObject
{
    Q_OBJECT
public:
    explicit GPIO(QObject* parent = nullptr);
    ~GPIO();


    Q_INVOKABLE void gpioExport(void);
    Q_INVOKABLE void setDirectionGpioIke(void);
     Q_INVOKABLE void setDirectionGpioLedBotao(void);
    Q_INVOKABLE void setDirectionGpioBotao1(void);//--
    Q_INVOKABLE void setDirectionGpioBotao2(void);// ++
    Q_INVOKABLE void setDirectionGpioBotao3(void); //  botao do ganho
    Q_INVOKABLE void PutValPin3(int out); // acionnará a placa da ikegami
    Q_INVOKABLE void PutvalPin4(int out); // acionnará o led do botão liga/desl
    Q_INVOKABLE void setTela(int screen); // para notificar ao software que mudou de tela

    void setLuminousMenos(void);
     void setLuminousMais(void);
     void setWiteBalnce(void);
     void setEnhance(void);
     void setGanho(void);
     void setTelaLed(void);
     void setTelaPrincipal(void);
public slots:

   // void readBotao1(void);//--
    // void readBotao2(void);//++
     // void readBotao3(void);//ganho
signals:
    void changeLuminousMais(void);
     void changeLuminousMenos(void);
     void changeWhiteBalance(void);
     void changeEnhance(void);
     void changeTelaLed(void);
     void changeTelaPrincipal(void);
     void changeGanho(void);

     void foto(void);
     void showPercentLed(void);

private:

    QString  m_path_b1;
    QString  m_path_b2;
     QString  m_path_b3;

   int  m_value_b1;
   int  m_value_b2;
    int  m_value_b3;

    int tecla,tecla2,tecla3;
    int tela;
     QTimer timerBotao;
     int contBotao,auxBotao,cont,contBotao2,auxBotao2,cont2,contBotao3,auxBotao3,cont3;

     bool setLed,setWhite,setGain,changeTelas;
     bool setFoto = true;
};

#endif // GPIO_H
