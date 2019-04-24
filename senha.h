#ifndef SENHA_H
#define SENHA_H

#include <QObject>
#include <QDebug>
#include <controle.h>

class Senha :public QObject
{
    Q_OBJECT
    Q_PROPERTY(long serial READ serial WRITE setserial NOTIFY changedSerial)
    Q_PROPERTY(int horas READ horas WRITE setHorasLamp NOTIFY horasLampChanged)

public:
    explicit Senha(QObject* parent = nullptr);
    ~Senha();

    Q_INVOKABLE void setSenha(int number);
    Q_INVOKABLE void setserialNumber(int number,int tecla);
    Q_INVOKABLE void setConfig(bool confs);
    Q_INVOKABLE void writeHoras(int number,int tecla);

    void setscreenConfig(void);
     void setscreenMenu(void);


    void setserial(const int value);
    unsigned int serial() const;

    void setHorasLamp(const int value);
    int horas(void)const;

signals:
   void screenConfig(void);
   void screenMenu(void);
   void screenNumberSerie(void);

   void changedSerial();

   void horasLampChanged();
   void backConfig();

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
    int horasLamp, minutosLamp,m_horasLamp,contHours,lumin;
    int tecla;
};


#endif // SENHA_H
