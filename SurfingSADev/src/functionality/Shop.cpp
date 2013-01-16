#include "Shop.h"

#include "../utils/Util.h"
#include "../customcomponents/ShopItem.h"
#include "../customcomponents/ShopItemFactory.h"

#include <bb/data/XmlDataAccess>
#include <bb/cascades/GroupDataModel>
#include <bb/cascades/Container>

#include <QtXml/QDomDocument>

using namespace bb::cascades;
using namespace bb::data;

Shop::Shop(AbstractPane *root): root(root)
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

void Shop::loadProducts() {
	// Retrieve the activity indicator from QML so that we can start
	// and stop it from C++
	qDebug() << "\n Loading Products";
	mActivityIndicator = root->findChild<ActivityIndicator*>("loadProductsIndicator");
	mShop = root->findChild<Label*>("shopLabel");

	// Start the activity indicator
	mActivityIndicator->start();

	// Create and send the network request
	QNetworkRequest request = QNetworkRequest();

	request.setUrl(QUrl("http://dev.mytcg.net/_phone/index.php?categoryproducts=2&categoryId=1"));

	string encoded = Util::base64_encode(reinterpret_cast<const unsigned char*>(QString("aaaaaa").toStdString().c_str()), 6);

	request.setRawHeader(QString("AUTH_USER").toUtf8(), QString("jamess").toUtf8());
	request.setRawHeader(QString("AUTH_PW").toUtf8(), QString(encoded.c_str()).toUtf8());

	mNetworkAccessManager->get(request);
}

void Shop::requestFinished(QNetworkReply* reply)
{
	qDebug() << "\n Got Products";
	// Check the network reply for errors
	if (reply->error() == QNetworkReply::NoError) {
		QString xmldata = QString(reply->readAll());
		GroupDataModel *model = new GroupDataModel(QStringList() << "productname");

		// Specify the type of grouping to use for the headers in the list
		model->setGrouping(ItemGrouping::None);

		QList<QMap<QString, QString> > products;

		QDomDocument doc("mydocument");
		if (!doc.setContent(xmldata)) {
			return;
		}

		//Get the root element
		QDomElement docElem = doc.documentElement();

		// you could check the root tag name here if it matters
		QString rootTag = docElem.tagName(); // == persons

		// get the node's interested in, this time only caring about products
		QDomNodeList nodeList = docElem.elementsByTagName("product");

		// Container for products
		ListView *shopContainer = root->findChild<ListView*>("shopList");
		//ShopItem *productItem;

		//Check each node one by one.
		QMap<QString, QVariant> product;
		for (int ii = 0; ii < nodeList.count(); ii++) {

			// get the current one as QDomElement
			QDomElement el = nodeList.at(ii).toElement();

			//get all data for the element, by looping through all child elements
			QDomNode pEntries = el.firstChild();
			while (!pEntries.isNull()) {
				QDomElement peData = pEntries.toElement();
				QString tagNam = peData.tagName();

				if (tagNam == "productname") {
					product["productname"] = peData.text();
				} else if (tagNam == "productprice") {
					product["productprice"] = peData.text();
				} else if (tagNam == "productnumcards") {
					product["productnumcards"] = peData.text();
				} else if (tagNam == "productid") {
					product["productid"] = peData.text();
				} else if (tagNam == "productthumb") {
					product["productthumb"] = peData.text();
				}
				pEntries = pEntries.nextSibling();
			}
			model->insert(product);
			//productItem = new ShopItem(shopContainer);
			//product->updateItem();
		}

		shopContainer->setDataModel(model);

		ShopItemFactory *itemfactory = new ShopItemFactory();
		shopContainer->setListItemProvider(itemfactory);

		connect(shopContainer, SIGNAL(triggered(const QVariantList)), this,
				SLOT(onNewFruitChanged(const QVariantList)));
	}
	else
	{
		qDebug() << "\n Problem with the network";
		qDebug() << "\n" << reply->errorString();
	}

	mActivityIndicator->stop();
}
