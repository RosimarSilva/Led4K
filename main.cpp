#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "init.h"
#include "controle.h"
#include "calendar.h"
#include "senha.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);
    qmlRegisterType<Init>("Astus4K",1,0,"Fonte4K");
    qmlRegisterType<Controle>("Astus4K",1,0,"Controle");
     qmlRegisterType<Calendar>("Astus4K",1,0,"Calendario");
     qmlRegisterType<Senha>("Astus4K",1,0,"Password");
    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
