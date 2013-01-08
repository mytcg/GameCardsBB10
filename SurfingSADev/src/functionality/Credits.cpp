#include "Credits.h"
#include "../utils/Util.h"

#include <bb/data/XmlDataAccess>
#include <bb/cascades/GroupDataModel>
#include <QtXml/QDomDocument>

using namespace bb::cascades;
using namespace bb::data;

Credits::Credits(AbstractPane *root): root(root)
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

void Credits::loadCredits() {
	// Retrieve the activity indicator from QML so that we can start
	// and stop it from C++
	qDebug() << "\n Loading Credits";
	mActivityIndicator = root->findChild<ActivityIndicator*>("loadCreditsIndicator");
	mCredits = root->findChild<Label*>("creditsLabel");

	// Start the activity indicator
	mActivityIndicator->start();

	// Create and send the network request
	QNetworkRequest request = QNetworkRequest();

	request.setUrl(QUrl("http://dev.mytcg.net/_phone/index.php?creditlog=1"));

	string encoded = Util::base64_encode(reinterpret_cast<const unsigned char*>(QString("aaaaaa").toStdString().c_str()), 6);

	request.setRawHeader(QString("AUTH_USER").toUtf8(), QString("jamess").toUtf8());
	request.setRawHeader(QString("AUTH_PW").toUtf8(), QString(encoded.c_str()).toUtf8());

	mNetworkAccessManager->get(request);
}

void Credits::requestFinished(QNetworkReply* reply)
{
	qDebug() << "\n Got Credits";
	// Check the network reply for errors
	if (reply->error() == QNetworkReply::NoError) {
		mListView = root->findChild<ListView*>("creditsView");
		TextField * credits = root->findChild<TextField*>("creditsText");
		TextField * premium = root->findChild<TextField*>("premiumText");
		QString xmldata = QString(reply->readAll());
		XmlDataAccess xda;
		QVariant list = xda.loadFromBuffer(xmldata, "/transactions");
		QVariantList qList = list.value<QVariantList>();
		for (int i = 0; i < qList.size(); i++) {
			QVariantMap temp = qList[i].value<QVariantMap>();
			credits->setText (temp["credits"].value<QString>());
			premium->setText (temp["premium"].value<QString>());
		}

		GroupDataModel *model = new GroupDataModel(QStringList() << "desc");
		// Specify the type of grouping to use for the headers in the list
		model->setGrouping(ItemGrouping::None);

		QList<QMap<QString, QString> > transactions;

		QDomDocument doc("mydocument");
		if (!doc.setContent(xmldata)) {
			return;
		}

		//Get the root element
		QDomElement docElem = doc.documentElement();

		// you could check the root tag name here if it matters
		QString rootTag = docElem.tagName();

		// get the node's interested in, this time only caring about transaction
		QDomNodeList nodeList = docElem.elementsByTagName("transaction");

		//Check each node one by one.
		QMap<QString, QVariant> transaction;
		for (int ii = 0; ii < nodeList.count(); ii++) {

			// get the current one as QDomElement
			QDomElement el = nodeList.at(ii).toElement();

			//get all data for the element, by looping through all child elements
			QDomNode pEntries = el.firstChild();
			while (!pEntries.isNull()) {
				QDomElement peData = pEntries.toElement();
				QString tagNam = peData.tagName();

				if (tagNam == "desc") {
					//We've found first name.
					transaction["desc"] = peData.text();
				} else if (tagNam == "surname") {
					//We've found surname.
					transaction["surname"] = peData.text();
				} else if (tagNam == "email") {
					//We've found email.
					transaction["email"] = peData.text();
				} else if (tagNam == "website") {
					//We've found website.
					transaction["website"] = peData.text();
				}
				pEntries = pEntries.nextSibling();
			}
			model->insert(transaction);
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
