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

#include <bb/platform/bbm/Context>
#include <bb/platform/bbm/RegistrationState>
#include <bb/system/SystemUiResult>

#include <QObject>
#include <QUuid>

namespace bb {
	namespace cascades {
		class Application;
		class AbstractPane;
		class ActivityIndicator;
	}

	namespace platform
	{
		namespace bbm
		{
			class Context;
			class MessageService;
		}
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
    SurfingSADev(bb::cascades::Application *app, const QUuid &uuid);
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

	/*
	 * all the functions and variables needed to register the app with bbm
	 */
// Flag indicating whether the application is successfully registered
	// with BBM.
	Q_PROPERTY(bool allowed READ isAllowed NOTIFY stateChanged)

	// The status message describing the registration process.
	Q_PROPERTY(QString statusMessage READ statusMessage NOTIFY stateChanged)

	// Flag indicating whether registration failed due to a temporary error.
	// This allows the user to re-try registration.
	Q_PROPERTY(bool temporaryError READ isTemporaryError NOTIFY stateChanged)

public:
	// Enumerates the possible registration progress states.
	struct BbmRegistrationProgress
	{
		enum Type {
			// Registration has not started and has never been attempted since
			// the application started.
			NotStarted = 0,
			// Registration has started.
			Started,
			// Registration is in progress.
			Pending,
			// Registration is done. Use isRegistered() or
			// Context::isAccessAllowed() to check if the application is
			// registered successfully.
			Finished
		};
	};

	/**
	 * Returns the BBM context that is associated with this application.
	 */
	bb::platform::bbm::Context& context()
	{ return m_context; }

	/**
	 * Returns the registration progress.
	 * @see BbmRegistrationProgress::Type
	 */
	BbmRegistrationProgress::Type progress() const
	{ return m_progress; }

public Q_SLOTS:
	/**
	 * This method is called to trigger the registration with the BBM Social
	 * Platform. Check the progress prior to calling this function to ensure
	 * that another registration is not in progress.
	 */
	void registerApplication();

Q_SIGNALS:
	// The change notification signal of the properties.
	void stateChanged();

private Q_SLOTS:
	// This slot is invoked whenever the registration status is changed.
	// This will initiate, continue, or finish registration based on the status.
	// @param state is the registration state
	void processRegistrationStatus(const bb::platform::bbm::RegistrationState::Type state);

	// This slot is invoked when the uuid is invalid or NULL.
	// This will cause the application to exit with error code -1
	// @param value is the system ui result indicating which button was pressed
	void dialogFinished(bb::system::SystemUiResult::Type value);

private:
	// Return true if registration has completed successfully.
	bool isAllowed() const
	{ return m_isAllowed; }

	// Return true if registration failed due to a temporary error.
	bool isTemporaryError() const
	{ return m_temporaryError; }

	// Return the message that describes the registration state.
	const QString& statusMessage() const
	{ return m_statusMessage; }

	// Registration finished. This method updates m_registered, m_statusMessage,
	// and m_progress. It emits a stateChanged() signal.
	void registrationFinished();

	// BBM Social Platform Context used to gain access to BBM functionality.
	bb::platform::bbm::Context m_context;

	// A flag that indicates whether registration completed successfully.
	bool m_isAllowed;

	// Registration progress. Use this to check if you have already attempted
	// registration, if registration has finished, or it's still in progress.
	BbmRegistrationProgress::Type m_progress;

	// A flag that indicates whether registration failed due to a temporary
	// error.
	bool m_temporaryError;

	// A status message that describes the current state of registration.
	QString m_statusMessage;

	/*
	 * function for inviting contacts to download the app
	 */
public:
    // This method is invoked to open the invitation dialog
    Q_INVOKABLE void sendInvite();

private:
    // The service object to send BBM messages
    bb::platform::bbm::MessageService* m_messageService;
};

#endif /* SurfingSADev_HPP_ */
