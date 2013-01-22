#include "OnAuctionList.h"
#include "../utils/Util.h"
#include "../customcomponents/AuctionItem.h"
#include "../customcomponents/AuctionItemFactory.h"

#include <bb/data/XmlDataAccess>
#include <bb/cascades/GroupDataModel>

using namespace bb::cascades;
using namespace bb::data;

OnAuctionList::OnAuctionList(AbstractPane *root): root(root)
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

void OnAuctionList::loadOnAuctionList(QString id, QString type) {
	// Retrieve the activity indicator from QML so that we can start
	// and stop it from C++
	qDebug() << "\n Loading OnAuction List";
	mActivityIndicator = root->findChild<ActivityIndicator*>("loadOnAuctionListIndicator");

	// Start the activity indicator
	mActivityIndicator->start();

	// Create and send the network request
	QNetworkRequest request = QNetworkRequest();
	if(type.compare("0")== 0){
		qDebug() << "\n http://dev.mytcg.net/_phone/index.php?categoryauction=1&category_id="+id+"&height=448&jpg=1&width=360";
		request.setUrl(QUrl("http://dev.mytcg.net/_phone/index.php?categoryauction=1&category_id="+id+"&height=448&jpg=1&width=360"));
	}else{
		qDebug() << "\n http://dev.mytcg.net/_phone/index.php?userauction=1&username=jamess&height=448&jpg=1&width=360";
				request.setUrl(QUrl("http://dev.mytcg.net/_phone/index.php?userauction=1&username=jamess&height=448&jpg=1&width=360"));
	}
	request.setRawHeader(QString("AUTH_USER").toUtf8(), Util::getUsername().toUtf8());
	request.setRawHeader(QString("AUTH_PW").toUtf8(), Util::getEncrypt().toUtf8());

	mNetworkAccessManager->get(request);
}

void OnAuctionList::requestFinished(QNetworkReply* reply)
{
	qDebug() << "\n Got OnAuction List";
	// Check the network reply for errors
	if (reply->error() == QNetworkReply::NoError) {
		mListView = root->findChild<ListView*>("onAuctionListList");
		QString xmldata = QString(reply->readAll());

		qDebug() << "\nOnAuctionList xml: " << xmldata;

		GroupDataModel *model = new GroupDataModel(QStringList() << "description");
		// Specify the type of grouping to use for the headers in the list
		model->setGrouping(ItemGrouping::None);

		XmlDataAccess xda;
		QVariant list = xda.loadFromBuffer(xmldata, "/auctionsincategory/auction");
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
		AuctionItemFactory *itemfactory = new AuctionItemFactory();
		mListView->setListItemProvider(itemfactory);
	}
	else
	{
		qDebug() << "\n Problem with the network";
		qDebug() << "\n" << reply->errorString();
	}

	mActivityIndicator->stop();
}
