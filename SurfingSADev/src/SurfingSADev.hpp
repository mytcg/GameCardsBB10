// Navigation pane project template
#ifndef SurfingSADev_HPP_
#define SurfingSADev_HPP_

#include "functionality/Login.h"
#include "functionality/Album.h"
#include "functionality/Auction.h"
#include "functionality/Credits.h"
#include "functionality/Friends.h"
#include "functionality/InviteFriend.h"
#include "functionality/Notifications.h"
#include "functionality/Redeem.h"
#include "functionality/Shop.h"

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
    Auction *mAuction;
    Credits *mCredits;
    Friends *mFriends;
    InviteFriend *mInviteFriend;
    Notifications *mNotifications;
    Redeem *mRedeem;
    Shop *mShop;
};

#endif /* SurfingSADev_HPP_ */
