#include "Login.h"
#include "../utils/Util.h"

#include <QFile>

using namespace bb::cascades;

Login::Login(AbstractPane *root): root(root)
{
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

void Login::attemptLogin(QString username, QString password) {
	// Retrieve the activity indicator from QML so that we can start
	// and stop it from C++
	mActivityIndicator = root->findChild<ActivityIndicator*>("loginIndicator");
	mLoggedIn = root->findChild<Label*>("loggedLabel");

	// Start the activity indicator
	mActivityIndicator->start();

	// Create and send the network request
	QNetworkRequest request = QNetworkRequest();

	request.setUrl(QUrl("http://dev.mytcg.net/_phone/index.php?userdetails=1"));

	string encoded = Util::base64_encode(reinterpret_cast<const unsigned char*>(password.toStdString().c_str()), password.length());

	request.setRawHeader(QString("AUTH_USER").toUtf8(), username.toUtf8());
	request.setRawHeader(QString("AUTH_PW").toUtf8(), QString(encoded.c_str()).toUtf8());

	mNetworkAccessManager->get(request);
}

void Login::requestFinished(QNetworkReply* reply)
{
    // Check the network reply for errors
    if (reply->error() == QNetworkReply::NoError) {
    	QString *result = new QString(reply->readAll());

    	qDebug() << "\n" << result;
    	qDebug() << "\n" << "result->compare(\"<user><result>Invalid User Details</result></user>\"): " << (result->compare("<user><result>Invalid User Details</result></user>"));

    	if (result->compare("<user><result>Invalid User Details</result></user>") == 0) {
    		mLoggedIn->setText("0");
    	}
    	else {
    		mLoggedIn->setText("1");
    		QFile *file = new QFile("data/userdata.xml");

			// Open the file and print an error if the file cannot be opened
			if (file->open(QIODevice::ReadWrite))
			{
				// Write to the file using the reply data and close the file
				file->write(reply->readAll());
				file->flush();
				file->close();
			}
			else {
				qDebug() << "\n Failed to open file";
			}
    	}
    }
    else {
    	mLoggedIn->setText("0");
        qDebug() << "\n Problem with the network";
        qDebug() << "\n" << reply->errorString();
    }

    mActivityIndicator->stop();
}
