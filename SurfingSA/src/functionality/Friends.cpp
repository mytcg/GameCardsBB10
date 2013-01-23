#include "Friends.h"
#include "../utils/Util.h"

#include <bb/data/XmlDataAccess>
#include <bb/cascades/GroupDataModel>
#include <QtXml/QDomDocument>

using namespace bb::cascades;
using namespace bb::data;

Friends::Friends(AbstractPane *root): root(root)
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

void Friends::loadFriends() {
	// Retrieve the activity indicator from QML so that we can start
	// and stop it from C++
	qDebug() << "\n Loading Friends";
	mActivityIndicator = root->findChild<ActivityIndicator*>("loadFriendsIndicator");
	mFriends = root->findChild<Label*>("friendsLabel");

	// Start the activity indicator
	mActivityIndicator->start();

	// Create and send the network request
	QNetworkRequest request = QNetworkRequest();

	request.setUrl(QUrl("http://www.mytcg.net/_phone/ssa/index.php?friends=1"));

	request.setRawHeader(QString("AUTH_USER").toUtf8(), Util::getUsername().toUtf8());
	request.setRawHeader(QString("AUTH_PW").toUtf8(), Util::getEncrypt().toUtf8());

	mNetworkAccessManager->get(request);
}

void Friends::requestFinished(QNetworkReply* reply)
{
	qDebug() << "\n Got Friends";
	// Check the network reply for errors
	if (reply->error() == QNetworkReply::NoError) {
		mListView = root->findChild<ListView*>("friendsView");
		QString xmldata = QString(reply->readAll());
		GroupDataModel *model = new GroupDataModel(QStringList() << "usr"
				<< "val" << "desc");
		// Specify the type of grouping to use for the headers in the list
		model->setGrouping(ItemGrouping::None);

		QList<QMap<QString, QString> > friends;

		QDomDocument doc("mydocument");
		if (!doc.setContent(xmldata)) {
			return;
		}

		//Get the root element
		QDomElement docElem = doc.documentElement();

		// you could check the root tag name here if it matters
		QString rootTag = docElem.tagName(); // == persons

		// get the node's interested in, this time only caring about person's
		QDomNodeList nodeList = docElem.elementsByTagName("friend");

		//Check each node one by one.
		QMap<QString, QVariant> lfriend;
		for (int ii = 0; ii < nodeList.count(); ii++) {
			// get the current one as QDomElement
			QDomElement el = nodeList.at(ii).toElement();

			//get all data for the element, by looping through all child elements
			QDomNode pEntries = el.firstChild();
			while (!pEntries.isNull()) {
				QDomElement peData = pEntries.toElement();
				QString tagNam = peData.tagName();

				if (tagNam == "usr") {
					//We've found first name.
					lfriend["usr"] = peData.text();
				} else if (tagNam == "val") {
					//We've found surname.
					lfriend["val"] = peData.text();
				} else if (tagNam == "desc") {
					//We've found email.
					lfriend["desc"] = peData.text();
				}
				pEntries = pEntries.nextSibling();
			}
			model->insert(lfriend);
		}

		mListView->setDataModel(model);
	}
	else
	{
		qDebug() << "\n Problem with the network";
		qDebug() << "\n" << reply->errorString();
	}

	mActivityIndicator->stop();
}
