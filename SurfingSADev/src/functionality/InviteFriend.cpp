#include "InviteFriend.h"
#include "../utils/Util.h"

#include <QFile>

using namespace bb::cascades;

InviteFriend::InviteFriend(AbstractPane *root): root(root)
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

void InviteFriend::inviteFriend(QString username, QString email, QString number) {
	// Retrieve the activity indicator from QML so that we can start
	// and stop it from C++
	mActivityIndicator = root->findChild<ActivityIndicator*>("inviteFriendIndicator");
	mInviteFriend = root->findChild<Label*>("inviteFriendLabel");

	QString friendDetail;
	QString method;
	if (username.length() > 0)
	{
		friendDetail = username;
		method = "username";
	}
	else if (email.length() > 0)
	{
		friendDetail = email;
		method = "email";
	}
	else if (number.length() > 0)
	{
		friendDetail = number;
		method = "phone_number";
	}
	// Start the activity indicator
	mActivityIndicator->start();

	// Create and send the network request
	QNetworkRequest request = QNetworkRequest();

	request.setUrl(QUrl("http://dev.mytcg.net/_phone/index.php?friendinvite=1&trademethod="+method+"&detail="+friendDetail));

	request.setRawHeader(QString("AUTH_USER").toUtf8(), Util::getUsername().toUtf8());
	request.setRawHeader(QString("AUTH_PW").toUtf8(), Util::getEncrypt().toUtf8());

	mNetworkAccessManager->get(request);
}

void InviteFriend::requestFinished(QNetworkReply* reply)
{
    // Check the network reply for errors
    if (reply->error() == QNetworkReply::NoError) {
    	QString result = QString(reply->readAll());
    	mInviteFriend->setText(result.mid(result.indexOf("<result>")+8,result.indexOf("</result>")-(result.indexOf("<result>")+8)));
    }
    else {
    	mInviteFriend->setText("Problem with the network");
        qDebug() << "\n Problem with the network";
        qDebug() << "\n" << reply->errorString();
    }

    mActivityIndicator->stop();
}
