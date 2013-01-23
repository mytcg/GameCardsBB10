#include "Login.h"
#include "../utils/Util.h"

#include <QFile>
#include <QTextStream>

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
	mResponse = root->findChild<Label*>("loggedResponseLabel");

	// Start the activity indicator
	mActivityIndicator->start();

	//check that the submitted info meets the minimum requirements
	if (username.length() == 0) {
		mLoggedIn->setText("2");
		mResponse->setText("Please enter a username.");
		mActivityIndicator->stop();
		return;
	}
	else if (password.length() == 0) {
		mLoggedIn->setText("2");
		mResponse->setText("Please enter a password.");
		mActivityIndicator->stop();
		return;
	}

	// Create and send the network request
	QNetworkRequest request = QNetworkRequest();

	request.setUrl(QUrl("http://www.mytcg.net/_phone/ssa/index.php?userdetails=1"));

	encrypt = QString(Util::base64_encode(reinterpret_cast<const unsigned char*>(password.toStdString().c_str()), password.length()).c_str());

	request.setRawHeader(QString("AUTH_USER").toUtf8(), username.toUtf8());
	request.setRawHeader(QString("AUTH_PW").toUtf8(), encrypt.toUtf8());

	mNetworkAccessManager->get(request);
}

void Login::requestFinished(QNetworkReply* reply)
{
    // Check the network reply for errors
    if (reply->error() == QNetworkReply::NoError) {

    	QString result(reply->readAll());

    	if (result.compare("<user><result>Invalid User Details</result></user>") == 0) {
    		mLoggedIn->setText("2");
			mResponse->setText("Invalid User Details.");
    	}
    	else {
    		//should add the encrypted password to the xml right after <userdetails>
    		result.insert(13, QString("<encrypt>"+encrypt+"</encrypt>"));

    		mLoggedIn->setText("1");
    		QFile *file = new QFile("data/userdata.xml");

			// Open the file and print an error if the file cannot be opened
			if (file->open(QIODevice::ReadWrite))
			{
				QTextStream fileStream(file);


				fileStream << result;

				QFile::resize("data/userdata.xml", result.length());

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
