// Navigation pane project template
#include "SurfingSADev.hpp"

#include <QFile>
#include <QTextStream>

#include <bb/data/XmlDataAccess>
#include <bb/data/DataSource>

#include <bb/device/DisplayInfo>

#include <bb/cascades/Application>
#include <bb/cascades/QmlDocument>
#include <bb/cascades/AbstractPane>
#include <bb/cascades/DropDown>

#include <bb/system/SystemDialog>

#include <bb/platform/bbm/Context>
#include <bb/platform/bbm/RegistrationState>
#include <bb/platform/bbm/MessageService>

using namespace bb::cascades;
using namespace bb::data;
using namespace bb::device;
using namespace bb::platform::bbm;
using namespace bb::system;

SurfingSADev::SurfingSADev(bb::cascades::Application *app, const QUuid &uuid)
: QObject(app)
, m_context(uuid)
, m_isAllowed(false)
, m_progress(BbmRegistrationProgress::NotStarted)
, m_temporaryError(false)
, m_statusMessage(tr("Please wait while the application connects to BBM."))
, m_messageService(0)
{
	bb::data::DataSource::registerQmlTypes();
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

    DisplayInfo display;
    int width = display.pixelSize().width();
    int height = display.pixelSize().height();

    QDeclarativePropertyMap* displayProperties = new QDeclarativePropertyMap;
    displayProperties->insert("width", QVariant(width));
    displayProperties->insert("height", QVariant(height));

    qml->setContextProperty("DisplayInfo", displayProperties);

    //check the the uuid is valid
    if (uuid.isNull()) {
		SystemDialog *uuidDialog = new SystemDialog("OK");
		uuidDialog->setTitle("UUID Error");
		uuidDialog->setBody("Invalid/Empty UUID, failed to register with BBM, please set correctly in main.cpp");
		connect(uuidDialog, SIGNAL(finished(bb::system::SystemUiResult::Type)), this, SLOT(dialogFinished(bb::system::SystemUiResult::Type)));
		uuidDialog->show();
		return;
	}
	connect(&m_context,
			SIGNAL(registrationStateUpdated(
				   bb::platform::bbm::RegistrationState::Type)),
			this,
			SLOT(processRegistrationStatus(
				 bb::platform::bbm::RegistrationState::Type)));
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

void SurfingSADev::registerApplication() {
	qDebug() << "\n QFile::exists(\"data/registered.xml\")" << QFile::exists("data/registered.xml");
	if (!QFile::exists("data/registered.xml")) {
		m_progress = BbmRegistrationProgress::Started;
		processRegistrationStatus(m_context.registrationState());
	}
}

void SurfingSADev::processRegistrationStatus(const RegistrationState::Type state) {
    // Based on the state, decide whether we need to register. If we already
    // registered successfully once (i.e. on a previous application run), then
    // we will not call requestRegisterApplication() again.
    qDebug() << "\nReceived a BBM Social Platform registration access state="
        << state;
    switch(m_progress)
    {
    case BbmRegistrationProgress::Pending:
        if (state != RegistrationState::Pending) {
            registrationFinished();
            return;
        }
        // Otherwise, ignore since registration is still in progress.
        break;

    case BbmRegistrationProgress::Started:
        if (m_context.isAccessAllowed()) {
            // Access is allowed, the application is registered.
            registrationFinished();
            return;
        }
        if (m_context.registrationState() == RegistrationState::Unknown) {
            // Status is not yet known. Wait for an event that will deliver the
            // status.
            qDebug() << "\nBBM Social Platform access state is UNKNOWN; waiting "
                "for the initial status";
            return;
        }
        // Start registration.
        if (m_context.requestRegisterApplication()) {
            // Registration started. The user will see a dialog informing them
            // that your application is connecting to BBM.
            m_progress = BbmRegistrationProgress::Pending;
            qDebug() << "\nBBM Social Platform registration started";
            qDebug() << "\nVerify you are using a valid UUID";
            return;
        }
        // Could not start registration. No dialogs were shown.
        qDebug() << "\nBBM Social Platform registration could not be started";
        registrationFinished();
        break;

    case BbmRegistrationProgress::Finished:
        if (m_context.isAccessAllowed() != m_isAllowed) {
            // Access to the BBM Social Platform has changed.
            registrationFinished();
        }
        break;

    default:
        qDebug() << "\nIgnoring BBM Social Platform access state=" << state
            << "when progress=" << m_progress;
        break;
    }
}

void SurfingSADev::registrationFinished() {
    // Finish registration and use the state to decide which message to show
    // the user.
    m_progress = BbmRegistrationProgress::Finished;
    switch (m_context.registrationState()) {
    case RegistrationState::Allowed:
        m_statusMessage = tr("Application connected to BBM.  Press Continue.");
        m_temporaryError = false;
        break;

// This error code is not yet available in the NDK.
//    case RegistrationState::BbmDisabled:
//        m_statusMessage = tr("Cannot connect to BBM. BBM is not setup. "
//                             "Open BBM to set it up and try again.");
//        m_temporaryError = false;
//        break;

    case RegistrationState::BlockedByRIM:
        m_statusMessage = tr("Disconnected by RIM. RIM is preventing this "
                             "application from connecting to BBM.");
        m_temporaryError = false;
        break;

    case RegistrationState::BlockedByUser:
        m_statusMessage = tr("Disconnected. Go to Settings -> Security and "
                             "Privacy -> Application Permissions and "
                             "connect this application to BBM.");
        m_temporaryError = false;
        break;

    case RegistrationState::InvalidUuid:
        // You should be resolving this error at development time.
        m_statusMessage = tr("Invalid UUID. Report this error to the "
                             "vendor.");
        m_temporaryError = true;
        break;

    case RegistrationState::MaxAppsReached:
        m_statusMessage = tr("Too many applications are connected to BBM. "
                             "Uninstall one or more applications and try "
                             "again.");
        m_temporaryError = false;
        break;

    case RegistrationState::Expired:
    case RegistrationState::MaxDownloadsReached:
        m_statusMessage = tr("Cannot connect to BBM. Download this "
                             "application from AppWorld to keep using it.");
        m_temporaryError = false;
        break;

    case RegistrationState::NoDataConnection:
        m_statusMessage = tr("Check your Internet connection and try again.");
        m_temporaryError = true;
        break;

    case RegistrationState::Pending:
        // The user will never see this. The BBM Social Platform already
        // displays a "Connecting" dialog.
        m_statusMessage = tr("Connecting to BBM. Please wait.");
        m_temporaryError = false;
        break;

    case RegistrationState::Unknown:
        m_statusMessage = tr("Determining the status. Please wait.");
        m_temporaryError = false;
        break;

    case RegistrationState::Unregistered:
    case RegistrationState::UnexpectedError:
    case RegistrationState::TemporaryError:
    case RegistrationState::CancelledByUser:
    default:
        // If new error codes are added, treat them as temporary errors.
        m_statusMessage = tr("Would you like to connect the application to "
                             "BBM?");
        m_temporaryError = true;
        break;
    }

    if (m_context.isAccessAllowed()) {
        m_isAllowed = true;
    } else {
        m_isAllowed = false;
    }
    qDebug() << "\nFinished BBM Social Platform registration, success="
        << m_isAllowed << "temporaryError=" << m_temporaryError;
    emit stateChanged();
}

void SurfingSADev::dialogFinished(bb::system::SystemUiResult::Type value) {
	Application::exit(-1);
}

void SurfingSADev::sendInvite() {
    if (!m_messageService) {
        // Instantiate the MessageService.
        m_messageService = new bb::platform::bbm::MessageService(&m_context, this);
    }

    // Trigger the invite to download process.
    m_messageService->sendDownloadInvitation();
}
