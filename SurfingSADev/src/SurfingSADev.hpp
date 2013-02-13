// Navigation pane project template
#ifndef SurfingSADev_HPP_
#define SurfingSADev_HPP_

#include "functionality/Login.h"
#include "functionality/Album.h"
#include "functionality/AlbumView.h"
#include "functionality/Weather.h"
#include "functionality/Auction.h"
#include "functionality/Credits.h"
#include "functionality/Friends.h"
#include "functionality/InviteFriend.h"
#include "functionality/Notifications.h"
#include "functionality/Redeem.h"
#include "functionality/Shop.h"
#include "functionality/ImageLoader.h"
#include "functionality/Registration.h"
#include "functionality/Card.h"
#include "functionality/Purchase.h"
#include "functionality/Booster.h"
#include "functionality/AuctionCategories.h"
#include "functionality/AuctionList.h"
#include "functionality/AuctionCreate.h"
#include "functionality/OnAuctionList.h"
#include "functionality/AuctionInfo.h"
#include "functionality/Scoring.h"
#include "functionality/HeatScores.h"

#include <bb/cascades/ActivityIndicator>
#include <bb/cascades/AbstractPane>

#include <QObject>

namespace bb {
	namespace cascades {
		class Application;
		class AbstractPane;
		class ActivityIndicator;
	}
}

/*!
 * @brief Application pane object
 *
 *Use this object to create and init app UI, to create context objects, to register the new meta types etc.
 */
class SurfingSADev : public QObject
{
    Q_OBJECT
public:
    SurfingSADev(bb::cascades::Application *app);
    virtual ~SurfingSADev() {}

    Q_INVOKABLE QString loggedIn();

    //functionality classes
    Login *mLogin;
    Album *mAlbum;
    AlbumView *mAlbumView;
    Weather *mWeather;
    Auction *mAuction;
    Credits *mCredits;
    Friends *mFriends;
    InviteFriend *mInviteFriend;
    Notifications *mNotifications;
    Redeem *mRedeem;
    Shop *mShop;
    ImageLoader *mImageLoader;
    Registration *mRegistration;
    Card *mCard;
    Purchase *mPurchase;
    Booster *mBooster;
    AuctionCategories *mAuctionCategories;
    AuctionList *mAuctionList;
    AuctionCreate *mAuctionCreate;
    OnAuctionList *mOnAuctionList;
    AuctionInfo *mAuctionInfo;
    Scoring *mScoring;
    HeatScores *mHeatScores;

private:
	AbstractPane *root;
};

#endif /* SurfingSADev_HPP_ */
