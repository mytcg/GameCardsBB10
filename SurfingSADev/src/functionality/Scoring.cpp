#include "Scoring.h"

#include "../utils/Util.h"

#include <QTime>

#include <bb/data/XmlDataAccess>
#include <bb/cascades/DropDown>
#include <bb/cascades/Container>

using namespace bb::cascades;
using namespace bb::data;

Scoring::Scoring(AbstractPane *root): root(root)
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

void Scoring::getCurrentEvents() {
	// Retrieve the activity indicator from QML so that we can start
	// and stop it from C++
	mActivityIndicator = root->findChild<ActivityIndicator*>("scoringIndicator");

	// Start the activity indicator
	mActivityIndicator->start();

	//set the string vars
	mapString = "event";
	idString = "event_id";
	nameString ="event_name";
	dropDownString = "scoringEventDropDown";

	// Create and send the network request
	QNetworkRequest request = QNetworkRequest();

	QString url = "http://surfingsa.mytcg.net/_phone/index.php?currentevents=1";

	request.setUrl(QUrl(url));

	mNetworkAccessManager->get(request);
}

void Scoring::getArchiveEvents() {
	// Retrieve the activity indicator from QML so that we can start
	// and stop it from C++
	mActivityIndicator = root->findChild<ActivityIndicator*>("scoringIndicator");

	// Start the activity indicator
	mActivityIndicator->start();

	//set the string vars
	mapString = "event";
	idString = "event_id";
	nameString = "event_name";
	dropDownString = "scoringEventDropDown";

	// Create and send the network request
	QNetworkRequest request = QNetworkRequest();

	QString url = "http://surfingsa.mytcg.net/_phone/index.php?archiveevents=1";

	request.setUrl(QUrl(url));

	mNetworkAccessManager->get(request);
}

void Scoring::getCategories(QString id) {
	// Retrieve the activity indicator from QML so that we can start
	// and stop it from C++
	mActivityIndicator = root->findChild<ActivityIndicator*>("scoringIndicator");

	// Start the activity indicator
	mActivityIndicator->start();

	//set the string vars
	mapString = "group";
	idString = "group_id";
	nameString = "group_description";
	dropDownString = "scoringCategoryDropDown";

	// Create and send the network request
	QNetworkRequest request = QNetworkRequest();

	QString url = "http://surfingsa.mytcg.net/_phone/index.php?eventgroups=";
	url.append(id);

	request.setUrl(QUrl(url));

	mNetworkAccessManager->get(request);
}

void Scoring::getRounds(QString id) {
	// Retrieve the activity indicator from QML so that we can start
	// and stop it from C++
	mActivityIndicator = root->findChild<ActivityIndicator*>("scoringIndicator");

	// Start the activity indicator
	mActivityIndicator->start();

	//set the string vars
	mapString = "round";
	idString = "round_id";
	nameString = "round_description";
	dropDownString = "scoringRoundDropDown";

	// Create and send the network request
	QNetworkRequest request = QNetworkRequest();

	QString url = "http://surfingsa.mytcg.net/_phone/index.php?eventrounds=";
	url.append(id);

	request.setUrl(QUrl(url));

	mNetworkAccessManager->get(request);
}

void Scoring::getHeats(QString id) {
	// Retrieve the activity indicator from QML so that we can start
	// and stop it from C++
	mActivityIndicator = root->findChild<ActivityIndicator*>("scoringIndicator");

	// Start the activity indicator
	mActivityIndicator->start();

	//set the string vars
	mapString = "heat";
	idString = "heat_id";
	nameString = "heat_description";
	dropDownString = "scoringHeatDropDown";

	// Create and send the network request
	QNetworkRequest request = QNetworkRequest();

	QString url = "http://surfingsa.mytcg.net/_phone/index.php?eventheats=";
	url.append(id);

	request.setUrl(QUrl(url));

	mNetworkAccessManager->get(request);
}

void Scoring::requestFinished(QNetworkReply* reply)
{
    // Check the network reply for errors
    if (reply->error() == QNetworkReply::NoError) {

    	QString result(reply->readAll());

    	qDebug() << "\n Scoring result: " << result;

		XmlDataAccess xda;
		QVariant list = xda.loadFromBuffer(result);
		QVariantMap tempMap = list.value<QVariantMap>();
		QVariantMap eventsMap = tempMap[mapString].value<QVariantMap>();
		QVariantList tempList;
		if (eventsMap.isEmpty()) {
			tempList = tempMap[mapString].value<QVariantList>();
		}
		else {
			tempList.append(eventsMap);
		}

		for (int i = 0; i < tempList.size(); i++) {
			QVariantMap event = tempList[i].value<QVariantMap>();
			(root->findChild<DropDown*>(dropDownString))->add(Option::create().text(event[nameString].value<QString>()).value(event[idString].value<QString>()));
		}

    }
    else {
        qDebug() << "\n Scoring Problem with the network";
        qDebug() << "\n Scoring " << reply->errorString();
    }

    (root->findChild<Container*>("scoreContainer"))->setEnabled(true);
    mActivityIndicator->stop();
}
