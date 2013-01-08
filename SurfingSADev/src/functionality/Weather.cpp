#include "Weather.h"

#include <bb/cascades/DropDown>
#include <bb/data/XmlDataAccess>

using namespace bb::cascades;
using namespace bb::data;

Weather::Weather(AbstractPane *root): root(root)
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

void Weather::getWeather(QString coords) {
	// Retrieve the activity indicator from QML so that we can start
	// and stop it from C++
	mActivityIndicator = root->findChild<ActivityIndicator*>("weatherIndicator");

	// Start the activity indicator
	mActivityIndicator->start();

	// Create and send the network request
	QNetworkRequest request = QNetworkRequest();

	QString url = "http://free.worldweatheronline.com/feed/marine.ashx?q=";
	url.append(coords);
	url.append("&format=xml&key=b437e1f2f2090601121212");

	qDebug() << "\n QString url: " << url;

	request.setUrl(QUrl(url));

	mNetworkAccessManager->get(request);
}

void Weather::requestFinished(QNetworkReply* reply)
{
    // Check the network reply for errors
    if (reply->error() == QNetworkReply::NoError) {

    	QString result(reply->readAll());

    	qDebug() << "\n result: " << result;

		XmlDataAccess xda;
		QVariant weatherData = xda.loadFromBuffer(result, "/data/weather");

		QVariantList qList = weatherData.value<QVariantList>();
		for (int i = 0; i < qList.size(); i++) {
			QVariantMap temp = qList[i].value<QVariantMap>();
			qDebug() << "\nfirstName: " << temp["firstName"].value<QString>();
			qDebug() << "\nlastName: " << temp["lastName"].value<QString>();
			qDebug() << "\ntitle: " << temp["title"].value<QString>();
		}

    }
    else {
        qDebug() << "\n Problem with the network";
        qDebug() << "\n" << reply->errorString();
    }

    mActivityIndicator->stop();
}
