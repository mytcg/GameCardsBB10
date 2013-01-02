#include "Album.h"
#include "../utils/Util.h"

#include <bb/data/XmlDataAccess>
#include <bb/cascades/GroupDataModel>

using namespace bb::cascades;
using namespace bb::data;

Album::Album(AbstractPane *root): root(root)
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

void Album::loadAlbums(QString id) {
	// Retrieve the activity indicator from QML so that we can start
	// and stop it from C++
	qDebug() << "\n Loading Albums";
	mActivityIndicator = root->findChild<ActivityIndicator*>("loadIndicator");
	mAlbum = root->findChild<Label*>("albumLabel");

	// Start the activity indicator
	mActivityIndicator->start();

	// Create and send the network request
	QNetworkRequest request = QNetworkRequest();

	request.setUrl(QUrl("http://dev.mytcg.net/_phone/index.php?usercategories=1"));

	string encoded = Util::base64_encode(reinterpret_cast<const unsigned char*>(QString("aaaaaa").toStdString().c_str()), 6);

	request.setRawHeader(QString("AUTH_USER").toUtf8(), QString("jamess").toUtf8());
	request.setRawHeader(QString("AUTH_PW").toUtf8(), QString(encoded.c_str()).toUtf8());

	mNetworkAccessManager->get(request);
}

void Album::requestFinished(QNetworkReply* reply)
{
	qDebug() << "\n Got Albums";
    // Check the network reply for errors
	if (reply->error() == QNetworkReply::NoError) {
		mListView = root->findChild<ListView*>("listView");
		QString xmldata = QString(reply->readAll());
	    	GroupDataModel *model = new GroupDataModel(QStringList() << "albumname"
	    	                                           << "lastName");
	    	// Specify the type of grouping to use for the headers in the list
	    	model->setGrouping(ItemGrouping::None);

	    	// load the xml data
	    	XmlDataAccess xda;
	    	QVariant list = xda.loadFromBuffer(xmldata, "/usercategories/album");
	    	// add the data to the model
	    	model->insertList(list.value<QVariantList>());

	    	mListView->setDataModel(model);
	    }
	    else
	    {
	        qDebug() << "\n Problem with the network";
	        qDebug() << "\n" << reply->errorString();
	    }

    mActivityIndicator->stop();
}