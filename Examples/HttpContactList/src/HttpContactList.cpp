#include "HttpContactList.hpp"
#include "objects/Employee.h"

#include <QObject>
#include <QIODevice>
#include <QDir>
#include <QMultiMap>

#include <bb/cascades/Application>
#include <bb/cascades/QmlDocument>
#include <bb/cascades/AbstractPane>
#include <bb/cascades/XmlDataModel>
#include <bb/cascades/GroupDataModel>
#include <bb/data/XmlDataAccess>

using namespace bb::cascades;
using namespace bb::data;

HttpContactList::HttpContactList(bb::cascades::Application *app)
: QObject(app)
{
	qmlRegisterType<Employee>("myLibrary", 1, 0, "Employee");

    // Load the QML document
	QmlDocument *qml = QmlDocument::create("asset:///main.qml").parent(this);

    // Expose this class to QML so that we can call its functions from there
    qml->setContextProperty("app", this);

    // Retrieve the root node
    AbstractPane *root = qml->createRootObject<AbstractPane>();

    // Retrieve the activity indicator from QML so that we can start
    // and stop it from C++
    mActivityIndicator = root->findChild<ActivityIndicator*>("indicator");

    // Retrieve the list so we can set the data model on it once
    // we retrieve it
    mListView = root->findChild<ListView*>("listView");

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

	// Create a file in the application's data directory
	mFile = new QFile("data/model.xml");

	// Set the scene using the root node
	app->setScene(root);
}

void HttpContactList::initiateRequest()
{
    // Start the activity indicator
    mActivityIndicator->start();

    // Create and send the network request
    QNetworkRequest request = QNetworkRequest();
    request.setUrl(QUrl("http://free.worldweatheronline.com/feed/marine.ashx?q=33.97,22.45&format=xml&key=b437e1f2f2090601121212"));
    mNetworkAccessManager->get(request);
}

void HttpContactList::requestFinished(QNetworkReply* reply)
{
    // Check the network reply for errors
    if (reply->error() == QNetworkReply::NoError) {

        // Open the file and print an error if the file cannot be opened
        /*if (!mFile->open(QIODevice::ReadWrite))
        {
            qDebug() << "\n Failed to open file";
            return;
        }

        // Write to the file using the reply data and close the file
        qDebug() << "\n" << reply->readAll();
        mFile->write(reply->readAll());
        mFile->flush();
        mFile->close();

        // Create the data model using the contents of the file. The
        // location of the file is relative to the assets directory.
        XmlDataModel *dataModel = new XmlDataModel();
        dataModel->setSource(QUrl("file://" + QDir::homePath() + "/model.xml"));

        // Set the new data model on the list and stop the activity indicator
        mListView->setDataModel(dataModel);*/

    	// Create the data model and specify the sorting keys to use
    	//GroupDataModel *model = (GroupDataModel*)mListView->dataModel();
    	//GroupDataModel *model = root->findChild<GroupDataModel*>("groupDataModel");
    	GroupDataModel *model = new GroupDataModel(QStringList() << "firstName"
    	                                           << "lastName");
    	// Specify the type of grouping to use for the headers in the list
    	model->setGrouping(ItemGrouping::None);

    	// Create a QVariantMap and populate it with data for each item. When the data
    	// for an item has been populated, add the item to the data model and reuse
    	// the same QVariantMap for the next item.
    	// Insert the data as instances of the Employee class
    	/*model->insert(new Employee("Barichak", "Westlee", 12596375));
    	model->insert(new Employee("Lambier", "Jamie", 53621479));
    	model->insert(new Employee("Chepesky", "Mike", 65523696));
    	model->insert(new Employee("Marshall", "Denise", 77553269));
    	model->insert(new Employee("Taylor", "Matthew", 51236712));
    	model->insert(new Employee("Tiegs", "Mark", 13112965));
    	model->insert(new Employee("Tetzel", "Karla", 99214732));
    	model->insert(new Employee("Dundas", "Ian", 64329841));
    	model->insert(new Employee("Cacciacarro", "Marco", 54575213));*/

    	/*QVariantMap map;
    	map["firstName"] = "Italy"; map["lastName"] = "Rome"; model->insert(map);
    	map["firstName"] = "Spain"; map["lastName"] = "Barcelona"; model->insert(map);
    	map["firstName"] = "Canada"; map["lastName"] = "Waterloo"; model->insert(map);
    	map["firstName"] = "Canada"; map["lastName"] = "Vancouver"; model->insert(map);
    	map["firstName"] = "Italy"; map["lastName"] = "Milan"; model->insert(map);
    	map["firstName"] = "Canada"; map["lastName"] = "Toronto"; model->insert(map);
    	map["firstName"] = "Spain"; map["lastName"] = "Madrid"; model->insert(map);*/

    	// load the xml data
    	QString xmldata = "<contacts><contact><id>1</id><title>Sr. Editor</title><firstName>Mike</firstName><lastName>Chepesky</lastName></contact><contact><id>2</id><title>Talent Scout</title><firstName>Westlee</firstName><lastName>Barichak</lastName><phonenumber>+465256467</phonenumber><phonenumber>+464746734</phonenumber></contact></contacts>";
    	XmlDataAccess xda;
    	QVariant list = xda.loadFromBuffer(xmldata, "/contacts/contact");
    	// add the data to the model
    	model->insertList(list.value<QVariantList>());

    	mListView->setDataModel(model);

        mActivityIndicator->stop();

    }
    else
    {
        qDebug() << "\n Problem with the network";
        qDebug() << "\n" << reply->errorString();
    }
}
