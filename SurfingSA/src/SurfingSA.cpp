// Default empty project template
#include "SurfingSA.hpp"

#include <bb/cascades/Application>
#include <bb/cascades/QmlDocument>
#include <bb/cascades/AbstractPane>
#include <bb/cascades/TextField>

using namespace bb::cascades;

SurfingSA::SurfingSA(bb::cascades::Application *app)
: QObject(app)
{
    // create scene document from main.qml asset
    // set parent to created document to ensure it exists for the whole application lifetime
    QmlDocument *qml = QmlDocument::create("asset:///main.qml").parent(this);

    // Expose this class to QML so that we can call its functions from there
    qml->setContextProperty("app", this);

    // create root object for the UI
    mPrimaryPane = qml->createRootObject<AbstractPane>();
    // set created root object as a scene
    app->setScene(mPrimaryPane);


    // Retrieve the activity indicator from QML so that we can start
    // and stop it from C++
    mActivityIndicator = mPrimaryPane->findChild<ActivityIndicator*>("indicator");

    mUsernameText = mPrimaryPane->findChild<TextField*>("usernameText");
	mPasswordText = mPrimaryPane->findChild<TextField*>("passwordText");

    // Create a network access manager and connect a custom slot to its
	// finished signal
	mNetworkAccessManager = new QNetworkAccessManager(this);

	bool result = connect(mNetworkAccessManager,
			SIGNAL(finished(QNetworkReply*)),
			this, SLOT(requestFinished(QNetworkReply*)));

	// Displays a warning message if there's an issue connecting the signal
	// and slot. This is a good practice with signals and slots as it can
	// be easier to mistype a slot or signal definition
	Q_ASSERT(result);
	Q_UNUSED(result);
}

void SurfingSA::initiateRequest()
{
	// Start the activity indicator
	mActivityIndicator->start();

    // Create and send the network request
    QNetworkRequest request = QNetworkRequest();
    request.setUrl(QUrl("http://mobidex.biz/_phone/index.php?userdetails=1"));
    request.setRawHeader(QString("HTTP_AUTH_USER").toUtf8(), mUsernameText->text().toUtf8());
    request.setRawHeader(QString("HTTP_AUTH_PW").toUtf8(), QString("YWFhYWFh").toUtf8());
    mNetworkAccessManager->get(request);
}

void SurfingSA::requestFinished(QNetworkReply* reply)
{
    // Check the network reply for errors
    if (reply->error() == QNetworkReply::NoError)
    {
    	qDebug() << "\n Printing return data";
		qDebug() << "\n" << reply->readAll();
		qDebug() << "\n" << reply->url();

    	mUsernameText->setText(reply->readAll());
    }
    else
    {
        qDebug() << "\n Problem with the network";
        qDebug() << "\n" << reply->errorString();
    }
    mActivityIndicator->stop();

    reply->deleteLater();
}
