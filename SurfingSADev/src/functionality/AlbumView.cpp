#include "AlbumView.h"
#include "../utils/Util.h"

#include <bb/data/XmlDataAccess>
#include <bb/cascades/GroupDataModel>
#include <QtXml/QDomDocument>

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

	request.setUrl(QUrl("http://dev.mytcg.net/_phone/index.php?cardsincategory="+id+"&height=448&jpg=1&width=360"));

	string encoded = Util::base64_encode(reinterpret_cast<const unsigned char*>(QString("aaaaaa").toStdString().c_str()), 6);

	request.setRawHeader(QString("AUTH_USER").toUtf8(), QString("jamess").toUtf8());
	request.setRawHeader(QString("AUTH_PW").toUtf8(), QString(encoded.c_str()).toUtf8());

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

		model->insertList(tempList);
/*
		QList<QMap<QString, QString> > albums;

		QDomDocument doc("mydocument");
		if (!doc.setContent(xmldata)) {
		return;
		}

		//Get the root element
		QDomElement docElem = doc.documentElement();

		// you could check the root tag name here if it matters
		QString rootTag = docElem.tagName(); // == persons

		// get the node's interested in, this time only caring about person's
		QDomNodeList nodeList = docElem.elementsByTagName("album");

		//Check each node one by one.
		QMap<QString, QVariant> album;
		for (int ii = 0; ii < nodeList.count(); ii++) {

		// get the current one as QDomElement
		QDomElement el = nodeList.at(ii).toElement();

		//get all data for the element, by looping through all child elements
		QDomNode pEntries = el.firstChild();
		while (!pEntries.isNull()) {
		QDomElement peData = pEntries.toElement();
		QString tagNam = peData.tagName();

		if (tagNam == "albumname") {
		album["albumname"] = peData.text();
		} else if (tagNam == "albumid") {
		album["albumid"] = peData.text();
		} else if (tagNam == "hascards") {
		album["hascards"] = peData.text();
		} else if (tagNam == "website") {
		album["website"] = peData.text();
		}
		pEntries = pEntries.nextSibling();
		}
		model->insert(album);
		}*/
		mListView->setDataModel(model);
	}
	else
	{
		qDebug() << "\n Problem with the network";
		qDebug() << "\n" << reply->errorString();
	}

    mActivityIndicator->stop();
}
