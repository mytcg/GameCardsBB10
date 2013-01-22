#include "Auction.h"
#include "../utils/Util.h"

#include <bb/data/XmlDataAccess>
#include <bb/cascades/GroupDataModel>
#include <QtXml/QDomDocument>

using namespace bb::cascades;
using namespace bb::data;

Auction::Auction(AbstractPane *root): root(root)
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

void Auction::loadAuctions() {
	// Retrieve the activity indicator from QML so that we can start
	// and stop it from C++
	qDebug() << "\n Loading Auctions";
	mActivityIndicator = root->findChild<ActivityIndicator*>("loadAuctionsIndicator");
	mAuction = root->findChild<Label*>("auctionLabel");

	// Start the activity indicator
	mActivityIndicator->start();

	// Create and send the network request
	QNetworkRequest request = QNetworkRequest();

	request.setUrl(QUrl("http://www.mytcg.net/_phone/ssa/index.php?auctioncategories=1"));

	request.setRawHeader(QString("AUTH_USER").toUtf8(), Util::getUsername().toUtf8());
	request.setRawHeader(QString("AUTH_PW").toUtf8(), Util::getEncrypt().toUtf8());

	mNetworkAccessManager->get(request);
}

void Auction::requestFinished(QNetworkReply* reply)
{
	qDebug() << "\n Got Auctions";
	// Check the network reply for errors
	if (reply->error() == QNetworkReply::NoError) {
		mListView = root->findChild<ListView*>("auctionView");
		QString xmldata = QString(reply->readAll());
		qDebug() << "\n "+xmldata;
		GroupDataModel *model = new GroupDataModel(QStringList() << "albumid");
		// Specify the type of grouping to use for the headers in the list
		model->setGrouping(ItemGrouping::None);

		XmlDataAccess xda;
		QVariant list = xda.loadFromBuffer(xmldata, "/cardcategories/album");
		QVariantMap tempMap = list.value<QVariantMap>();
		QVariantList tempList;
		if (tempMap.isEmpty()) {
			tempList = list.value<QVariantList>();
		}
		else {
			tempList.append(tempMap);
		}

		model->insertList(tempList);

		mListView->setDataModel(model);
	}
	else
	{
		qDebug() << "\n Problem with the network";
		qDebug() << "\n" << reply->errorString();
	}

	mActivityIndicator->stop();
}
