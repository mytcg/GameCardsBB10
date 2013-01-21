#include "Weather.h"

#include <QTime>

#include <bb/data/XmlDataAccess>
#include <bb/cascades/DropDown>
#include <bb/cascades/Label>
#include <bb/cascades/GroupDataModel>
#include <bb/cascades/ListView>

using namespace bb::cascades;
using namespace bb::data;

Weather::Weather(AbstractPane *root): root(root)
{
	mWeatherFactory = new WeatherItemFactory();

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

    	QString timeString("");
    	QTextStream timeStream(&timeString);
    	QTime time;
    	time.start();
    	qDebug() << "\n weather time: " << time.toString("hh:mm:ss.zzz");
    	qDebug() << "\n weather time hh: " << time.toString("hh");
    	qDebug() << "\n weather time.hour(): " << time.hour();
    	qDebug() << "\n weather time.minute(): " << time.minute();
    	qDebug() << "\n weather time.second(): " << time.second();

    	timeStream << time.hour() << "00";

    	qDebug() << "\n weather timeString: " << timeString;

    	QString result(reply->readAll());

    	qDebug() << "\n result: " << result;

		XmlDataAccess xda;
		QVariant weatherData = xda.loadFromBuffer(result, "/data/weather");

		QVariantMap weatherMap = weatherData.value<QVariantMap>();

		qDebug() << "\n weather date: " << weatherMap["date"].value<QString>();
		qDebug() << "\n weather maxtempC: " << weatherMap["maxtempC"].value<QString>();
		qDebug() << "\n weather mintempC: " << weatherMap["mintempC"].value<QString>();

		QVariantList qList = weatherMap["hourly"].value<QVariantList>();

		GroupDataModel *model = new GroupDataModel(QStringList() << "id");
		// Specify the type of grouping to use for the headers in the list
		model->setGrouping(ItemGrouping::None);

		QMap<QString, QVariant> weatherEntry;
		QString hString;
		for (int i = 0; i < qList.size(); i++) {
			QVariantMap temp = qList[i].value<QVariantMap>();
			hString = temp["time"].value<QString>();
			if (hString.length() <= 3) {
				hString.prepend(QString("0"));
			}
			hString.remove(2, 2);
			hString.append(QString("h"));


			weatherEntry["id"] = i;
			weatherEntry["time"] = hString;
			weatherEntry["weatherIconUrl"] = temp["weatherIconUrl"].value<QString>();
			weatherEntry["windspeedKmph"] = temp["windspeedKmph"].value<QString>();
			weatherEntry["winddirDegree"] = temp["winddirDegree"].value<QString>();
			weatherEntry["tempC"] = temp["tempC"].value<QString>();
			weatherEntry["cloudcover"] = temp["cloudcover"].value<QString>();
			weatherEntry["pressure"] = temp["pressure"].value<QString>();
			weatherEntry["humidity"] = temp["humidity"].value<QString>();
			weatherEntry["swellHeight_m"] = temp["swellHeight_m"].value<QString>();
			weatherEntry["swellDir"] = temp["swellDir"].value<QString>();

			model->insert(weatherEntry);

			if ((temp["time"].value<QString>()).toInt() <= timeString.toInt()) {
				(root->findChild<Label*>("dateLabel"))->setText(weatherMap["date"].value<QString>());
				(root->findChild<Label*>("maxTempLabel"))->setText(weatherMap["maxtempC"].value<QString>());
				(root->findChild<Label*>("minTempLabel"))->setText(weatherMap["mintempC"].value<QString>());
			}
		}

		(root->findChild<Label*>("maxTempLabelHeader"))->setVisible(true);
		(root->findChild<Label*>("minTempLabelHeader"))->setVisible(true);

		(root->findChild<ListView*>("weatherListView"))->setDataModel(model);
		(root->findChild<ListView*>("weatherListView"))->setListItemProvider(mWeatherFactory);
    }
    else {
        qDebug() << "\n Problem with the network";
        qDebug() << "\n" << reply->errorString();
    }

    mActivityIndicator->stop();
}
