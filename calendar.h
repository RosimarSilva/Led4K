#ifndef CALENDAR_H
#define CALENDAR_H


#include <QObject>
#include <QTimer>
#include <QDateTime>
#include <QDebug>

class Calendar:public QObject
{
    Q_OBJECT
    Q_PROPERTY(int mes READ mes WRITE setMes NOTIFY changedMes)
    Q_PROPERTY(int ano READ ano WRITE setAno NOTIFY changedAno)
    Q_PROPERTY(int dia READ dia WRITE setDia NOTIFY changedDia)
    Q_PROPERTY(int hora READ hora WRITE setHora NOTIFY changedHora)
    Q_PROPERTY(int minuto READ minuto WRITE setMinuto NOTIFY changeMinuto)

public:
   explicit Calendar(QObject* parent = nullptr);
    ~Calendar();

    Q_INVOKABLE void setHoras(const int value);

    void setDia(const int value);
    int dia() const;
    void setMes(const int value);
    int mes() const;
    void setAno(const int value);
    int ano() const;

    void setMinuto(const int value);
    int minuto() const;
    void setHora(const int value);
    int hora() const;

signals:
    void changedDia();
    void changedMes();
    void changedAno();
    void changedHora();
    void changeMinuto();


public slots:
    void showTime(void);
   void showData(void);

private:
     QTimer *timer;
     QTimer *t;
     int m_dia,m_mes,m_ano,m_hora,m_minuto;
};

#endif // CALENDAR_H
