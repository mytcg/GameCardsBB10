// Navigation pane project template
#include "SurfingSADev.hpp"

#include <QFile>
#include <QTextStream>

#include <bb/data/XmlDataAccess>
#include <bb/cascades/Application>
#include <bb/cascades/QmlDocument>
#include <bb/cascades/AbstractPane>
#include <bb/cascades/DropDown>

using namespace bb::cascades;
using namespace bb::data;

SurfingSADev::SurfingSADev(bb::cascades::Application *app)
: QObject(app)
{
    // create scene document from main.qml asset
    // set parent to created document to ensure it exists for the whole application lifetime
    QmlDocument *qml = QmlDocument::create("asset:///main.qml").parent(this);

    // Expose this class to QML so that we can call its functions from there
	qml->setContextProperty("app", this);

    // create root object for the UI
	root = qml->createRootObject<AbstractPane>();
    // set created root object as a scene
    app->setScene(root);

    //create the functionality classes
    mLogin = new Login(root);
    mAlbum = new Album(root);
    mAlbumView = new AlbumView(root);
    mWeather = new Weather(root);
    mAuction = new Auction(root);
    mCredits = new Credits(root);
    mFriends = new Friends(root);
    mInviteFriend = new InviteFriend(root);
    mNotifications = new Notifications(root);
    mRedeem = new Redeem(root);
    mRegistration = new Registration(root);
    mShop = new Shop(root);
    mCard = new Card(root);
    mPurchase = new Purchase(root);
    mBooster = new Booster(root);
    mAuctionCategories = new AuctionCategories(root);
    mAuctionList = new AuctionList(root);
    mAuctionCreate = new AuctionCreate(root);
    mOnAuctionList = new OnAuctionList(root);
    mAuctionInfo = new AuctionInfo(root);
    mScoring = new Scoring(root);
    mHeatScores = new HeatScores(root);

    //set the functionality classes to the context
    qml->setContextProperty("loginClass", mLogin);
    qml->setContextProperty("albumClass", mAlbum);
    qml->setContextProperty("albumViewClass", mAlbumView);
    qml->setContextProperty("weatherClass", mWeather);
    qml->setContextProperty("auctionClass", mAuction);
    qml->setContextProperty("creditsClass", mCredits);
    qml->setContextProperty("friendsClass", mFriends);
    qml->setContextProperty("invitefriendClass", mInviteFriend);
    qml->setContextProperty("notificationsClass", mNotifications);
    qml->setContextProperty("redeemClass", mRedeem);
    qml->setContextProperty("shopClass", mShop);
    qml->setContextProperty("imageloaderClass", mImageLoader);
    qml->setContextProperty("registerClass", mRegistration);
    qml->setContextProperty("cardClass", mCard);
    qml->setContextProperty("purchaseClass", mPurchase);
    qml->setContextProperty("boosterClass", mBooster);
    qml->setContextProperty("auctionCategoriesClass", mAuctionCategories);
    qml->setContextProperty("auctionListClass", mAuctionList);
    qml->setContextProperty("auctionCreateClass", mAuctionCreate);
    qml->setContextProperty("onAuctionListClass", mOnAuctionList);
    qml->setContextProperty("auctionInfoClass", mAuctionInfo);
    qml->setContextProperty("scoringClass", mScoring);
    qml->setContextProperty("heatScoreClass", mHeatScores);
}

QString SurfingSADev::loggedIn() {
	QFile *file = new QFile("data/userdata.xml");

	if (!file->open(QIODevice::ReadWrite)) {
		qDebug() << "\n Failed to open file";
		return "Error reading file";
	}
	else {
		QTextStream fileStream(file);

		QString str = fileStream.readAll();

		file->close();

		if (str.length() > 0) {
			return "true";
		}
		else {
			return "false";
		}
	}
}
