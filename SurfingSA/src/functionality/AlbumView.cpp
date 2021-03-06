#include "AlbumView.h"
#include "../utils/Util.h"
#include "../customcomponents/AlbumItem.h"
#include "../customcomponents/AlbumItemFactory.h"

#include <bb/data/XmlDataAccess>
#include <bb/cascades/GroupDataModel>

#include "QList"

using namespace bb::cascades;
using namespace bb::data;

AlbumView::AlbumView(AbstractPane *root): root(root)
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

void AlbumView::loadAlbum(QString id) {
	// Retrieve the activity indicator from QML so that we can start
	// and stop it from C++
	qDebug() << "\n Loading Album";
	mActivityIndicator = root->findChild<ActivityIndicator*>("loadAlbumViewIndicator");
	mAlbumView = root->findChild<Label*>("albumViewLabel");

	// Start the activity indicator
	mActivityIndicator->start();

	// Create and send the network request
	QNetworkRequest request = QNetworkRequest();

	qDebug() << "\n http://www.mytcg.net/_phone/ssa/index.php?cardsincategory="+id+"&height="+Util::getHeight()+"&jpg=1&width="+Util::getWidth();
	request.setUrl(QUrl("http://www.mytcg.net/_phone/ssa/index.php?cardsincategory="+id+"&height="+Util::getHeight()+"&jpg=1&width="+Util::getWidth()));

	request.setRawHeader(QString("AUTH_USER").toUtf8(), Util::getUsername().toUtf8());
	request.setRawHeader(QString("AUTH_PW").toUtf8(), Util::getEncrypt().toUtf8());

	mNetworkAccessManager->get(request);
}

void AlbumView::requestFinished(QNetworkReply* reply)
{
	qDebug() << "\n Got Album";
    // Check the network reply for errors
	if (reply->error() == QNetworkReply::NoError) {
		mListView = root->findChild<ListView*>("albumViewView");
		QString xmldata = QString(reply->readAll());

		qDebug() << "\nAlbumView xml: " << xmldata;

		GroupDataModel *model = new GroupDataModel(QStringList() << "description");
		// Specify the type of grouping to use for the headers in the list
		model->setGrouping(ItemGrouping::None);

		XmlDataAccess xda;
		QVariant list = xda.loadFromBuffer(xmldata, "/cardsincategory/card");
		QVariantMap tempMap = list.value<QVariantMap>();
		QVariantList tempList;
		if (tempMap.isEmpty()) {
			tempList = list.value<QVariantList>();
		}
		else {
			tempList.append(tempMap);
		}

		QVariantList newList;

		//qDebug() << "\nAlbumView looping";
		for (int i = 0; i < tempList.size(); i++) {
			QVariantMap card = tempList[i].value<QVariantMap>();
			//qDebug() << "\nAlbumView card[\"description\"]: " << card["description"].value<QString>();
			QVariantMap statMap = card["stats"].value<QVariantMap>();
			QVariantList statList;
			if (statMap.isEmpty()) {
				statList = card["stats"].value<QVariantList>();
			}
			else {
				statList.append(statMap["stat"].value<QVariantMap>());
			}
			//statList = card["stats"].value<QVariantList>();
			qDebug() << "\nAlbumView statList.size(): " << statList.size();
			for (int j = 0; j < statList.size(); j++) {
				QVariantMap stat = statList[j].value<QVariantMap>();

				stat["stringValue"] = stat[".data"];

				qDebug() << "\nAlbumView stat.Size(): " << stat.size();

				/*QList<QString> statKeyList = stat.keys();

				for (int k = 0; k < statKeyList.size(); k++) {
					qDebug() << "\nAlbumView statKeyList[" << k << "]: " << statKeyList[k];
					qDebug() << "\nAlbumView stat[" << statKeyList[k] << "].value<QString>(): " << stat[statKeyList[k]].value<QString>();
				}*/

				statList.replace(j, stat);
			}

			card["stats"] = statList;

			newList.append(card);
		}

		model->insertList(newList);

		mListView->setDataModel(model);
		AlbumItemFactory *itemfactory = new AlbumItemFactory();
		mListView->setListItemProvider(itemfactory);
	}
	else
	{
		qDebug() << "\n Problem with the network";
		qDebug() << "\n" << reply->errorString();
	}

    mActivityIndicator->stop();
}
