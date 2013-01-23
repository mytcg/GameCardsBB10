#include "Card.h"
#include "../utils/Util.h"
#include "../functionality/ImageLoader.h"

using namespace bb::cascades;

Card::Card(AbstractPane *root): root(root)
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

void Card::save(QString cardId) {
	// Retrieve the activity indicator from QML so that we can start
	// and stop it from C++
	mActivityIndicator = root->findChild<ActivityIndicator*>("cardIndicator");
	mCard = root->findChild<Label*>("cardLabel");

	// Start the activity indicator
	mActivityIndicator->start();

	// Create and send the network request
	QNetworkRequest request = QNetworkRequest();

	request.setUrl(QUrl("http://www.mytcg.net/_phone/ssa/index.php?savecard="+cardId));

	request.setRawHeader(QString("AUTH_USER").toUtf8(), Util::getUsername().toUtf8());
	request.setRawHeader(QString("AUTH_PW").toUtf8(), Util::getEncrypt().toUtf8());

	mNetworkAccessManager->get(request);
}

void Card::loadImage(QString image) {
	mCardView = root->findChild<ImageView*>("cardView");

	ImageLoader *imloader = new ImageLoader();
	imloader->loadImage(image, mCardView,"/cards/",".jpg");
}

void Card::reject(QString cardId) {
	// Retrieve the activity indicator from QML so that we can start
	// and stop it from C++
	mActivityIndicator = root->findChild<ActivityIndicator*>("cardIndicator");
	mCard = root->findChild<Label*>("cardLabel");

	// Start the activity indicator
	mActivityIndicator->start();

	// Create and send the network request
	QNetworkRequest request = QNetworkRequest();

	request.setUrl(QUrl("http://www.mytcg.net/_phone/ssa/index.php?rejectcard="+cardId));

	request.setRawHeader(QString("AUTH_USER").toUtf8(), Util::getUsername().toUtf8());
	request.setRawHeader(QString("AUTH_PW").toUtf8(), Util::getEncrypt().toUtf8());

	mNetworkAccessManager->get(request);
}

void Card::requestFinished(QNetworkReply* reply)
{
    // Check the network reply for errors
    if (reply->error() == QNetworkReply::NoError) {
    	QString result = QString(reply->readAll());
    	mCard->setText(result.mid(result.indexOf("<result>")+8,result.indexOf("</result>")-(result.indexOf("<result>")+8)));
    }
    else {
    	mCard->setText("Problem with the network");
        qDebug() << "\n Problem with the network";
        qDebug() << "\n" << reply->errorString();
    }

    mActivityIndicator->stop();
}
