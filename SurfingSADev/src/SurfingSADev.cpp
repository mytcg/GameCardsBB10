// Navigation pane project template
#include "SurfingSADev.hpp"

#include <QFile>
#include <QTextStream>

#include <bb/cascades/Application>
#include <bb/cascades/QmlDocument>
#include <bb/cascades/AbstractPane>

using namespace bb::cascades;

SurfingSADev::SurfingSADev(bb::cascades::Application *app)
: QObject(app)
{
    // create scene document from main.qml asset
    // set parent to created document to ensure it exists for the whole application lifetime
    QmlDocument *qml = QmlDocument::create("asset:///main.qml").parent(this);

    // Expose this class to QML so that we can call its functions from there
	qml->setContextProperty("app", this);

    // create root object for the UI
    AbstractPane *root = qml->createRootObject<AbstractPane>();
    // set created root object as a scene
    app->setScene(root);

    //create the functionality classes
    mLogin = new Login(root);
    mAlbum = new Album(root);
    mWeather = new Weather(root);

    //set the functionality classes to the context
    qml->setContextProperty("loginClass", mLogin);
    qml->setContextProperty("albumClass", mAlbum);
    qml->setContextProperty("weatherClass", mWeather);
}

QString SurfingSADev::loggedIn() {
	QFile *file = new QFile("data/userdata.xml");

	if (!file->open(QIODevice::ReadWrite)) {
		qDebug() << "\n Failed to open file";
		return "Error reading file";
	}
	else {
		QTextStream fileStream(file);

		QString str = fileStream.readAll();

		fileStream << "";

		file->close();

		if (str.length() > 0) {
			return "true";
		}
		else {
			return "false";
		}
	}
}
