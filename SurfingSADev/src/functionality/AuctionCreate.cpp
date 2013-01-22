#include "AuctionCreate.h"
#include "../utils/Util.h"

using namespace bb::cascades;

AuctionCreate::AuctionCreate(AbstractPane *root): root(root)
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

void AuctionCreate::createAuction(QString cardId, QString bid, QString buynow, QString duration) {
	mAuctionCreate = root->findChild<Label*>("auctionCreateLabel");
	qDebug() << "\n Creating auction";
	bool bidok = false;
	bid.toInt(&bidok);
	bool buyok = false;
	buynow.toInt(&buyok);
	bool durationok = false;
	duration.toInt(&durationok);
	qDebug() << "\n Creating auction derp";
	if (bid.length() == 0) {
		qDebug() << "\n Creating auction derp2";
		mAuctionCreate->setText("Please enter an opening bid.");
		qDebug() << "\n Creating auction derp3";
	} else if (buynow.length() == 0) {
		mAuctionCreate->setText("Please enter a buy now price.");
	} else if (duration.length() == 0) {
		mAuctionCreate->setText("Please enter the length of the auction(in days).");
	} else if (duration.compare("0") == 0) {
		mAuctionCreate->setText("Auction must last at least one day.");
	} else if (!bidok) {
		mAuctionCreate->setText("Please enter a valid opening bid.");
	} else if (!buyok) {
		mAuctionCreate->setText("Please enter a valid buy now price.");
	} else if (!durationok) {
		mAuctionCreate->setText("Please enter a valid length of the auction(in days).");
	} else if (duration.length() > 1) {
		mAuctionCreate->setText("Auctions are not allowed to last longer then 9 days.");
	} else {
		qDebug() << "\n Creating auction fo real";
		// Retrieve the activity indicator from QML so that we can start
		// and stop it from C++
		mActivityIndicator = root->findChild<ActivityIndicator*>("createAuctionIndicator");

		// Start the activity indicator
		mActivityIndicator->start();

		// Create and send the network request
		QNetworkRequest request = QNetworkRequest();

		request.setUrl(QUrl("http://www.mytcg.net/_phone/ssa/index.php?createauction=1&cardid="+cardId+"&bid="+bid+"&buynow="+buynow+"&days="+duration));

		request.setRawHeader(QString("AUTH_USER").toUtf8(), Util::getUsername().toUtf8());
		request.setRawHeader(QString("AUTH_PW").toUtf8(), Util::getEncrypt().toUtf8());

		mNetworkAccessManager->get(request);
	}
}

void AuctionCreate::requestFinished(QNetworkReply* reply)
{
	qDebug() << "\n Auction created";
	// Check the network reply for errors
	if (reply->error() == QNetworkReply::NoError) {
		QString result = QString(reply->readAll());
		if(result.mid(result.indexOf("<success>")+9,result.indexOf("</success>")-(result.indexOf("<success>")+9)).compare("1")==0){
			mAuctionCreate->setText("Auction successfully created!");
		}else{
			mAuctionCreate->setText("Error creating auction.");
		}
	}
	else {
		mAuctionCreate->setText("Problem with the network");
		qDebug() << "\n Problem with the network";
		qDebug() << "\n" << reply->errorString();
	}

	mActivityIndicator->stop();
}
