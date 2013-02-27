// Navigation pane project template
#include "SurfingSADev.hpp"

#include <bb/cascades/Application>

#include <QLocale>
#include <QTranslator>
#include <Qt/qdeclarativedebug.h>

using namespace bb::cascades;

Q_DECL_EXPORT int main(int argc, char **argv)
{
    // this is where the server is started etc
    Application app(argc, argv);

    // localization support
    QTranslator translator;
    QString locale_string = QLocale().name();
    QString filename = QString( "SurfingSADev_%1" ).arg( locale_string );
    if (translator.load(filename, "app/native/qm")) {
        app.installTranslator( &translator );
    }

    // Every application is required to have its own unique UUID. You should
	// keep using the same UUID when you release a new version of your
	// application.
	// You can generate one here: http://www.guidgenerator.com/
    const QUuid uuid(QLatin1String("ae7ab23f-a71f-4492-a21e-ab669b86b5d5"));
    // create the application pane object to init UI etc.
    new SurfingSADev(&app, uuid);

    // we complete the transaction started in the app constructor and start the client event loop here
    return Application::exec();
    // when loop is exited the Application deletes the scene which deletes all its children (per qt rules for children)
}
