#include "Registration.h"
#include "../utils/Util.h"

#include <QFile>
#include <QTextStream>

#include <bb/data/XmlDataAccess>

using namespace bb::cascades;
using namespace bb::data;

Registration::Registration(AbstractPane *root): root(root)
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

void Registration::attemptRegistration(QString username, QString password, QString email, QString referrer) {
	// Retrieve the activity indicator from QML so that we can start
	// and stop it from C++
	mActivityIndicator = root->findChild<ActivityIndicator*>("registerIndicator");
	mRegistered = root->findChild<Label*>("registeredLabel");
	mResponse = root->findChild<Label*>("registeredResponseLabel");

	// Start the activity indicator
	mActivityIndicator->start();

	//check that the submitted info meets the minimum requirements
	if (username.length() < 6) {
		mRegistered->setText("2");
		mResponse->setText("Your username needs to be at least 6 characters long.");
		mActivityIndicator->stop();
		return;
	}
	else if (password.length() < 6) {
		mRegistered->setText("2");
		mResponse->setText("Your password needs to be at least 6 characters long.");
		mActivityIndicator->stop();
		return;
	}
	else if (email.length() == 0) {
		mRegistered->setText("2");
		mResponse->setText("You need to enter an email address.");
		mActivityIndicator->stop();
		return;
	}
	else if (username.contains(" ")) {
		mRegistered->setText("2");
		mResponse->setText("Please enter a username without spaces.");
		mActivityIndicator->stop();
		return;
	}
	else if (password.contains(" ")) {
		mRegistered->setText("2");
		mResponse->setText("Please enter a password without spaces.");
		mActivityIndicator->stop();
		return;
	}
	else if (referrer.length() > 0 && referrer.contains(" ")) {
		mRegistered->setText("2");
		mResponse->setText("The referrer name cannot contain spaces.");
		mActivityIndicator->stop();
		return;
	}

	// Create and send the network request
	QNetworkRequest request = QNetworkRequest();

	QString url = "http://www.mytcg.net/_phone/ssa/index.php?registeruser=1&username="+username+"&password="+password+"&email="+email;

	if (referrer.length() > 0) {
		url.append("&referer=");
		url.append(referrer);
	}

	qDebug() << "\n Registration url: " << url;

	request.setUrl(QUrl(url));

	encrypt = QString(Util::base64_encode(reinterpret_cast<const unsigned char*>(password.toStdString().c_str()), password.length()).c_str());

	mNetworkAccessManager->get(request);
}

void Registration::requestFinished(QNetworkReply* reply)
{
    // Check the network reply for errors
    if (reply->error() == QNetworkReply::NoError) {

    	QString result(reply->readAll());

    	qDebug() << "\n Registration result: " << result;

		if (result.contains("<result>") && result.contains("</result>")) {
			XmlDataAccess xda;
			QVariant var = xda.loadFromBuffer(result);

			mRegistered->setText("2");
			mResponse->setText(var.value<QString>());
		}
		else {
			//should add the encrypted password to the xml right after <userdetails>
			result.insert(13, QString("<encrypt>"+encrypt+"</encrypt>"));

			mRegistered->setText("1");
			QFile *file = new QFile("data/userdata.xml");

			// Open the file and print an error if the file cannot be opened
			if (file->open(QIODevice::ReadWrite)) {
				QTextStream fileStream(file);

				fileStream << result;

				file->close();
			}
			else {
				qDebug() << "\n Failed to open file";
			}
		}
    }
    else {
    	mRegistered->setText("2");
    	mResponse->setText("Problem with the network");
        qDebug() << "\n Problem with the network";
        qDebug() << "\n" << reply->errorString();
    }

    mActivityIndicator->stop();
}
