#include <QtGui/QGuiApplication>
#include <QQuickView>
#include <QQmlEngine>

#include "plugins.h"
int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    Plugins plugin;
    plugin.registerTypes("Bacon2D");

    Q_INIT_RESOURCE(resources);

    QQuickView* m_view = new QQuickView();
    m_view->setResizeMode(QQuickView::SizeRootObjectToView);
    m_view->setTitle("PathWind");
#if defined(Q_OS_LINUX)
    m_view->setSource(QUrl("qrc:/ubuntu.qml"));
#else
    m_view->setSource(QUrl("qrc:/main.qml"));
#endif
    m_view->showFullScreen();
    return app.exec();
}
