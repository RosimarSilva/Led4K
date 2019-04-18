#ifndef SENHA_H
#define SENHA_H

#include <QObject>
#include <QDebug>
#include <controle.h>

class Senha :public QObject
{
    Q_OBJECT
     Q_PROPERTY(long serial READ serial WRITE setserial NOTIFY changedSerial);

public:
    explicit Senha(QObject* parent = nullptr);
    ~Senha();

    Q_INVOKABLE void setSenha(int number);
    Q_INVOKABLE void setserialNumber(int number,int tecla);
    Q_INVOKABLE void setConfig(bool confs);

    void setscreenConfig(void);
     void setscreenMenu(void);


    void setserial(const int value);
    unsigned int serial() const;

signals:
   void screenConfig(void);
   void screenMenu(void);
   void screenNumberSerie(void);

   void changedSerial();

private:
    int senhaDig = 0;
    int senhaConfig = 5519;
    int  senhaNumberSerie = 7747;
    int contSenha=0,auxSenha=0,contSerial=0;
    int auxEsq,auxDir;
    unsigned int m_serial = 0,serialNumber = 0;
    int auxSenha_;
    bool modeConfig;
    Controle *teste;
};


#endif // SENHA_H
