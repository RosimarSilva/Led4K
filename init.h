#ifndef INIT_H
#define INIT_H

#include <QObject>
#include <QDebug>
#include <QTimer>

class Init:public QObject
{
    Q_OBJECT

public:
    Init(QObject* parent = nullptr);
    ~Init();



signals:
    void init(void);

public slots:
     void inicializa(void);

private:
    QTimer *tempo;

    uint8_t continit = 0;

};

#endif // INIT_H
