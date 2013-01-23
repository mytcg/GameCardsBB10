// Navigation pane project template
#ifndef SurfingSA_HPP_
#define SurfingSA_HPP_

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

#include <QObject>

namespace bb {
	namespace cascades {
		class Application;
	}
}



/*!
 * @brief Application pane object
 *
 *Use this object to create and init app UI, to create context objects, to register the new meta types etc.
 */
class SurfingSA : public QObject
{
    Q_OBJECT
public:
    SurfingSA(bb::cascades::Application *app);
    virtual ~SurfingSA() {}

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
};

#endif /* SurfingSA_HPP_ */
