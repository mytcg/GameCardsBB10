#include "HeatScores.h"

#include "../utils/Util.h"

#include <QList>
#include <QTextStream>

#include <bb/data/XmlDataAccess>
#include <bb/cascades/DropDown>
#include <bb/cascades/Container>
#include <bb/cascades/GroupDataModel>
#include <bb/cascades/ListView>
#include <bb/cascades/Label>

using namespace bb::cascades;
using namespace bb::data;

HeatScores::HeatScores(AbstractPane *root): root(root)
{
	mHeatId = "";
	mLoading = false;
	mTimer = new QTimer(this);
	connect(mTimer, SIGNAL(timeout()), this, SLOT(refreshScores()));

	mScoreFactory = new ScoreItemFactory();

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

void HeatScores::refreshScores() {
	if (!mLoading) {
		(root->findChild<Label*>("scoresRefreshingLabel"))->setText("Refreshing scores..");
		getHeatScores(mHeatId, false);
	}
	mTimer->start(10000);
}

void HeatScores::stopRefresh() {
	mTimer->stop();
}

void HeatScores::getHeatScores(QString id, bool current) {
	mLoading = true;

	if (current) {
		mHeatId = id;
		mTimer->start(10000);
	}

	// Retrieve the activity indicator from QML so that we can start
	// and stop it from C++
	mActivityIndicator = root->findChild<ActivityIndicator*>("heatScoreIndicator");

	// Start the activity indicator
	mActivityIndicator->start();

	// Create and send the network request
	QNetworkRequest request = QNetworkRequest();

	QString url = "http://surfingsa.mytcg.net/_phone/index.php?heatscores=";
	url.append(id);

	request.setUrl(QUrl(url));

	mNetworkAccessManager->get(request);
}

void HeatScores::requestFinished(QNetworkReply* reply)
{
    // Check the network reply for errors
    if (reply->error() == QNetworkReply::NoError) {

    	QString result(reply->readAll());

    	qDebug() << "\n Scoring result: " << result;

    	GroupDataModel *model = new GroupDataModel();
		model->setGrouping(ItemGrouping::None);

    	XmlDataAccess xda;
		QVariant scoreData = xda.loadFromBuffer(result);

		QVariantMap scoreMap = scoreData.value<QVariantMap>();

		QVariantMap scoresMap = scoreMap["scores"].value<QVariantMap>();
		QVariantList scoreList = scoresMap["score"].value<QVariantList>();
		QMap<QString, QVariant> scoreEntry;
		for (int i = 0; i < scoreList.size(); i++) {
			QVariantMap score = scoreList[i].value<QVariantMap>();
			QVariantMap wavesMap = score["waves"].value<QVariantMap>();
			QVariantList waveList = wavesMap["wave"].value<QVariantList>();

			scoreEntry["surfer_name"] = score["surfer_name"].value<QString>();
			scoreEntry["surfer_surname"] = score["surfer_surname"].value<QString>();
			scoreEntry["waves"] = waveList;

			model->insert(scoreEntry);
		}

		(root->findChild<ListView*>("heatListView"))->setDataModel(model);
		(root->findChild<ListView*>("heatListView"))->setListItemProvider(mScoreFactory);
    }
    else {
        qDebug() << "\n Scoring Problem with the network";
        qDebug() << "\n Scoring " << reply->errorString();
    }

    (root->findChild<Label*>("scoresRefreshingLabel"))->setText("");
    mActivityIndicator->stop();
    mLoading = false;
}
