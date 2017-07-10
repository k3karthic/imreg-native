#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "cppmodel.hpp"
#include <mxnetpredict.hpp>

int main(int argc, char *argv[]) {
  QCoreApplication::setAttribute(Qt::AA_UseDesktopOpenGL);
  QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
  QGuiApplication app(argc, argv);

  MXNetPredict p("model", DevType::cpu, 0);
  CppModel model(p);

  QQmlApplicationEngine engine;
  engine.rootContext()->setContextProperty("CppModel", &model);
  engine.load(QUrl(QLatin1String("qrc:/main.qml")));

  return app.exec();
}
