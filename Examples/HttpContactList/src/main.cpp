// Default empty project template
#include <bb/cascades/Application>
#include <bb/cascades/QmlDocument>
#include <bb/cascades/AbstractPane>

#include <QLocale>
#include <QTranslator>
#include <Qt/qdeclarativedebug.h>

#include "HttpContactList.hpp"
#include "objects/Employee.h"

using namespace bb::cascades;

Q_DECL_EXPORT int main(int argc, char **argv)
{
	qmlRegisterType<Employee>("myLibrary", 1, 0, "Employee");

    // this is where the server is started etc
    Application app(argc, argv);

    // localization support
    QTranslator translator;
    QString locale_string = QLocale().name();
    QString filename = QString( "HttpContactList_%1" ).arg( locale_string );
    if (translator.load(filename, "app/native/qm")) {
        app.installTranslator( &translator );
    }

    new HttpContactList(&app);

    // we complete the transaction started in the app constructor and start the client event loop here
    return Application::exec();
    // when loop is exited the Application deletes the scene which deletes all its children (per qt rules for children)
}
