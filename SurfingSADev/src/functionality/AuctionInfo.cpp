#include "AuctionInfo.h"
#include "../utils/Util.h"

#include <QFile>

using namespace bb::cascades;

AuctionInfo::AuctionInfo(AbstractPane *root): root(root)
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

void AuctionInfo::placeBid(QString auctionId, QString username, QString bid) {
	// Retrieve the activity indicator from QML so that we can start
	// and stop it from C++
	qDebug() << "\n Placing bid";
	mActivityIndicator = root->findChild<ActivityIndicator*>("auctionInfoIndicator");
	mAuctionInfo = root->findChild<Label*>("auctionInfoLabel");

	// Start the activity indicator
	mActivityIndicator->start();

	// Create and send the network request
	QNetworkRequest request = QNetworkRequest();
	qDebug() << "\n http://dev.mytcg.net/_phone/index.php?auctionbid=1&username="+username+"&bid="+bid+"&auctioncardid="+auctionId;
	request.setUrl(QUrl("http://dev.mytcg.net/_phone/index.php?auctionbid=1&username="+username+"&bid="+bid+"&auctioncardid="+auctionId));

	string encoded = Util::base64_encode(reinterpret_cast<const unsigned char*>(QString("aaaaaa").toStdString().c_str()), 6);

	request.setRawHeader(QString("AUTH_USER").toUtf8(), QString("jamess").toUtf8());
	request.setRawHeader(QString("AUTH_PW").toUtf8(), QString(encoded.c_str()).toUtf8());

	mNetworkAccessManager->get(request);
}

void AuctionInfo::buyNow(QString auctionId, QString username, QString buynowprice, QString usercardId) {
	// Retrieve the activity indicator from QML so that we can start
	// and stop it from C++
	qDebug() << "\n Buy Now";
	mActivityIndicator = root->findChild<ActivityIndicator*>("auctionInfoIndicator");
	mAuctionInfo = root->findChild<Label*>("auctionInfoLabel");

	// Start the activity indicator
	mActivityIndicator->start();

	// Create and send the network request
	QNetworkRequest request = QNetworkRequest();
	qDebug() << "\n http://dev.mytcg.net/_phone/index.php?buyauctionnow=1&username="+username+"&buynowprice="+buynowprice+"&auctioncardid="+auctionId+"&usercardid="+usercardId;
	request.setUrl(QUrl("http://dev.mytcg.net/_phone/index.php?buyauctionnow=1&username="+username+"&buynowprice="+buynowprice+"&auctioncardid="+auctionId+"&usercardid="+usercardId));

	string encoded = Util::base64_encode(reinterpret_cast<const unsigned char*>(QString("aaaaaa").toStdString().c_str()), 6);

	request.setRawHeader(QString("AUTH_USER").toUtf8(), QString("jamess").toUtf8());
	request.setRawHeader(QString("AUTH_PW").toUtf8(), QString(encoded.c_str()).toUtf8());

	mNetworkAccessManager->get(request);
}

void AuctionInfo::requestFinished(QNetworkReply* reply)
{
    // Check the network reply for errors
    if (reply->error() == QNetworkReply::NoError) {
    	QString result = QString(reply->readAll());
    	qDebug() << "\n Result "+result;
    	if(result.mid(result.indexOf("<result>")+8,result.indexOf("</result>")-(result.indexOf("<result>")+8)).compare("1")==0){
    		mAuctionInfo->setText("Successfully bought Auction!");
    	}else{
    		mAuctionInfo->setText(result.mid(result.indexOf("<result>")+8,result.indexOf("</result>")-(result.indexOf("<result>")+8)));
    	}
    	}
    else {
    	mAuctionInfo->setText("Problem with the network");
        qDebug() << "\n Problem with the network";
        qDebug() << "\n" << reply->errorString();
    }

    mActivityIndicator->stop();
}
