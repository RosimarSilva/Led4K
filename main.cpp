#include <QGuiApplication>
#include <QQmlApplicationEngine>
//Não pode esquecer de incluir os arquivos hader das classes criadas no projeto
#include "init.h"
#include "controle.h"
#include "calendar.h"
#include "senha.h"
#include "gpio.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);
    qmlRegisterType<Init>("Astus4K",1,0,"Fonte4K");// Faz a ponte entre o QML e a classe Init do c++
    qmlRegisterType<Controle>("Astus4K",1,0,"Controle");// Faz a ponte entre o QML e a classe Controle do c++
    qmlRegisterType<Calendar>("Astus4K",1,0,"Calendario");// Faz a ponte entre o QML e a classe Calendar do c++
    qmlRegisterType<Senha>("Astus4K",1,0,"Password");// Faz a ponte entre o QML e a classe Senha do c++
    qmlRegisterType<GPIO>("Astus4K",1,0,"Gpio");// Faz a ponte entre o QML e a classe Gpio do c++
    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
