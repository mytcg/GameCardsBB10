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
    AbstractPane *root = qml->createRootObject<AbstractPane>();
    // set created root object as a scene
    app->setScene(root);


    // Retrieve the activity indicator from QML so that we can start
    // and stop it from C++
    mActivityIndicator = root->findChild<ActivityIndicator*>("indicator");
    // Retrieve the list so we can set the data model on it once
    // we retrieve it
    mUsernameText = root->findChild<TextField*>("usernameText");
    mPasswordText = root->findChild<TextField*>("passwordText");
}

void SurfingSA::initiateRequest()
{
    // Create and send the network request
    QNetworkRequest request = QNetworkRequest();
    request.setUrl(QUrl("https://www.mytcg.net/"));
    mNetworkAccessManager->get(request);
}

void SurfingSA::requestFinished(QNetworkReply* reply)
{
    // Check the network reply for errors
    if (reply->error() == QNetworkReply::NoError) {
    	mUsernameText->setText(reply->readAll());

    }
    else
    {
        qDebug() << "\n Problem with the network";
        qDebug() << "\n" << reply->errorString();
    }
}
